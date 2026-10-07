import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator reducere',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final TextEditingController pretController = TextEditingController();
  final TextEditingController reducereController = TextEditingController();

  double valoareReducere = 0;
  double pretFinal = 0;

  void calculeazaReducerea() {
    double? pret = double.tryParse(
      pretController.text.replaceAll(',', '.'),
    );

    double? procent = double.tryParse(
      reducereController.text.replaceAll(',', '.'),
    );

    if (pret == null || procent == null || pret < 0 || procent < 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Introduceti valori valide!'),
        ),
      );
      return;
    }

    if (procent > 100) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Reducerea trebuie sa fie intre 0 si 100%.'),
        ),
      );
      return;
    }

    setState(() {
      valoareReducere = pret * procent / 100;
      pretFinal = pret - valoareReducere;
    });
  }

  @override
  void dispose() {
    pretController.dispose();
    reducereController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator de reducere'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Calculator de reducere',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 30),

            TextField(
              controller: pretController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Pret initial',
                hintText: 'Ex: 100',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: reducereController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Procent reducere (%)',
                hintText: 'Ex: 20',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 25),

            ElevatedButton(
              onPressed: calculeazaReducerea,
              child: const Text(
                'Calculeaza',
                style: TextStyle(fontSize: 18),
              ),
            ),

            const SizedBox(height: 30),

            Text(
              'Valoarea reducerii: ${valoareReducere.toStringAsFixed(2)} lei',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 15),

            Text(
              'Pret final: ${pretFinal.toStringAsFixed(2)} lei',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}