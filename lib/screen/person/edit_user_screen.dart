import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:moneyku/screen/person/person_view_model.dart';
import 'package:provider/provider.dart';
import '../../model/user_model.dart';

// ignore: must_be_immutable
class EditUserScreen extends StatefulWidget {
  EditUserScreen({Key? key, required this.user}) : super(key: key);

  UserModel user;

  @override
  State<EditUserScreen> createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameC, _emailC;

  _setUp() async {
    _nameC = TextEditingController(text: widget.user.name);
    _emailC = TextEditingController(text: widget.user.email);
  }

  @override
  void initState() {
    super.initState();
    _setUp();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit User'),
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.only(right: 15, left: 15, top: 30),
          child: Form(
              key: _formKey,
              child: Consumer<PersonViewModel>(
                builder: (context, value, child) {
                  return Column(
                    children: [
                      TextFormField(
                          controller: _nameC,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            floatingLabelStyle: TextStyle(color: Colors.green),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                            ),
                            contentPadding: EdgeInsets.only(left: 40),
                            prefixIcon: Icon(
                              Icons.person,
                            ),
                            labelText: 'Name',
                            hintText: 'Edit Name',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Name Tidak Boleh Kosong';
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                          controller: _emailC,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            floatingLabelStyle: TextStyle(color: Colors.green),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                            ),
                            contentPadding: EdgeInsets.only(left: 40),
                            prefixIcon: Icon(
                              Icons.email,
                            ),
                            labelText: 'Email',
                            hintText: 'Edit Email',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email Tidak Boleh Kosong';
                            }
                            final bool _isValid = EmailValidator.validate(
                              value.toString(),
                            );
                            return _isValid == false
                                ? 'Format harus berupa email'
                                : null;
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                          child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            value.editUser(UserModel(
                              id: widget.user.id,
                              name: _nameC.text,
                              email: _emailC.text,
                              roles: widget.user.roles,
                            ));
                          }
                        },
                        child: const Text('Edit'),
                      ))
                    ],
                  );
                },
              )),
        ),
      ),
    );
  }
}
