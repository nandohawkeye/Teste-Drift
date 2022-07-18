import 'package:flutter/material.dart';
import 'package:teste_drift/data/local/db/app_db.dart';
import 'package:teste_drift/shared/utils/utils.dart';

class EmployeeCard extends StatelessWidget {
  const EmployeeCard({Key? key, required this.employee}) : super(key: key);

  final EmployeeData employee;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(employee.id.toString()),
          const SizedBox(height: 8),
          Text(employee.userName),
          const SizedBox(height: 8),
          Text(employee.firstName),
          const SizedBox(height: 8),
          Text(employee.lastName),
          const SizedBox(height: 8),
          Text(Utils.formatDate(employee.dateOfBirth)),
        ]),
      ),
    );
  }
}
