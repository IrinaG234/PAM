import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reducere calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const CalculatorReducerePage(),
    );
  }
}

class CalculatorReducerePage extends StatefulWidget {
  const CalculatorReducerePage({super.key});

  @override
  State<CalculatorReducerePage> createState() =>
      _CalculatorReducerePageState();
}

class _CalculatorReducerePageState extends State<CalculatorReducerePage> {
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _discountController = TextEditingController();
  String _result = '';

  final List<int> _optiuniProcent = [5, 10, 15, 20, 25, 30, 50];

  void _calculateDiscount() {
    final double? price = double.tryParse(_priceController.text);
    final double? discountPercent = double.tryParse(_discountController.text);

    if (price == null || discountPercent == null) {
      setState(() {
        _result = 'Introdu valori numerice valide.';
      });
      return;
    }

    final double discountValue = price * (discountPercent / 100);
    final double finalPrice = price - discountValue;

    setState(() {
      _result =
      'Valoarea: ${discountValue.toStringAsFixed(2)} lei\n'
          'Preț final: ${finalPrice.toStringAsFixed(2)} lei';
    });
  }

  @override
  void dispose() {
    _priceController.dispose();
    _discountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculator de reducere')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _priceController,
              decoration: const InputDecoration(
                labelText: 'Preț inițial (lei)',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _discountController,
              decoration: const InputDecoration(
                labelText: 'Procentul reducerii (%)',
              ),
            ),
            const SizedBox(height: 8),
            DropdownButton<int>(
              hint: const Text('Alege procent rapid'),
              items: _optiuniProcent.map((procent) {
                return DropdownMenuItem<int>(
                  value: procent,
                  child: Text('$procent%'),
                );
              }).toList(),
              onChanged: (int? valoare) {
                setState(() {
                  _discountController.text = valoare.toString();
                });
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _calculateDiscount,
              child: const Text('Calculează'),
            ),
            const SizedBox(height: 16),
            Text(_result),
          ],
        ),
      ),
    );
  }
}