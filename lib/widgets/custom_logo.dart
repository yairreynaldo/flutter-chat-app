import 'package:flutter/material.dart';

class CustomLogo extends StatelessWidget {
  final String titulo;

  const CustomLogo({super.key, required this.titulo});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 170,
        margin: const EdgeInsets.only(top: 50),
        child: Column(
          children: [
            const Image(image: AssetImage('assets/tag-logo.png')),
            const SizedBox(height: 20),
            Text(titulo, style: TextStyle(fontSize: 30)),
          ],
        ),
      ),
    );
  }
}
