import 'dart:async';

import 'package:qrscanner/src/models/scan.model.dart';

class Validators {
  final validarGeo = StreamTransformer<List<Scan>, List<Scan>>.fromHandlers(
    handleData: (scans, sink) {
      final geoScans = scans.where((s) => s.tipo == "geo").toList();
      sink.add(geoScans);
    },
  );
  final validarHttp = StreamTransformer<List<Scan>, List<Scan>>.fromHandlers(
    handleData: (scans, sink) {
      final geoScans = scans.where((s) => s.tipo == "http").toList();
      sink.add(geoScans);
    },
  );
}
