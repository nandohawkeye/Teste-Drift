import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teste_drift/data/local/db/app_db.dart';
import 'package:teste_drift/route/route_generator.dart';

void main() {
  runApp(Provider(
    create: (context) => AppDB(),
    child: const App(),
    dispose: (context, AppDB appdb) => appdb.close(),
  ));
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generate,
    );
  }
}
