import 'package:flutter/material.dart';
import 'package:teste_drift/data/local/db/app_db.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late AppDB _appDB;

  @override
  void initState() {
    super.initState();
    _appDB = AppDB();
  }

  @override
  void dispose() {
    _appDB.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drift teste'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<EmployeeData>>(
          future: _appDB.getEmployees(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

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
                    itemBuilder: (context, index) {
                      return Card(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(employees[index].id.toString()),
                              Text(employees[index].userName),
                              Text(employees[index].firstName),
                              Text(employees[index].lastName),
                              Text(employees[index].dateOfBirth.toString()),
                            ]),
                      );
                    });
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
