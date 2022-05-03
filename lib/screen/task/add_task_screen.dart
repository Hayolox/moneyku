import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:intl/intl.dart';
import 'package:moneyku/model/task_model.dart';
import 'package:moneyku/screen/task/task_view_model.dart';
import 'package:provider/provider.dart';
import '../../component/rupiah.dart';
import '../../future/storage_future.dart';
import '../../model/user_model.dart';

class AddTaskScreen extends StatelessWidget {
  AddTaskScreen({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final _viewModel = Provider.of<TaskViewModel>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () async =>
                Navigator.of(context).pop(await _viewModel.getAllDataTask()),
          ),
          title: const Text('Tambah Task'),
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.only(right: 15, left: 15, top: 30),
          child: Form(
              key: _formKey,
              child: Consumer<TaskViewModel>(
                builder: (context, value, child) {
                  return Column(
                    children: [
                      TextFormField(
                          controller: value.titleC,
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
                            labelText: 'Title Task',
                            hintText: 'Isi Title Task',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Title Task Tidak Boleh Kosong';
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                          controller: value.priceC,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            CurrencyPtBrInputFormatter()
                          ],
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
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
                            labelText: 'Harga',
                            hintText: 'Isi Harga',
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
                                DateFormat('yyy-MM-dd').format(value.dueDate),
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
                        onPressed: () async {
                          var convertToInteger =
                              MaskedTextController(text: '', mask: '000000000');

                          convertToInteger.updateText(value.priceC.text);

                          List _getDataStorage = await getStorage();
                          UserModel user = _getDataStorage[1];

                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            value.addTask(TaskModel(
                              title: value.titleC.text,
                              price: convertToInteger.text,
                              status: 'process',
                              deadline: value.dueDate,
                              userId: user.id.toString(),
                            ));
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
