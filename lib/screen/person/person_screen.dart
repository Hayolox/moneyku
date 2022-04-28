import 'package:flutter/material.dart';
import 'package:moneyku/screen/person/edit_user_screen.dart';
import 'package:moneyku/screen/person/person_view_model.dart';
import 'package:provider/provider.dart';
import 'package:transition/transition.dart';

class PersonScreen extends StatelessWidget {
  const PersonScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 50,
        left: 10,
        right: 10,
      ),
      child: Column(
        children: [
          Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      Transition(
                          child: EditUserScreen(),
                          transitionEffect: TransitionEffect.RIGHT_TO_LEFT),
                    );
                  },
                  leading: const Icon(Icons.person),
                  title: const Text('Akun'),
                ),
              ],
            ),
          ),
          Consumer<PersonViewModel>(
            builder: (context, value, child) {
              return GestureDetector(
                onTap: () {
                  value.logout(context);
                },
                child: Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const <Widget>[
                      ListTile(
                        leading: Icon(Icons.logout),
                        title: Text('Logout'),
                      ),
                    ],
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
