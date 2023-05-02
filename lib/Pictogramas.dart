import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proyecto/Text.dart';

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
            Text("Frase: " + Frase.fraseText),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  Frase.limpiarFrase();
                });
              },
              child: const Text('Limpiar'),
            ),

            /*
            Text("Json" + pictogramas[0].texto),
            GestureDetector(
              onTap: () {
                print('Image Clicked');
                setState(() {
                  Frase.addPalabra("Hola");
                });
              },
              child: Image.network(
                'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
                width: 100,
                height: 100,
              ),
            ),
            */
            // foreach of pictogramas
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                children: List.generate(pictogramas.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      print('Image Clicked');
                      setState(() {
                        Frase.addPalabra(pictogramas[index].texto);
                      });
                    },
                    child: Image.asset(
                      pictogramas[index].url,
                      width: 100,
                      height: 100,
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
    String jsonString = await rootBundle.loadString('assets/JSON/'+ categoria +'.json');

    var pictogramas = jsonDecode(jsonString)['pictogramas'] as List;
    List<Pictograma> pictogramasList = pictogramas.map((pictogramaJson) => Pictograma.fromJson(pictogramaJson)).toList();


    setState(() {
      this.pictogramas = pictogramasList;
    });
  }
}