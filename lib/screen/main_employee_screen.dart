import 'package:flutter/material.dart';
import 'package:moneyku/screen/employee/employee_screen.dart';
import 'package:moneyku/screen/person/person_screen.dart';

class MainEmployeeScreen extends StatefulWidget {
  const MainEmployeeScreen({Key? key}) : super(key: key);

  @override
  State<MainEmployeeScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainEmployeeScreen> {
  int _index = 0;
  final List _body = [
    const EmployeeScreen(),
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
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: '',
            ),
          ],
          currentIndex: _index,
          selectedItemColor: const Color(0xffFF4328),
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          onTap: _changeSelectedNavBar,
        ),
        body: _body[_index],
      ),
    );
  }
}
