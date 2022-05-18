import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:intl/intl.dart';
import 'package:moneyku/model/task_model.dart';
import 'package:moneyku/model/user_model.dart';
import 'package:moneyku/screen/task/task_view_model.dart';
import 'package:provider/provider.dart';
import '../../component/rupiah.dart';
import '../../future/storage_future.dart';

class EditTaskScreen extends StatefulWidget {
  const EditTaskScreen({Key? key, required this.model, required this.index})
      : super(key: key);
  final TaskModel model;
  final int index;

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _titleC, _priceC;
  late String _date;
  setUp() {
    String formatPrice = NumberFormat.currency(
      locale: 'id',
      symbol: '',
      decimalDigits: 0,
    ).format(int.parse(widget.model.price));
    _titleC = TextEditingController(
      text: widget.model.title,
    );
    _priceC = TextEditingController(
      text: formatPrice,
    );
    _date = widget.model.deadline.toString();
  }

  @override
  void initState() {
    super.initState();
    setUp();
  }

  @override
  Widget build(BuildContext context) {
    final _viewModel = Provider.of<TaskViewModel>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff8E75EB),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () async =>
                Navigator.of(context).pop(await _viewModel.getAllDataTask()),
          ),
          title: const Text('Edit Data'),
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
                          controller: _titleC,
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
                          controller: _priceC,
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
                          final selectDate = await showDatePicker(
                            context: context,
                            initialDate: value.currenDate,
                            firstDate: DateTime(value.currenDate.year),
                            lastDate: DateTime(value.currenDate.year + 1),
                          );
                          setState(() {
                            if (selectDate != null) {
                              _date = selectDate.toString();
                            } else {
                              _date = _date;
                            }
                          });
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
                                DateFormat('yyy-MM-dd')
                                    .format(DateTime.parse(_date)),
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
                        style: ElevatedButton.styleFrom(
                          primary: const Color(0xff8E75EB),
                        ),
                        onPressed: () async {
                          DateTime.parse(_date).add(const Duration(days: 1));

                          var convertToInteger =
                              MaskedTextController(text: '', mask: '000000000');
                          convertToInteger.updateText(_priceC.text);

                          DateTime valueDate = DateTime.parse(_date);

                          List _getDataStorage = await getStorage();
                          UserModel user = _getDataStorage[1];

                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            value.editTask(
                                TaskModel(
                                  id: widget.model.id,
                                  title: _titleC.text,
                                  price: convertToInteger.text,
                                  status: widget.model.status,
                                  deadline: valueDate,
                                  userId: user.id.toString(),
                                ),
                                user.roles,
                                widget.index);
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
