import 'package:flutter/material.dart';

void main() {
  runApp(const OurApp());
}

class OurApp extends StatelessWidget {
  const OurApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LINGUISTICS',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _numeroController = TextEditingController();
  int _resultado = 0;

  void _calcular() {
    final int numero = int.tryParse(_numeroController.text) ?? 0;

    setState(() {
      _resultado = numero * 100;
    });
  }

  void _navigateToResult() {
    final String nomeDigitado = _nomeController.text.trim();
    final String emailDigitado = _emailController.text.trim();
    final int numeroDigitado = int.tryParse(_numeroController.text.trim()) ?? 0;

    if (nomeDigitado.isNotEmpty &&
        emailDigitado.isNotEmpty &&
        _numeroController.text.isNotEmpty) {
      _calcular(); //calcula antes de navegarmos

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            nome: nomeDigitado,
            email: emailDigitado,
            numero: numeroDigitado,
            resultado: _resultado, //passa o resultado MULTIPLICADO POR 100
          ),
        ),
      );
    } else {
      String msg = '';
      if (nomeDigitado.isEmpty &&
          emailDigitado.isEmpty &&
          _numeroController.text.isEmpty) {
        msg = 'Por favor, insira o nome e o email.';
      } else if (nomeDigitado.isEmpty) {
        msg = 'Por favor, insira o nome.';
      } else if (emailDigitado.isEmpty) {
        msg = 'Por favor, insira o email.';
      } else if (_numeroController.text.isEmpty) {
        msg = 'Por favor, insira o numero.';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(msg, style: const TextStyle(fontSize: 20)),
          duration: const Duration(seconds: 4),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16.0),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(28.0)),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tela inicial')),
      body: Padding(
        padding: const EdgeInsets.all(36.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Informe seu nome:"),
            TextField(
              controller: _nomeController,
              decoration: const InputDecoration(
                hintText: 'Digite seu nome aqui',
              ),
            ),
            const SizedBox(height: 25),

            const Text("Informe seu email:"),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                hintText: 'Digite seu email aqui',
              ),
            ),
            const SizedBox(height: 25),

            const Text("Informe um numero:"),
            TextField(
              controller: _numeroController,
              decoration: const InputDecoration(
                hintText: 'Digite o numero aqui',
              ),
            ),
            const SizedBox(height: 40),

            ElevatedButton(
              onPressed: _navigateToResult,
              child: const Text('Verificar Nome e Email e Numero'),
            ),
          ],
        ),
      ),
    );
  }
}

class ResultScreen extends StatelessWidget {
  final String nome;
  final String email;
  final int numero;
  final int resultado;

  const ResultScreen({
    super.key,
    required this.nome,
    required this.email,
    required this.numero,
    required this.resultado,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Resultado')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Nome digitado: $nome',
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            Text(
              'Email digitado: $email',
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            Text(
              'Numero digitado: $numero',
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            Text(
              ' Resultado $numero x 100: $resultado',
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Voltar para tela inicial'),
            ),
          ],
        ),
      ),
    );
  }
}
