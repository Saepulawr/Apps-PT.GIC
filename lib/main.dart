import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testptgic/module/provider/PublicProvider.dart';
import 'package:testptgic/module/routes/routes.dart';

void main() async {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: PublicProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: routes,
      title: 'Contact - PT.GIC',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        accentColor: Colors.orange,
      ),
    );
  }
}
