import 'package:qrscanner/src/models/scan.model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

launchURL(Scan scan, context) async {
  if (scan.tipo == "http") {
    if (await canLaunch(scan.valor)) {
      await launch(scan.valor);
    } else {
      throw 'Could not launch $scan.valor';
    }
  } else {
    Navigator.pushNamed(context, "mapa", arguments: scan);
  }
}
