import 'package:flutter/material.dart';
import 'package:teste_drift/data/local/db/app_db.dart';
import 'package:teste_drift/shared/widgets/birthdate_textformfield.dart';
import 'package:teste_drift/shared/widgets/custom_textformfield.dart';
import 'package:drift/drift.dart' as drift;

class AddEmployeePage extends StatefulWidget {
  const AddEmployeePage({Key? key}) : super(key: key);

  @override
  State<AddEmployeePage> createState() => _AddEmployeePageState();
}

class _AddEmployeePageState extends State<AddEmployeePage> {
  late AppDB _db;
  final _textEditingControllerUserName = TextEditingController();
  final _textEditingControllerFirstName = TextEditingController();
  final _textEditingControllerLastName = TextEditingController();
  final _textEditingControllerBirthdate = TextEditingController();
  DateTime? _dateOfBirth;
  final GlobalKey<FormState> _formGlobalKey = GlobalKey<FormState>();

  setDateOfBirth(DateTime value) => _dateOfBirth = value;

  @override
  void initState() {
    super.initState();
    _db = AppDB();
  }

  @override
  void dispose() {
    _db.close();
    _textEditingControllerUserName.dispose();
    _textEditingControllerFirstName.dispose();
    _textEditingControllerLastName.dispose();
    _textEditingControllerBirthdate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Adicione um funcionário'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async => addEmployee(),
            icon: const Icon(Icons.save),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formGlobalKey,
          child: Column(
            children: [
              const SizedBox(height: 12),
              CustomTextFormField(
                label: 'Nome do usuário',
                editingController: _textEditingControllerUserName,
              ),
              const SizedBox(height: 12),
              CustomTextFormField(
                label: 'Primeiro nome',
                editingController: _textEditingControllerFirstName,
              ),
              const SizedBox(height: 12),
              CustomTextFormField(
                label: 'Último nome',
                editingController: _textEditingControllerLastName,
              ),
              const SizedBox(height: 12),
              BirthDateTextFormField(
                label: 'Data de nascimento',
                onChangeDate: setDateOfBirth,
                editingController: _textEditingControllerBirthdate,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addEmployee() async {
    if (_formGlobalKey.currentState!.validate()) {
      final entity = EmployeeCompanion(
        userName: drift.Value(_textEditingControllerUserName.text),
        firstName: drift.Value(_textEditingControllerFirstName.text),
        lastName: drift.Value(_textEditingControllerLastName.text),
        dateOfBirth: drift.Value(_dateOfBirth!),
      );

      await _db.insertEmployee(entity).then((result) =>
          ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(
              content: Text('Novo funcionário adicionado: $result'),
              actions: [
                IconButton(
                  onPressed: () =>
                      ScaffoldMessenger.of(context).hideCurrentMaterialBanner(),
                  icon: const Icon(Icons.close),
                )
              ])));
    }
  }
}
