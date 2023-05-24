import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          child: Stack(
            children: [
              Center(
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    const Text("PECS",
                        style: TextStyle(fontSize: 80, color: Colors.blue)),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: const Text(
                          "¡UMIND PECS: Comunícate fácilmente a través de imágenes! Ideal para personas con dificultades en el lenguaje o la comunicación, esta aplicación les permite expresarse visualmente. Con categorías predefinidas y la opción de agregar imágenes personalizadas, pueden comunicar sus necesidades y sentimientos de manera clara. Además, la traducción de imágenes a audio completa la experiencia, brindándoles una comunicación efectiva y enriquecedora.",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 30, color: Colors.blue)),
                    ),
                  ],
                ),
              ),
              Image.asset(
                "assets/images/home.png",
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.bottomCenter,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
