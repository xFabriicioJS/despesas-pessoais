import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double) onSubmit;

  TransactionForm(this.onSubmit, {super.key});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  _submitForm() {
    final title = titleController.text;
    final value = double.tryParse(valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0.0) {
      //cortará a função e não permitirá seu prosseguimento.
      return;
    }

    widget.onSubmit(title, value);
  }

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
              onSubmitted: (_) => _submitForm(),
            ),
            TextField(
              keyboardType: TextInputType.number,
              // Esse underline "_" quer dizer que é um parâmetro obriga´tório mas que não iremos usar
              onSubmitted: (_) => _submitForm(),
              decoration: const InputDecoration(
                labelText: 'Valor (R\$)',
              ),
              controller: valueController,
            ),
            TextButton(
              onPressed: _submitForm,
              style: TextButton.styleFrom(foregroundColor: Colors.purple),
              child: const Text('Nova transação'),
            )
          ],
        ),
      ),
    );
  }
}
