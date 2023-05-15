import 'dart:convert';

class Conjugacion {
  String nombre;
  String yo;
  String tu;
  String el;
  String ella;
  String nosotros;
  String nosotras;
  String vosotros;
  String vosotras;
  String ellos;
  String ellas;

  Conjugacion(this.nombre, this.yo, this.tu, this.el, this.ella, this.nosotros,
      this.nosotras, this.vosotros, this.vosotras, this.ellos, this.ellas);

  factory Conjugacion.fromJson(dynamic json) {
    return Conjugacion(
        json['nombre'] as String,
        json['yo'] as String,
        json['tu'] as String,
        json['el'] as String,
        json['ella'] as String,
        json['nosotros'] as String,
        json['nosotras'] as String,
        json['vosotros'] as String,
        json['vosotras'] as String,
        json['ellos'] as String,
        json['ellas'] as String);
  }
}
