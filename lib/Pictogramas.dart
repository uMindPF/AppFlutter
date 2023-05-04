import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:proyecto/FrsePictogramas.dart';
import 'package:flutter_tts/flutter_tts.dart';

import 'Pictograma.dart';

class Pictogramas extends StatefulWidget {
  const Pictogramas({Key? key, required this.Categoria}) : super(key: key);

  final String Categoria;

  @override
  State<StatefulWidget> createState() => PictogramasPage(categoria: Categoria);
}

class PictogramasPage extends State<Pictogramas> {
  PictogramasPage({required this.categoria});
  final String categoria;
  List<Pictograma> pictogramas = [];

  @override
  Widget build(BuildContext context) {
    chargePictogramas();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: FrasePictogramas.getImages(),
            ),
            Text(FrasePictogramas.getFrase()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      FrasePictogramas.limpiarFrase();
                    });
                  },
                  child: const Text('Limpiar'),
                ),
                ElevatedButton(
                  onPressed: () {
                    FlutterTts flutterTts = FlutterTts();
                    flutterTts.setLanguage("es-ES");
                    flutterTts.speak(FrasePictogramas.frasePictogramas
                        .map((pictograma) => pictograma.texto)
                        .join(' '));
                  },
                  child: const Text('Reproducir'),
                ),
              ],
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount:
                    MediaQuery.of(context).orientation == Orientation.landscape
                        ? 6
                        : 3,
                children: List.generate(pictogramas.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        FrasePictogramas.addPictograma(pictogramas[index]);
                      });
                    },
                    child: Column(
                      children: [
                        Image.asset(
                          pictogramas[index].url,
                          width: 100,
                          height: 100,
                        ),
                        Text(pictogramas[index].nombre),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> chargePictogramas() async {
    String jsonString =
        await rootBundle.loadString('assets/JSON/' + categoria + '.json');

    var pictogramas = jsonDecode(jsonString)['pictogramas'] as List;
    List<Pictograma> pictogramasList = pictogramas
        .map((pictogramaJson) => Pictograma.fromJson(pictogramaJson))
        .toList();

    setState(() {
      this.pictogramas = pictogramasList;
    });
  }
}
