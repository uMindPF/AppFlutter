import 'package:flutter/material.dart';
import 'package:proyecto/Home.dart';
import 'package:proyecto/Pictogramas.dart';


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
      home: const MyHomePage(title: 'uMind'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex = 0;

  String fraseText = "Hola";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body:
      IndexedStack(
        index: currentIndex,
        children: [
          Home(),
          Pictogramas(Categoria: "Acciones"),
          Pictogramas(Categoria: "Emociones"),
          Pictogramas(Categoria: "Expresiones"),
          Pictogramas(Categoria: "Numeros"),
          Pictogramas(Categoria: "Pronombres"),
        ].map((widget) => KeyedSubtree(
          key: UniqueKey(),
          child: widget,
        )).toList(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        fixedColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_run),
            label: 'Acciones',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_emotions),
            label: 'Emociones',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.abc),
            label: 'Expresiones',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.numbers),
            label: 'Numeros',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Pronombres',
          ),
        ],
      ),

    );
  }
}
