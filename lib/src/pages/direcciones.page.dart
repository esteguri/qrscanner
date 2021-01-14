import 'package:flutter/material.dart';
import 'package:qrscanner/src/bloc/scans.bloc.dart';
import 'package:qrscanner/src/models/scan.model.dart';
import 'package:qrscanner/src/utils/utils.dart' as Utils;

class DireccionesPage extends StatelessWidget {
  final scansBloc = ScansBloc();

  @override
  Widget build(BuildContext context) {
    scansBloc.obtenerScans();

    return StreamBuilder(
      stream: scansBloc.scansStreamHttp,
      builder: (_, AsyncSnapshot<List<Scan>> snapshot) {
        if (snapshot.hasData) {
          final scans = snapshot.data;
          if (scans.length == 0) {
            return Center(child: Text("No hay datos que mostrar"));
          } else {
            return ListView.builder(
              itemCount: scans.length,
              itemBuilder: (_, i) => Dismissible(
                key: UniqueKey(),
                background: Container(color: Colors.red),
                onDismissed: (direction) => scansBloc.borrarScan(scans[i].id),
                child: ListTile(
                  onTap: () {
                    Utils.launchURL(scans[i], context);
                  },
                  leading: Icon(
                    Icons.cloud_queue,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: Text(scans[i].valor),
                  subtitle: Text("ID: ${scans[i].id}"),
                  trailing: Icon(
                    Icons.keyboard_arrow_right,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            );
          }
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
