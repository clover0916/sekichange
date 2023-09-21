import 'package:flutter/material.dart';
import 'register_users.dart';

class Navigation extends StatefulWidget {
  final List<String> names;
  final Function(List<String>) updateNames;

  const Navigation({Key? key, required this.names, required this.updateNames})
      : super(key: key);

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  var currentPageIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          selectedIndex: currentPageIndex,
          destinations: const <Widget>[
            NavigationDestination(icon: Icon(Icons.add), label: '登録'),
            NavigationDestination(icon: Icon(Icons.home), label: 'ホーム'),
            NavigationDestination(
              icon: Icon(Icons.settings),
              label: '設定',
            ),
          ],
        ),
        body: <Widget>[
          Container(
              alignment: Alignment.center,
              child: RegisterUsers(
                names: widget.names,
                updateNames: widget.updateNames,
              )),
          Container(
            alignment: Alignment.center,
            child: const Text('Page 2'),
          ),
          Container(
            alignment: Alignment.center,
            child: const Text('Page 3'),
          )
        ][currentPageIndex]);
  }
}
