import 'package:flutter/material.dart';
import 'package:moneyku/screen/home/home_screen.dart';
import 'package:moneyku/screen/notes/notes_screen.dart';
import 'package:moneyku/screen/task/task_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _index = 0;
  List body = [
    const HomeScreen(),
    const NoteScreen(),
    const Taskcreen(),
  ];

  void _changeSelectedNavBar(int paramIndex) {
    setState(() {
      _index = paramIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit_road_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.checklist_outlined),
            label: '',
          ),
        ],
        currentIndex: _index,
        selectedItemColor: const Color(0xffFF4328),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        onTap: _changeSelectedNavBar,
      ),
      body: body[_index],
    );
  }
}
