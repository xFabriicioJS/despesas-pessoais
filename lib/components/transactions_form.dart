import 'package:flutter/material.dart';

class TransactionForm extends StatelessWidget {
  final void Function(String, double) onSubmit;

  TransactionForm(this.onSubmit, {super.key});

  final titleController = TextEditingController();
  final valueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Título'),
              controller: titleController,
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Valor (R\$)',
              ),
              controller: valueController,
            ),
            TextButton(
              onPressed: () {
                onSubmit(titleController.text,
                    double.tryParse(valueController.text) ?? 0.0);
              },
              style: TextButton.styleFrom(foregroundColor: Colors.purple),
              child: const Text('Nova transação'),
            )
          ],
        ),
      ),
    );
  }
}
