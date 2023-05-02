class Pictograma {
  String nombre;
  String texto;
  String url;

  Pictograma(this.nombre, this.texto, this.url);

  factory Pictograma.fromJson(dynamic json) {
    return Pictograma(json['nombre'] as String, json['texto'] as String, json['url'] as String);
  }
}