import 'package:flutter/material.dart';
import 'edit_name_screen.dart';
import 'register_user.dart';

class RegisterUsers extends StatefulWidget {
  final List<String> names;
  final Function(List<String>) updateNames;

  const RegisterUsers(
      {Key? key, required this.names, required this.updateNames})
      : super(key: key);

  @override
  State<RegisterUsers> createState() => _RegisterUsersState();
}

class _RegisterUsersState extends State<RegisterUsers> {
  void _navigateToEditNameScreen(String name) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditNameScreen(
          name: name,
          updateName: (updatedName) {
            // 名前を更新
            final updatedNames = List<String>.from(widget.names);
            final index = updatedNames.indexOf(name);
            if (index != -1) {
              updatedNames[index] = updatedName;
              widget.updateNames(updatedNames);
            }
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ユーザー登録'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    RegisterUser(
                  updateNames: widget.updateNames,
                ),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return const OpenUpwardsPageTransitionsBuilder()
                      .buildTransitions(
                          MaterialPageRoute(
                              builder: (context) => RegisterUser(
                                    updateNames: widget.updateNames,
                                  )),
                          context,
                          animation,
                          secondaryAnimation,
                          child);
                },
              ));
        },
        child: const Icon(Icons.add),
      ),
      body: ListView(
          children: widget.names
              .map((name) => ListTile(
                    title: Text(name),
                    leading: const Icon(Icons.person),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            // 名前の編集画面に遷移する処理を追加
                            _navigateToEditNameScreen(name);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            setState(() {
                              widget.names.remove(name);
                              widget.updateNames(widget.names);
                            });
                          },
                        ),
                      ],
                    ),
                  ))
              .toList()),
    );
  }
}
