// ignore_for_file: sized_box_for_whitespace

import 'package:expenses/models/transactions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transactions> transactions;

  //const
  const TransactionList(this.transactions, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      // list view precisa de um componente pai com um tamanho pré-definido, por isso esse container acima
      child: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: ((context, index) {
          final tr = transactions[index];

          return Card(
            child: Row(children: <Widget>[
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).colorScheme.primary,
                        width: 2)),
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'R\$ ${tr.value.toStringAsFixed(2)}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.primary),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tr.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    DateFormat('d MMM y').format(tr.date),
                    style: const TextStyle(color: Colors.grey),
                  )
                ],
              )
            ]),
          );
        }),
      ),
    ); //Column
  }
}
