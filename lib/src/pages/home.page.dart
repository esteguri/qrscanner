import 'package:flutter/material.dart';
import 'package:qrscanner/src/bloc/scans.bloc.dart';
import 'package:qrscanner/src/models/scan.model.dart';
import 'package:qrscanner/src/pages/direcciones.page.dart';
import 'package:qrscanner/src/pages/mapas.page.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:qrscanner/src/utils/utils.dart' as Utils;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int paginaActual = 0;
  final scansBloc = ScansBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QRScanner"),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: scansBloc.borrarScans,
          )
        ],
      ),
      body: _callPage(paginaActual),
      bottomNavigationBar: _crearBottomNavigation(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.filter_center_focus),
        onPressed: () => _scanQR(context),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void _scanQR(context) async {
    String cameraScanResult = await scanner.scan();

    //String cameraScanResult = "geo:6.196572603676928,-75.58025428489282";
    //String cameraScanResult = "http://estebangutierrez.com/";

    if (cameraScanResult != null) {
      Scan newScan = Scan(valor: cameraScanResult);
      scansBloc.agregarScan(newScan);

      Utils.launchURL(newScan, context);
    }
  }

  Widget _callPage(int paginaActual) {
    switch (paginaActual) {
      case 0:
        return MapasPage();
      case 1:
        return DireccionesPage();
      default:
        return MapasPage();
    }
  }

  Widget _crearBottomNavigation() {
    return BottomNavigationBar(
      currentIndex: paginaActual,
      onTap: (index) {
        setState(() {
          paginaActual = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          label: "Mapas",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.brightness_high),
          label: "Direcciones",
        ),
      ],
    );
  }
}
