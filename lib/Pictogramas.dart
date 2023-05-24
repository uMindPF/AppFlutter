import 'dart:convert';
import 'dart:io';

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
                constraints: const BoxConstraints(
                  minHeight: 100,
                ),
                padding: const EdgeInsets.only(top: 20),
                child: DragTarget<Pictograma>(
                  builder:
                      (context, List<Pictograma?> candidateData, rejectedData) {
                    return Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.2,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xff4DAA4F),
                          width: 4,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: FrasePictogramas.getImages(),
                        ),
                      ),
                    );
                  },
                  onWillAccept: (data) {
                    return true;
                  },
                  onAccept: (data) {
                    setState(() {
                      FrasePictogramas.addPictograma(data);
                    });
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ConstrainedBox(
                    constraints: const BoxConstraints(minHeight: 20),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                          child: Text(
                            FrasePictogramas.getFrase(),
                            textAlign: TextAlign.center,
                          ),
                      ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: Row(
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
                          width: 40,
                          height: 40,
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
                            width: 35,
                            height: 35,
                          )),
                      MaterialButton(
                        onPressed: () {
                          setState(() {
                            FrasePictogramas.retroceder();
                          });
                        },
                        child: Image.asset(
                          'assets/iconos/retroceder.png',
                          width: 40,
                          height: 40,
                        ),
                      ),
                    ]),
                  )
                ],
              ),
              Expanded(
                child: GridView.count(
                  controller: ScrollController(),
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
                      child: LongPressDraggable<Pictograma>(
                        data: pictogramas[index],
                        dragAnchorStrategy: pointerDragAnchorStrategy,
                        feedback: Container(
                          width: MediaQuery.of(context).size.width * 0.15,
                          height: MediaQuery.of(context).size.height * 0.15,
                          child: imageWidget(pictogramas[index]),
                        ),
                        child: Stack(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(
                                  MediaQuery.of(context).size.width * 0.03),
                              child: imageWidget(pictogramas[index]),
                            ),
                            Container(
                              alignment: Alignment.bottomCenter,
                              padding: const EdgeInsets.all(3),
                              child: Text(pictogramas[index].nombre),
                            ),
                            GestureDetector(
                              onTap: () {
                                changeImage(pictogramas[index], index);
                              },
                              child: Container(
                                alignment: Alignment.topRight,
                                padding: const EdgeInsets.all(3),
                                child: Image.asset(
                                  'assets/iconos/plus.png',
                                  width: 30,
                                  height: 30,
                                ),
                              ),
                            ),
                          ],
                        ),
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

  Widget imageWidget(Pictograma pictograma) {
    if (pictograma.custom == false) {
      return Image.asset(
        pictograma.url,
      );
    } else {
      return Image.file(
        File(pictograma.url),
      );
    }
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
