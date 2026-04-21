import 'package:flutter/material.dart';
import 'views/homeView.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Generator',
      debugShowCheckedModeBanner: false,

      // 👇 SUA TELA INICIAL
      home: const HomeView(),

      // 👇 Tema básico (opcional, mas bom já deixar)
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
    );
  }
}
