import 'package:flutter/material.dart';
import 'package:teste_drift/modules/add_employee/add_employee_page.dart';
import 'package:teste_drift/modules/edit_employee/edit_employee_page.dart';
import 'package:teste_drift/modules/home/home_page.dart';

class RouteGenerator {
  static Route<dynamic> generate(RouteSettings settings) {
    final dynamic args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomePage());
      case '/add_employee':
        return MaterialPageRoute(builder: (_) => const AddEmployeePage());

      case '/adit_employee':
        if (args != null && args is int) {
          return MaterialPageRoute(builder: (_) => EditEmployeePage(id: args));
        } else {
          return _errorRoute();
        }

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return const Scaffold(
        body: Center(
          child: Text('Página não encontrada'),
        ),
      );
    });
  }
}
