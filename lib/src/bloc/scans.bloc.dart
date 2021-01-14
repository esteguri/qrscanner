import 'dart:async';

import 'package:qrscanner/src/bloc/validator.dart';
import 'package:qrscanner/src/providers/db.provider.dart';

class ScansBloc with Validators {
  static final ScansBloc _singleton = ScansBloc._internal();

  factory ScansBloc() {
    return _singleton;
  }

  ScansBloc._internal() {
    obtenerScans();
  }

  final _scansController = StreamController<List<Scan>>.broadcast();

  Stream<List<Scan>> get scansStream =>
      _scansController.stream.transform(validarGeo);
  Stream<List<Scan>> get scansStreamHttp =>
      _scansController.stream.transform(validarHttp);

  dispose() {
    _scansController?.close();
  }

  obtenerScans() async {
    _scansController.sink.add(await DBProvider.db.getScans());
  }

  agregarScan(Scan scan) async {
    await DBProvider.db.newScan(scan);
    obtenerScans();
  }

  borrarScan(int id) async {
    await DBProvider.db.deleteScan(id);
    obtenerScans();
  }

  borrarScans() async {
    await DBProvider.db.deleteAll();
    obtenerScans();
  }
}
