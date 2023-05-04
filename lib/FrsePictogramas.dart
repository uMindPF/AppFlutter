import 'package:flutter/cupertino.dart';

import 'Pictograma.dart';

class FrasePictogramas {
  static List<Pictograma> frasePictogramas = [];

  static void addPictograma(Pictograma pictograma) {
    if (frasePictogramas.length <= 6) {
      frasePictogramas.add(pictograma);
    }
  }

  static void limpiarFrase() {
    frasePictogramas = [];
  }

  static List<Widget> getImages() {
    List<Widget> images = [];
    for (var i = 0; i < frasePictogramas.length; i++) {
      images.add(Expanded(
          child: Image.asset(
        frasePictogramas[i].url,
        width: 100,
        height: 100,
      )));
    }
    return images;
  }

  static String getFrase() {
    if (frasePictogramas.length == 0) {
      return '';
    }
    String frase = frasePictogramas
        .map((pictograma) => pictograma.texto)
        .join(' ');
    frase = frase[0].toUpperCase() + frase.substring(1);
    return frase;
  }
}
