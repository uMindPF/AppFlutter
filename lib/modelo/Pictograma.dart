class Pictograma {
  String nombre;
  String texto;
  String url;
  String categoria;
  bool custom = false;

  Pictograma(this.nombre, this.texto, this.url, this.categoria);

  factory Pictograma.fromJson(dynamic json) {
    return Pictograma(json['nombre'] as String, json['texto'] as String,
        json['url'], json['categoria'] as String);
  }
}
