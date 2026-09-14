import 'package:flutter/material.dart';
//datorita la asta se face run(se activeaza tot neceesarul)
void main() {
  runApp(const MyApp());
}
//config aplicatia global si e static/baza(titli,tema,culor,ecran de start)
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reducere calculator',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const CalculatorReducerePage(),
    );
  }
}
//definește pagina si se poate schimba
class CalculatorReducerePage extends StatefulWidget {
  const CalculatorReducerePage({super.key});

  @override
  State<CalculatorReducerePage> createState() => _CalculatorReducerePageState();
}

//logica de actualizarea
class _CalculatorReducerePageState extends State<CalculatorReducerePage> {
  final TextEditingController _priceController=TextEditingController();
  final TextEditingController _discountController=TextEditingController();
  String _result='';
  TipReducere _tipSelectat = TipReducere.procent;

  void _calculateDiscount() {
    final double? price=double.tryParse(_priceController.text);
    final double? discountPercent= double.tryParse(_discountController.text);

    if (price==null || discountPercent==null){
      setState(() {
        _result="introdu valoare";
      });
      return;
    }

    final double discountValue=price*(discountPercent/100);
    final double finalPrice=price-discountValue;

    setState(() {
      _result=
      'valoarea: ${discountValue.toStringAsFixed(2)} lei\n'
      'pret final: ${finalPrice.toStringAsFixed(2)} lei\n';
    });
  }


//controalele se clenuieste
  @override
  void dispose(){
    _priceController.dispose();
    _discountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
     appBar: AppBar(title: const Text('Calculator de reducere')),
     body: Column(
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
           ElevatedButton(
              onPressed: _calculateDiscount,
              child: const Text('Calculează'),
           ),
           Text(_result),
        ],
      ),
  );
}
}