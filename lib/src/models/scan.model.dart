import 'package:latlong/latlong.dart';

class Scan {
  Scan({
    this.id,
    this.tipo,
    this.valor,
  }) {
    if (valor.contains("http")) {
      tipo = "http";
    } else {
      tipo = "geo";
    }
  }

  int id;
  String tipo;
  String valor;

  factory Scan.fromJson(Map<String, dynamic> json) => Scan(
        id: json["id"],
        tipo: json["tipo"],
        valor: json["valor"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tipo": tipo,
        "valor": valor,
      };

  getLatLng() {
    final latlong = valor.substring(4).split(",");
    final lat = double.parse(latlong[0]);
    final long = double.parse(latlong[1]);
    return LatLng(lat, long);
  }
}
