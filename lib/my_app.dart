import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'navigation.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<String> names = [];

  @override
  void initState() {
    super.initState();
    _loadNames();
  }

  void _loadNames() async {
    final prefs = await SharedPreferences.getInstance();
    final loadedNames = prefs.getStringList('names');
    setState(() {
      names = loadedNames ?? [];
    });
  }

  void _updateNames(List<String> updatedNames) async {
    setState(() {
      names = updatedNames;
    });

    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('names', names);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SeKiChange',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blueGrey,
      ),
      home: Navigation(names: names, updateNames: _updateNames),
    );
  }
}
