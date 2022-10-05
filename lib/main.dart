import 'package:expenses/components/transaction_user.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(const ExpensesApp());
}

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: MyHomePage());
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Despesas pessoais')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            //estabelece que ocupará a tela toda
            child: const Card(
              //efeito de sombra sobre o card.
              elevation: 5,
              color: Colors.blue,
              child: Text('Gráfico'),
            ),
          ),
          const TransactionUser()
        ],
      ),
    );
  }
}
