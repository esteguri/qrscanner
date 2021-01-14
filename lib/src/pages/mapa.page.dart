import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:qrscanner/src/models/scan.model.dart';

class MapaPage extends StatelessWidget {
  MapController map = new MapController();

  @override
  Widget build(BuildContext context) {
    final Scan scan = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text("Coordenadas QR"),
        actions: [
          IconButton(
            icon: Icon(Icons.my_location),
            onPressed: () {
              map.move(scan.getLatLng(), 16);
            },
          ),
        ],
      ),
      body: _crearFlutterMap(scan),
      floatingActionButton: _crearBotonFlotante(scan, context),
    );
  }

  Widget _crearBotonFlotante(scan, context) {
    return FloatingActionButton(
      backgroundColor: Theme.of(context).primaryColor,
      child: Icon(
        Icons.my_location,
      ),
      onPressed: () {
        map.move(scan.getLatLng(), 16);
      },
    );
  }

  Widget _crearFlutterMap(Scan scan) {
    return FlutterMap(
      mapController: map,
      options: MapOptions(center: scan.getLatLng(), zoom: 16),
      layers: [_crearMapa(), _crearMarcadores(scan)],
    );
  }

  _crearMapa() {
    return TileLayerOptions(
      urlTemplate: 'https://api.mapbox.com/v4/'
          '{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}',
      additionalOptions: {
        'accessToken':
            'pk.eyJ1IjoiZXN0ZWd1cmkiLCJhIjoiY2tqcnAyaGxpMTBhczJ6cDV3bjhhN2k2bCJ9.JoVrLouG3CBSVcGbHHoxzw',
        'id': 'mapbox.satellite'
      },
    );
  }

  _crearMarcadores(Scan scan) {
    return MarkerLayerOptions(markers: [
      Marker(
        width: 100,
        height: 100,
        point: scan.getLatLng(),
        builder: (_) => Container(
          child: Icon(
            Icons.location_on,
            size: 60,
            color: Theme.of(_).primaryColor,
          ),
        ),
      )
    ]);
  }
}
