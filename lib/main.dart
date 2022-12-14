// ignore_for_file: avoid_unnecessary_containers

import 'package:expenses/components/chart.dart';
import 'package:expenses/components/transactions_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expenses/models/transactions.dart';
import 'dart:math';
import 'dart:io';

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
              fontFamily: 'Quicksand',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          appBarTheme: const AppBarTheme(
              titleTextStyle: TextStyle(
                  fontFamily: 'Quicksand',
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
  final List<Transactions> _transactions = [];
  bool _showChart = false;

  List<Transactions> get _recentTransactions {
    //Esse where é o mesmo filter lá do javascript, aqui estamos filtrando para que todas as transações sejam apenas dos últimos 7 dias
    return _transactions
        .where((transaction) => transaction.date
            .isAfter(DateTime.now().subtract(const Duration(days: 7))))
        .toList();
  }

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transactions(
        id: Random().nextDouble().toString(),
        title: title,
        value: value,
        date: date);

    // Alterando o estado da aplicação, alterando a lista, adicionando a nova transação
    setState(() {
      _transactions.add(newTransaction);
    });

    //Fechando o modal
    Navigator.of(context).pop();
  }

  _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((transaction) => transaction.id == id);
    });
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return TransactionForm(_addTransaction);
        });
  }

  Widget _getIconButton(Function fn, IconData icon) {
    return Platform.isIOS
        ? GestureDetector(
            onTap: fn(),
            child: Icon(icon),
          )
        : IconButton(
            onPressed: fn(),
            icon: Icon(icon),
          );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    final iconList = Platform.isIOS ? CupertinoIcons.refresh : Icons.list;
    final chartList =
        Platform.isIOS ? CupertinoIcons.refresh : Icons.show_chart;

    bool isLandscape = mediaQuery.orientation == Orientation.landscape;

    final actions = <Widget>[
      if (isLandscape)
        _getIconButton(() {
          setState(() {
            _showChart = !_showChart;
          });
        }, _showChart ? iconList : chartList),
      _getIconButton(
        () {
          _openTransactionFormModal(context);
        },
        Icons.add,
      )
    ];

    final appBar = AppBar(
      title: const Text('Despesas pessoais'),
      actions: actions,
    );

    //Altura disponível já considerando a APPBAR e também a status bar
    final availableHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    final bodyPage = SingleChildScrollView(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (isLandscape)
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     const Text('Exibindo gráfico'),
              //     Switch(
              //       value: _showChart,
              //       onChanged: (value) {
              //         setState(() {
              //           _showChart = value;
              //         });
              //       },
              //     ),
              //   ],
              // ),
              if (_showChart || !isLandscape)
                Container(
                  height: (isLandscape
                      ? availableHeight * 0.8
                      : availableHeight * 0.3),
                  child: Chart(_recentTransactions),
                ),
            if (!_showChart || !isLandscape)
              Container(
                height:
                    (isLandscape ? availableHeight * 1 : availableHeight * 0.7),
                child: TransactionList(_transactions, _removeTransaction),
              ),
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: Text('Despesas Pessoais'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: actions,
              ),
            ),
            child: bodyPage,
          )
        : Scaffold(
            appBar: appBar,
            body: bodyPage,
            //Floating button só aparecerá no Android
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: const Icon(Icons.add),
                    onPressed: () => _openTransactionFormModal(context),
                  ),
          );
  }
}
