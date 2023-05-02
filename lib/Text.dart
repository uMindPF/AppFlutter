import 'package:flutter/material.dart';

class Frase {
  static String fraseText = "Hola";

  static void setFrase(String frase) {
    fraseText = frase;
  }

  static String getFrase() {
    return fraseText;
  }

  static void addPalabra(String palabra) {
    fraseText = fraseText + " " + palabra;
  }

  static void limpiarFrase() {
    fraseText = "";
  }
}