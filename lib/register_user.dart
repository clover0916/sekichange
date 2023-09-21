import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterUser extends StatefulWidget {
  final Function(List<String>) updateNames;

  const RegisterUser({Key? key, required this.updateNames}) : super(key: key);

  @override
  State<RegisterUser> createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('ユーザー登録'),
        ),
        body: Form(
            key: _formKey,
            child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: ListView(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: '名前',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '名前を入力してください';
                        }
                        return null;
                      },
                    )
                  ],
                ))),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _saveNames();

              Navigator.pop(context);
            }
          },
          child: const Icon(Icons.add),
        ));
  }

  void _saveNames() async {
    final prefs = await SharedPreferences.getInstance();
    final names = prefs.getStringList('names') ?? [];
    names.add(_nameController.text);
    prefs.setStringList('names', names);
    widget.updateNames(names);
  }
}
