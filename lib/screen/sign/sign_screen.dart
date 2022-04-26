import 'package:flutter/material.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:lottie/lottie.dart';
import 'package:moneyku/screen/sign/sign_view_model.dart';
import 'package:provider/provider.dart';

import '../../theme.dart';

class SignScreen extends StatelessWidget {
  const SignScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    TextEditingController emailC = TextEditingController();
    TextEditingController passwordC = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              if (!isKeyboard)

                /// Logo
                DelayedDisplay(
                  delay: const Duration(seconds: 1),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Lottie.network(
                      'https://assets10.lottiefiles.com/packages/lf20_gjmecwii.json',
                      height: 300,
                    ),
                  ),
                ),
              if (isKeyboard)
                const SizedBox(
                  height: 100,
                ),

              /// Form NIM
              DelayedDisplay(
                  delay: const Duration(seconds: 2),
                  child: Container(
                    margin: const EdgeInsets.only(
                      left: 30,
                      right: 30,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 15,
                    ),
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        Text('Email : ',
                            style: primaryTextStyle.copyWith(
                              fontSize: 15,
                            )),
                        Expanded(
                            child: TextFormField(
                          autocorrect: false,
                          controller: emailC,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration.collapsed(
                            hintText: 'contoh@gmail.com',
                          ),
                        ))
                      ],
                    ),
                  )),

              ///Form password
              DelayedDisplay(
                  delay: const Duration(seconds: 3),
                  child: Container(
                    margin: const EdgeInsets.only(left: 30, right: 30, top: 15),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 15,
                    ),
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(child: Consumer<SignViewModel>(
                      builder: (context, value, child) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Pass: ',
                                style: primaryTextStyle.copyWith(
                                  fontSize: 15,
                                )),
                            Expanded(
                                child: TextFormField(
                              autocorrect: false,
                              controller: passwordC,
                              textInputAction: TextInputAction.done,
                              obscureText: value.isHideen,
                              decoration: const InputDecoration.collapsed(
                                hintText: '',
                              ),
                            )),
                            IconButton(
                                padding: const EdgeInsets.all(0),
                                onPressed: () {
                                  value.changeIsHidden(value.isHideen);
                                },
                                icon:
                                    const Icon(Icons.remove_red_eye_outlined)),
                          ],
                        );
                      },
                    )),
                  )),
              const SizedBox(
                height: 10,
              ),

              DelayedDisplay(
                  delay: const Duration(seconds: 4),
                  child: Consumer<SignViewModel>(
                    builder: (context, value, child) {
                      return GestureDetector(
                        onTap: () {
                          Object condition = value.validation(
                              emailC.text, passwordC.text, context);
                          if (condition == 'success') {
                            print('login berhasil');
                            Navigator.pushReplacementNamed(context, '/home');
                          }
                        },

                        ///button login
                        child: Container(
                          height: 50,
                          width: 150,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [
                                  backroundColor1,
                                  backroundColor2,
                                ]),
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
          ),
        ),
      ),
    );
  }
}
