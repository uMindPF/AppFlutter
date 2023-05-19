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
        fontFamily: 'Childlet',
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
        toolbarHeight: 80,
        backgroundColor: const Color(0xff9DDEB0),
        centerTitle: true,
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
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Color(0xff9DDEB0),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            if (currentIndex != index) {
              setState(() {
                currentIndex = index;
              });
            }
          },
          fixedColor: Colors.black87,
          unselectedItemColor: Colors.white,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Color(0xff9DDEB0),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.directions_run),
              label: 'Acciones',
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.emoji_emotions),
              label: 'Emociones',
              backgroundColor: Colors.green,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.abc),
              label: 'Expresiones',
              backgroundColor: Colors.pinkAccent,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.numbers),
              label: 'Numeros',
              backgroundColor: Colors.yellow,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Pronombres',
              backgroundColor: Colors.deepPurpleAccent,
            ),
          ],
        ),
      ),
    );
  }
}
