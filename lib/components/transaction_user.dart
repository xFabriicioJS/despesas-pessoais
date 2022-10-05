import 'dart:math';

import 'package:expenses/components/transactions_form.dart';
import 'package:expenses/components/transactions_list.dart';
import 'package:expenses/models/transactions.dart';
import 'package:flutter/cupertino.dart';

class TransactionUser extends StatefulWidget {
  const TransactionUser({super.key});

  @override
  State<TransactionUser> createState() => _TransactionUserState();
}

class _TransactionUserState extends State<TransactionUser> {
  final List<Transactions> _transactions = [
    Transactions(
        id: 't1',
        title: 'Novo tênis de corrida',
        value: 310.76,
        date: DateTime.now()),
    Transactions(
        id: 't2', title: 'Conta de luz', value: 211.30, date: DateTime.now()),
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
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TransactionList(_transactions),
        TransactionForm(_addTransaction)
      ],
    );
  }
}
