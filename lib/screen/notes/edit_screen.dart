import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:moneyku/screen/notes/formater_screen.dart';
import 'package:moneyku/screen/notes/notes_view_model.dart';
import 'package:provider/provider.dart';

class EditlIncomeScreen extends StatelessWidget {
  EditlIncomeScreen({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Tambah Pemasukan'),
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.only(right: 15, left: 15, top: 30),
          child: Form(
              key: _formKey,
              child: Consumer<NotesViewModel>(
                builder: (context, value, child) {
                  return Column(
                    children: [
                      TextFormField(
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
                              Icons.title,
                            ),
                            labelText: 'Pemasukan',
                            hintText: 'Isi pemasukan',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Pemasukan Tidak Boleh Kosong';
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            CurrencyPtBrInputFormatter()
                          ],
                          decoration: const InputDecoration(
                            floatingLabelStyle: TextStyle(color: Colors.green),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                            ),
                            contentPadding: EdgeInsets.only(left: 40),
                            prefixIcon: Icon(
                              Icons.arrow_upward,
                            ),
                            labelText: 'Jumlah',
                            hintText: 'Isi jumlah pemasukan',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Jumlah Tidak Boleh Kosong';
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () async {
                          value.showDate(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                          height: 40,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 4,
                              ),
                              const Icon(
                                Icons.date_range,
                                size: 20,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                DateFormat('dd-MM-yyy').format(value.dueDate),
                                style: const TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Center(
                          child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            print(value.currenDate);
                          }
                        },
                        child: const Text('Submit'),
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
