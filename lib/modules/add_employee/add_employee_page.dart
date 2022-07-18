import 'package:flutter/material.dart';
import 'package:teste_drift/shared/widgets/custom_textformfield.dart';

class AddEmployeePage extends StatefulWidget {
  const AddEmployeePage({Key? key}) : super(key: key);

  @override
  State<AddEmployeePage> createState() => _AddEmployeePageState();
}

class _AddEmployeePageState extends State<AddEmployeePage> {
  final _textEditingControllerUserName = TextEditingController();
  final _textEditingControllerFirstName = TextEditingController();
  final _textEditingControllerLastName = TextEditingController();
  final _textEditingControllerBirthdate = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicione um funcionário'),
        centerTitle: true,
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.save))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CustomTextFormField(
              label: 'Nome do usuário',
              editingController: _textEditingControllerUserName,
            ),
            const SizedBox(height: 8),
            CustomTextFormField(
              label: 'Primeiro nome',
              editingController: _textEditingControllerFirstName,
            ),
            const SizedBox(height: 8),
            CustomTextFormField(
              label: 'Último nome',
              editingController: _textEditingControllerLastName,
            ),
            const SizedBox(height: 8),
            CustomTextFormField(
              label: 'Data de nascimento',
              editingController: _textEditingControllerBirthdate,
            ),
          ],
        ),
      ),
    );
  }
}
