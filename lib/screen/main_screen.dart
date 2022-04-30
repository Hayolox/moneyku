import 'package:flutter/material.dart';
import 'package:moneyku/screen/home/home_screen.dart';
import 'package:moneyku/screen/notes/notes_screen.dart';
import 'package:moneyku/screen/person/person_screen.dart';
import 'package:moneyku/screen/task/task_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _index = 0;
  final List _body = [
    const HomeScreen(),
    const NoteScreen(),
    const Taskcreen(),
    const PersonScreen(),
  ];

  void _changeSelectedNavBar(int _paramIndex) {
    setState(() {
      _index = _paramIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.edit_road_outlined),
              label: 'Transaksi',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.checklist_outlined),
              label: 'Task',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Akun',
            ),
          ],
          currentIndex: _index,
          selectedItemColor: const Color.fromARGB(255, 241, 120, 6),
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          onTap: _changeSelectedNavBar,
        ),
        body: _body[_index],
      ),
    );
  }
}
