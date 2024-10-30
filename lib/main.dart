import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: CurrencyConverter(), // Utilise CurrencyConverter à la place de Homepage
    );
  }
}

class Currency {
  final String name;
  final String code;
  final double rateToUSD;

  Currency({required this.name, required this.code, required this.rateToUSD});
}

List<Currency> currencies = [
  Currency(name: 'Euro', code: 'EUR', rateToUSD: 1.10),
  Currency(name: 'Dirham Marocain', code: 'MAD', rateToUSD: 0.11),
  Currency(name: 'Dollar US', code: 'USD', rateToUSD: 1.0),
  // Ajoute d'autres devises ici...
];

class CurrencyConverter extends StatefulWidget {
  const CurrencyConverter({super.key});

  @override
  _CurrencyConverterState createState() => _CurrencyConverterState();
}

class _CurrencyConverterState extends State<CurrencyConverter> {
  String fromCurrency = 'USD';
  String toCurrency = 'EUR';
  double inputAmount = 0;
  double convertedAmount = 0;

  void convert() {
    double fromRate = currencies
        .firstWhere((currency) => currency.code == fromCurrency)
        .rateToUSD;
    double toRate = currencies
        .firstWhere((currency) => currency.code == toCurrency)
        .rateToUSD;
    setState(() {
      convertedAmount = (inputAmount * toRate) / fromRate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Convertisseur de devises'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Montant à convertir'),
              onChanged: (value) {
                setState(() {
                  inputAmount = double.tryParse(value) ?? 0;
                });
              },
            ),
            DropdownButton<String>(
              value: fromCurrency,
              onChanged: (String? newValue) {
                setState(() {
                  fromCurrency = newValue!;
                });
              },
              items: currencies.map<DropdownMenuItem<String>>((Currency currency) {
                return DropdownMenuItem<String>(
                  value: currency.code,
                  child: Text(currency.name),
                );
              }).toList(),
            ),
            DropdownButton<String>(
              value: toCurrency,
              onChanged: (String? newValue) {
                setState(() {
                  toCurrency = newValue!;B
                });
              },
              items: currencies.map<DropdownMenuItem<String>>((Currency currency) {
                return DropdownMenuItem<String>(
                  value: currency.code,
                  child: Text(currency.name),
                );
              }).toList(),
            ),
            ElevatedButton(
              onPressed: convert,
              child: const Text('Convertir'),
            ),
            const SizedBox(height: 20),
            Text(
              'Montant converti : $convertedAmount $toCurrency',
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
