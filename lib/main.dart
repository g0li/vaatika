import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vrksh_vaatika/pages/home.dart';
import 'package:vrksh_vaatika/pages/login.dart';
import 'package:vrksh_vaatika/provider/homeprovider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          child: HomePage(),
          create: (c) => HomeProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Vrksh Vaatika',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LoginPage(),
      ),
    );
  }
}
