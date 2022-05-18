import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:lottie/lottie.dart';
import 'package:moneyku/screen/sign/sign_view_model.dart';
import 'package:provider/provider.dart';
import '../../theme.dart';

// ignore: must_be_immutable
class SignScreen extends StatelessWidget {
  SignScreen({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final _isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: Form(
              key: _formKey,
              child: Consumer<SignViewModel>(
                builder: (context, value, child) {
                  return Column(
                    children: <Widget>[
                      if (!_isKeyboard)

                        /// Logo
                        DelayedDisplay(
                          delay: const Duration(seconds: 2),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: Lottie.network(
                              'https://assets10.lottiefiles.com/packages/lf20_gjmecwii.json',
                              height: 300,
                            ),
                          ),
                        ),
                      if (_isKeyboard)
                        const SizedBox(
                          height: 100,
                        ),

                      /// Form Email
                      DelayedDisplay(
                        delay: const Duration(seconds: 2),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              controller: value.emailC,
                              decoration: const InputDecoration(
                                floatingLabelStyle:
                                    TextStyle(color: Colors.red),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                ),
                                contentPadding: EdgeInsets.only(left: 40),
                                prefixIcon: Icon(
                                  Icons.mail_outline,
                                  color: Color.fromARGB(255, 248, 76, 76),
                                ),
                                labelText: 'Email',
                                hintText: 'Masukkan Email',
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
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      ///Form password
                      DelayedDisplay(
                        delay: const Duration(seconds: 3),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: TextFormField(
                            controller: value.passwordC,
                            obscureText: value.isHideen,
                            decoration: InputDecoration(
                              floatingLabelStyle:
                                  const TextStyle(color: Colors.red),
                              border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                              prefixIcon: const Icon(
                                Icons.key,
                                color: Color.fromARGB(255, 248, 76, 76),
                              ),
                              suffixIcon: GestureDetector(
                                  onTap: () {
                                    value.changeIsHidden(value.isHideen);
                                  },
                                  child: value.isHideen == true
                                      ? const Icon(Icons.visibility)
                                      : const Icon(Icons.visibility_off)),
                              contentPadding: const EdgeInsets.only(left: 40),
                              labelText: 'Password',
                              hintText: 'Masukkan Password',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password Tidak Boleh Kosong';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      DelayedDisplay(
                          delay: const Duration(seconds: 4),
                          child: Consumer<SignViewModel>(
                            builder: (context, value, child) {
                              return GestureDetector(
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();

                                    value.sign(value.emailC.text,
                                        value.passwordC.text, context);
                                  }
                                },

                                ///button login
                                child: Container(
                                  height: 50,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    color: const Color(0xff8E75EB),
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Center(
                                    child: Text('Login',
                                        style: primaryTextStyle.copyWith(
                                          fontSize: 20,
                                        )),
                                  ),
                                ),
                              );
                            },
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
