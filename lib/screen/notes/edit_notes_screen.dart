import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:intl/intl.dart';
import 'package:moneyku/model/transaction_model.dart';
import 'package:moneyku/screen/notes/notes_view_model.dart';
import 'package:provider/provider.dart';
import '../../component/rupiah.dart';

// ignore: must_be_immutable
class EditNotesScreen extends StatefulWidget {
  EditNotesScreen({Key? key, required this.model, required this.status})
      : super(key: key);
  final TransactionModel model;
  String status;

  @override
  State<EditNotesScreen> createState() => _EditNotesScreenState();
}

class _EditNotesScreenState extends State<EditNotesScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _titleC, _priceC;
  late String _date;
  _setUp() {
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
    _date = widget.model.createdAt;
  }

  @override
  void initState() {
    super.initState();
    _setUp();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<NotesViewModel>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff8E75EB),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () async => Navigator.of(context)
                .pop(await viewModel.getStatusTransaction()),
          ),
          title: const Text('Edit Data'),
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
                          controller: _titleC,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            floatingLabelStyle: widget.model.status == 'income'
                                ? const TextStyle(color: Colors.green)
                                : const TextStyle(color: Colors.red),
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                            ),
                            contentPadding: const EdgeInsets.only(left: 40),
                            prefixIcon: const Icon(
                              Icons.title,
                            ),
                            labelText: widget.model.status == 'income'
                                ? 'Pemasukan'
                                : 'Pengeluaran',
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
                          decoration: InputDecoration(
                            floatingLabelStyle: widget.model.status == 'income'
                                ? const TextStyle(color: Colors.green)
                                : const TextStyle(color: Colors.red),
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                            ),
                            contentPadding: const EdgeInsets.only(left: 40),
                            prefixIcon: const Icon(
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
                        onPressed: () {
                          var convertToInteger =
                              MaskedTextController(text: '', mask: '000000000');
                          convertToInteger.updateText(_priceC.text);

                          DateTime valueDate = DateTime.parse(_date)
                              .add(const Duration(days: 1));

                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            value.editTransaction(TransactionModel(
                                id: widget.model.id,
                                title: _titleC.text,
                                price: convertToInteger.text,
                                status: widget.model.status,
                                createdAt: valueDate.toString()));
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
