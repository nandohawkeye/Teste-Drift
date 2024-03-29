import 'package:flutter/material.dart';
import 'package:teste_drift/shared/utils/utils.dart';

class BirthDateTextFormField extends StatefulWidget {
  const BirthDateTextFormField(
      {Key? key,
      required this.editingController,
      required this.label,
      required this.onChangeDate,
      this.initialDate})
      : super(key: key);

  final TextEditingController editingController;
  final String label;
  final Function(DateTime) onChangeDate;
  final DateTime? initialDate;

  @override
  State<BirthDateTextFormField> createState() => _BirthDateTextFormFieldState();
}

class _BirthDateTextFormFieldState extends State<BirthDateTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.editingController,
      keyboardType: TextInputType.name,
      focusNode: AlwaysDisabledFocusNode(),
      onTap: () => _getDate(context, widget.initialDate),
      decoration: InputDecoration(
        label: Text(widget.label),
        border: const OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Digite o ${widget.label}!';
        }
        return null;
      },
    );
  }

  Future<void> _getDate(BuildContext context, DateTime? initialDate) async {
    final date = initialDate ?? DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime(DateTime.now().year - 100),
      lastDate: DateTime(DateTime.now().year + 1),
    );

    if (newDate == null) {
      return;
    }

    setState(() {
      widget.editingController.text = Utils.formatDate(newDate);
    });

    widget.onChangeDate(newDate);
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
