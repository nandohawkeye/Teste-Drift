import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {Key? key, required this.editingController, required this.label})
      : super(key: key);

  final TextEditingController editingController;
  final String label;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: editingController,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        label: Text(label),
        border: const OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Digite o $label!';
        }
        return null;
      },
    );
  }
}
