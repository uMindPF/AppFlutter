import 'package:flutter/material.dart';
import 'package:proyecto/FrasePictogramas.dart';
import 'package:proyecto/Home.dart';
import 'package:proyecto/Pictogramas.dart';
import 'package:proyecto/modelo/Verbo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'uMind',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff9DDEB0),
        title: Center(child: Image.asset("assets/images/uMindBlanco.png")),
      ),
      body: IndexedStack(
        index: currentIndex,
        children: [
          Home(),
          Pictogramas(Categoria: "Acciones"),
          Pictogramas(Categoria: "Emociones"),
          Pictogramas(Categoria: "Expresiones"),
          Pictogramas(Categoria: "Numeros"),
          Pictogramas(Categoria: "Pronombres"),
        ]
            .map((widget) => KeyedSubtree(
                  key: UniqueKey(),
                  child: widget,
                ))
            .toList(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          if (currentIndex != index) {
            setState(() {
              currentIndex = index;
            });
          }
        },
        fixedColor: Colors.black,
        unselectedItemColor: Colors.grey,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: const Color(0xff9DDEB0),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_run),
            label: 'Acciones',
            backgroundColor: const Color(0xff9DDEB0),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_emotions),
            label: 'Emociones',
            backgroundColor: const Color(0xff9DDEB0),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.abc),
            label: 'Expresiones',
            backgroundColor: const Color(0xff9DDEB0),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.numbers),
            label: 'Numeros',
            backgroundColor: const Color(0xff9DDEB0),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Pronombres',
            backgroundColor: const Color(0xff9DDEB0),
          ),
        ],
      ),
    );
  }
}
