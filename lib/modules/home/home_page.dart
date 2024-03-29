import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teste_drift/data/local/db/app_db.dart';
import 'package:teste_drift/shared/widgets/employee_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drift teste'),
        centerTitle: true,
      ),
      body: StreamBuilder<List<EmployeeData>>(
          stream: Provider.of<AppDB>(context).watchEmployees,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Ocorreu um erro: ${snapshot.error}'),
              );
            }

            if (snapshot.hasData) {
              final List<EmployeeData> employees = snapshot.data!;

              if (employees.isNotEmpty) {
                return ListView.builder(
                    itemCount: employees.length,
                    itemBuilder: (context, index) =>
                        EmployeeCard(employee: employees[index]));
              } else {
                return const Center(
                  child: Text('Nenhum funcionário encontrado'),
                );
              }
            }

            return const SizedBox.shrink();
          }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(context, '/add_employee'),
        icon: const Icon(Icons.add),
        label: const Text('Adicionar'),
      ),
    );
  }
}
