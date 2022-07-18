import 'package:flutter/material.dart';
import 'package:teste_drift/data/local/db/app_db.dart';
import 'package:teste_drift/shared/utils/utils.dart';
import 'package:teste_drift/shared/widgets/birthdate_textformfield.dart';
import 'package:teste_drift/shared/widgets/custom_textformfield.dart';
import 'package:drift/drift.dart' as drift;

class EditEmployeePage extends StatefulWidget {
  const EditEmployeePage({Key? key, required this.id}) : super(key: key);

  final int id;

  @override
  State<EditEmployeePage> createState() => _EditEmployeePageState();
}

class _EditEmployeePageState extends State<EditEmployeePage> {
  late EmployeeData _employee;
  late AppDB _db;
  final _textEditingControllerUserName = TextEditingController();
  final _textEditingControllerFirstName = TextEditingController();
  final _textEditingControllerLastName = TextEditingController();
  final _textEditingControllerBirthdate = TextEditingController();
  DateTime? _dateOfBirth;
  final GlobalKey<FormState> _formGlobalKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _db = AppDB();
    getEmployee();
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
        title: const Text('Adite o funcionário'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async => aditEmployee(),
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
                initialDate: _dateOfBirth,
                onChangeDate: setDateOfBirth,
                editingController: _textEditingControllerBirthdate,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void aditEmployee() async {
    if (_formGlobalKey.currentState!.validate()) {
      final entity = EmployeeCompanion(
        id: drift.Value(widget.id),
        userName: drift.Value(_textEditingControllerUserName.text),
        firstName: drift.Value(_textEditingControllerFirstName.text),
        lastName: drift.Value(_textEditingControllerLastName.text),
        dateOfBirth: drift.Value(_dateOfBirth!),
      );

      await _db.updateEmployee(entity).then((result) =>
          ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(
              content: Text('Funcionário editado: $result'),
              actions: [
                IconButton(
                  onPressed: () =>
                      ScaffoldMessenger.of(context).hideCurrentMaterialBanner(),
                  icon: const Icon(Icons.close),
                )
              ])));
    }
  }

  setDateOfBirth(DateTime value) {
    setState(() {
      _dateOfBirth = value;
    });
  }

  Future<void> getEmployee() async {
    _employee = await _db.getEmployee(widget.id);
    _textEditingControllerUserName.text = _employee.userName;
    _textEditingControllerFirstName.text = _employee.firstName;
    _textEditingControllerLastName.text = _employee.lastName;
    _textEditingControllerBirthdate.text =
        Utils.formatDate(_employee.dateOfBirth);
    setDateOfBirth(_employee.dateOfBirth);
  }
}
