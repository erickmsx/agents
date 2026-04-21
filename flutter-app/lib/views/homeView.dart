import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:html' as html;

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController _controller = TextEditingController();
  bool _loading = false;

  // 🚀 chama API
  void _send() async {
    final text = _controller.text;

    if (text.isEmpty) return;

    setState(() {
      _loading = true;
    });

    try {
      final response = await http.post(
        Uri.parse("http://localhost:8000/generate-avatar"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"text": text}),
      );

      final data = jsonDecode(response.body);

      print("RESPONSE: $data");

      final videoUrl = data["video_url"];

      // 🎥 abre vídeo direto no navegador (FUNCIONA 100% NO WEB)
      html.window.open(videoUrl, "_blank");
    } catch (e) {
      print("Erro: $e");
    }

    setState(() {
      _loading = false;
    });

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("AI Generator"), centerTitle: true),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 20),

            Row(
              children: [
                // INPUT
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: "Digite o que a IA deve gerar",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                // BOTÃO
                SizedBox(
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _loading ? null : _send,
                    child: _loading
                        ? const CircularProgressIndicator()
                        : const Icon(Icons.send),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            const Text(
              "O vídeo vai abrir automaticamente em nova aba",
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
