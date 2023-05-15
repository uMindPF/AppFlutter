import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:proyecto/FrasePictogramas.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'modelo/Pictograma.dart';

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
    FrasePictogramas.loadConjugaciones();
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/fondo.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                constraints: BoxConstraints(minHeight: 100),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: FrasePictogramas.getImages(),
                ),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(minHeight: 20),
                child: Text(
                  FrasePictogramas.getFrase(),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        FrasePictogramas.limpiarFrase();
                      });
                    },
                    child: Image.asset(
                      'assets/iconos/borrar.png',
                      width: 50,
                      height: 50,
                    ),
                  ),
                  MaterialButton(
                      onPressed: () {
                        FlutterTts flutterTts = FlutterTts();
                        flutterTts.setLanguage("es-ES");
                        flutterTts.speak(FrasePictogramas.getFrase());
                      },
                      child: Image.asset(
                        'assets/iconos/play.png',
                        width: 50,
                        height: 50,
                      )),
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        FrasePictogramas.retroceder();
                      });
                    },
                    child: Image.asset(
                      'assets/iconos/retroceder.png',
                      width: 50,
                      height: 50,
                    ),
                  )
                ],
              ),
              Expanded(
                child: GridView.count(
                  crossAxisCount: MediaQuery.of(context).orientation ==
                          Orientation.landscape
                      ? 6
                      : 3,
                  children: List.generate(pictogramas.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          FrasePictogramas.addPictograma(pictogramas[index]);
                        });
                      },
                      child: Stack(
                        children: [
                          if (pictogramas[index].custom == false)
                            Image.asset(
                              pictogramas[index].url,
                              width: 100,
                              height: 100,
                            )
                          else
                            Image.file(
                              File(pictogramas[index].url),
                              width: 100,
                              height: 100,
                            ),
                          Container(
                            alignment: Alignment.bottomCenter,
                            padding: EdgeInsets.all(3),
                            child: Text(pictogramas[index].nombre),
                          ),
                          GestureDetector(
                            onTap: () {
                              changeImage(pictogramas[index], index);
                            },
                            child: Container(
                              alignment: Alignment.topRight,
                              padding: EdgeInsets.all(3),
                              child: Image.asset(
                                'assets/iconos/plus.png',
                                width: 30,
                                height: 30,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
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

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    for (var pictograma in pictogramasList) {
      if (prefs.containsKey(pictograma.nombre)) {
        pictograma.url = prefs.getString(pictograma.nombre)!;
        pictograma.custom = true;
      }
    }

    setState(() {
      this.pictogramas = pictogramasList;
    });
  }

  Future<void> changeImage(Pictograma pictograma, int index) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png'],
    );
    if (result != null) {
      PlatformFile file = result.files.first;
      pictograma.url = file.path!;

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(pictograma.nombre, pictograma.url);

      setState(() {
        pictogramas[index] = pictograma;
      });
    }
  }
}
