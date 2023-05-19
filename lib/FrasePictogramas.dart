import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:proyecto/modelo/Verbo.dart';

import 'modelo/Pictograma.dart';

class FrasePictogramas {
  static List<Pictograma> frasePictogramas = [];
  static List<Conjugacion> conjugaciones = [];

  static void addPictograma(Pictograma pictograma) {
    if (frasePictogramas.length < 6) {
      frasePictogramas.add(pictograma);
    } else {
      frasePictogramas.removeAt(0);
      frasePictogramas.add(pictograma);
    }
  }

  static void limpiarFrase() {
    frasePictogramas = [];
  }

  static List<Widget> getImages() {
    List<Widget> images = [];
    for (var pictograma in frasePictogramas) {
      if (pictograma.custom) {
        images.add(Expanded(
            child: Image.file(
          File(pictograma.url),
        )));
      } else {
        images.add(Expanded(
            child: Image.asset(
          pictograma.url,
        )));
      }
    }
    return images;
  }

  static String getFrase() {
    if (frasePictogramas.length == 0) {
      return '';
    }

    String frase = '';
    String pronombre = '';

    for (var pictograma in frasePictogramas) {
      switch (pictograma.categoria) {
        case "pronombres":
          pronombre = pictograma.texto;
          frase += pictograma.texto + ' ';
          break;

        case "acciones":
        case "emociones":
          if (pronombre == '') {
            frase += pictograma.texto + ' ';
            break;
          }

          Conjugacion conjugacion = conjugaciones
              .firstWhere((element) => element.nombre == pictograma.texto);

          switch (pronombre) {
            case "yo":
              frase += conjugacion.yo + ' ';
              break;
            case "tu":
              frase += conjugacion.tu + ' ';
              break;
            case "el":
              frase += conjugacion.el + ' ';
              break;
            case "ella":
              frase += conjugacion.ella + ' ';
              break;
            case "nosotros":
              frase += conjugacion.nosotros + ' ';
              break;
            case "nosotras":
              frase += conjugacion.nosotras + ' ';
              break;
            case "vosotros":
              frase += conjugacion.vosotros + ' ';
              break;
            case "vosotras":
              frase += conjugacion.vosotras + ' ';
              break;
            case "ellos":
              frase += conjugacion.ellos + ' ';
              break;
            case "ellas":
              frase += conjugacion.ellas + ' ';
              break;
          }

          pronombre = '';
          break;
        default:
          frase += pictograma.texto + ' ';
          break;
      }
    }

    frase = frase[0].toUpperCase() + frase.substring(1);

    return frase;
  }

  static Future<void> loadConjugaciones() async {
    if (conjugaciones.isNotEmpty) return;
    String jsonString = await rootBundle.loadString('assets/JSON/verbos.json');
    final jsonResponse = json.decode(jsonString);
    for (var json in jsonResponse) {
      conjugaciones.add(Conjugacion.fromJson(json));
    }
  }

  static void retroceder() {
    if (frasePictogramas.length > 0) {
      frasePictogramas.removeLast();
    }
  }
}
