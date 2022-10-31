// ignore_for_file: avoid_unnecessary_containers

import 'package:expenses/components/transactions_form.dart';
import 'package:flutter/material.dart';
import 'package:expenses/models/transactions.dart';
import 'dart:math';

import 'components/transactions_list.dart';

void main(List<String> args) {
  runApp(const ExpensesApp());
}

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData tema = ThemeData();

    return MaterialApp(
      home: MyHomePage(),
      theme: tema.copyWith(
          colorScheme: tema.colorScheme.copyWith(
            primary: Colors.purple,
            secondary: Colors.amber,
          ),
          textTheme: tema.textTheme.copyWith(
            headline6: const TextStyle(
              fontFamily: 'Open Sans',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          appBarTheme: const AppBarTheme(
              titleTextStyle: TextStyle(
                  fontFamily: 'Open Sans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold))),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transactions> _transactions = [
    Transactions(id: 't1', title: 'Tênis', value: 310.76, date: DateTime.now()),
    Transactions(
        id: 't2', title: 'Conta de luz', value: 211.30, date: DateTime.now()),
    Transactions(
        id: 't3', title: 'Transação #3', value: 310.76, date: DateTime.now()),
    Transactions(
        id: 't4', title: 'Transação #4', value: 310.76, date: DateTime.now()),
    Transactions(
        id: 't5', title: 'Transação #5', value: 310.76, date: DateTime.now()),
  ];

  _addTransaction(String title, double value) {
    final newTransaction = Transactions(
        id: Random().nextDouble().toString(),
        title: title,
        value: value,
        date: DateTime.now());

    // Alterando o estado da aplicação, alterando a lista, adicionando a nova transação
    setState(() {
      _transactions.add(newTransaction);
    });

    //Fechando o modal
    Navigator.of(context).pop();
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return TransactionForm(_addTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Despesas pessoais'),
        actions: <Widget>[
          IconButton(
              onPressed: () => _openTransactionFormModal(context),
              icon: const Icon(Icons.add))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
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
            TransactionList(_transactions),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _openTransactionFormModal(context),
      ),
    );
  }
}
