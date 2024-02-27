import 'package:dio/dio.dart';
import 'package:fitness_app/src/repository/data/models/account_model.dart';
import 'package:fitness_app/src/repository/data/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditPersonalInfoScreen extends StatefulWidget {
  const EditPersonalInfoScreen({Key? key});

  @override
  State<EditPersonalInfoScreen> createState() => _EditPersonalInfoScreenState();
}

final TextEditingController surnameController = TextEditingController();
final TextEditingController nameController = TextEditingController();
final TextEditingController patronymicController = TextEditingController();
final TextEditingController dateController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController seriesPassportController = TextEditingController();
final TextEditingController numPassportController = TextEditingController();
final TextEditingController datePassportController = TextEditingController();
final TextEditingController placeController = TextEditingController();
final TextEditingController addressController = TextEditingController();

String? validatePassportSeries(String? value) {
  if (value == null || value.isEmpty || value.length != 4) {
    return 'Проверьте правильность данных';
  }
  return null;
}

String? validatePassportNumber(String? value) {
  if (value == null || value.isEmpty || value.length != 6) {
    return 'Проверьте правильность данных';
  }
  return null;
}

String? validateNulls(String? value) {
  if (value == null || value.isEmpty) {
    return 'Поле не может быть пустым';
  }
  return null;
}

String? validateDateOfBirth(DateTime? value) {
  if (value == null) {
    return 'Выберите дату рождения';
  }
  return null;
}

String? validateDateOfPassport(DateTime? value) {
  if (value == null) {
    return 'Выберите дату выдачи паспорта';
  }
  return null;
}

class _EditPersonalInfoScreenState extends State<EditPersonalInfoScreen> {
  late final GlobalKey<FormState> _surnameKey = GlobalKey<FormState>();
  late final GlobalKey<FormState> _nameKey = GlobalKey<FormState>();
  late final GlobalKey<FormState> _patronymicKey = GlobalKey<FormState>();
  late final GlobalKey<FormState> _dateOfBirthKey = GlobalKey<FormState>();
  late final GlobalKey<FormState> _emailKey = GlobalKey<FormState>();
  late final GlobalKey<FormState> _seriesPassportKey = GlobalKey<FormState>();
  late final GlobalKey<FormState> _numPassportKey = GlobalKey<FormState>();
  late final GlobalKey<FormState> _datePassportKey = GlobalKey<FormState>();
  late final GlobalKey<FormState> _placeKey = GlobalKey<FormState>();
  late final GlobalKey<FormState> _addressKey = GlobalKey<FormState>();

  DateTime selectedDateOfBirth = DateTime.now();
  DateTime selectedDatePassport = DateTime.now();

  String formattedDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  late AccountModel args;

  @override
  void initState() {
    super.initState();
    // Ничего не делаем в initState
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    args = ModalRoute.of(context)!.settings.arguments as AccountModel;

    surnameController.text = args.last_name ?? '';
    nameController.text = args.first_name ?? '';
    patronymicController.text = args.patronymic ?? '';
    emailController.text = args.email ?? '';
    seriesPassportController.text = args.passport_series ?? '';
    numPassportController.text = args.passport_number ?? '';
    placeController.text = args.place_of_issue ?? '';
    addressController.text = args.registration_address ?? '';
  }

  Future<void> patchUserData() async {
    if (_surnameKey.currentState!.validate() &&
        _nameKey.currentState!.validate() &&
        _patronymicKey.currentState!.validate() &&
        _emailKey.currentState!.validate() &&
        _seriesPassportKey.currentState!.validate() &&
        _numPassportKey.currentState!.validate() &&
        _placeKey.currentState!.validate() &&
        _addressKey.currentState!.validate() &&
        _dateOfBirthKey.currentState!.validate() &&
        _datePassportKey.currentState!.validate()) {
      try {
        Map<String, dynamic> updatedData = {};

        if (surnameController.text != args.last_name) {
          updatedData['last_name'] = surnameController.text;
        }

        if (nameController.text != args.first_name) {
          updatedData['first_name'] = nameController.text;
        }

        if (patronymicController.text != args.patronymic) {
          updatedData['patronymic'] = patronymicController.text;
        }

        if (selectedDateOfBirth != args.date_of_birth) {
          updatedData['date_of_birth'] =
              DateFormat('yyyy-MM-dd').format(selectedDateOfBirth).toString();
        }

        if (emailController.text != args.email) {
          updatedData['email'] = emailController.text;
        }

        if (seriesPassportController.text != args.passport_series) {
          updatedData['passport_series'] = seriesPassportController.text;
        }

        if (numPassportController.text != args.passport_number) {
          updatedData['passport_number'] = numPassportController.text;
        }

        if (selectedDatePassport != args.date_of_issue) {
          updatedData['date_of_issue'] =
              DateFormat('yyyy-MM-dd').format(selectedDatePassport).toString();
        }

        if (placeController.text != args.place_of_issue) {
          updatedData['place_of_issue'] = placeController.text;
        }

        if (addressController.text != args.registration_address) {
          updatedData['registration_address'] = addressController.text;
        }

        if (updatedData.isNotEmpty) {
          Response response = await apiService.dio.patch(
              'https://fohowomsk.ru/api/user-update/${args.id}',
              data: updatedData);

          if (response.statusCode == 200) {
            Navigator.of(context).pop();
          } else {
            print('Error in else');
          }
        } else {
          print('No data to update');
        }
      } catch (e) {
        print('Error in catch: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Личная информация'),
        backgroundColor: Colors.blueAccent.shade100,
      ),
      body: Center(
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(5),
              child: Form(
                key: _surnameKey,
                child: TextFormField(
                  controller: surnameController,
                  style: TextStyle(color: Colors.blueAccent.shade100),
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.person_outlined,
                      color: Colors.blueAccent.shade100,
                    ),
                    hintText: args.last_name ?? '',
                    hintStyle: TextStyle(color: Colors.blueAccent.shade100),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent.shade100),
                    ),
                  ),
                  validator: validateNulls,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: Form(
                key: _nameKey,
                child: TextFormField(
                  controller: nameController,
                  style: TextStyle(color: Colors.blueAccent.shade100),
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.person_outlined,
                      color: Colors.blueAccent.shade100,
                    ),
                    hintText: args.first_name,
                    hintStyle: TextStyle(color: Colors.blueAccent.shade100),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent.shade100),
                    ),
                  ),
                  validator: validateNulls,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: Form(
                key: _patronymicKey,
                child: TextFormField(
                  controller: patronymicController,
                  style: TextStyle(color: Colors.blueAccent.shade100),
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.person_outlined,
                      color: Colors.blueAccent.shade100,
                    ),
                    hintText: args.patronymic,
                    hintStyle: TextStyle(color: Colors.blueAccent.shade100),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent.shade100),
                    ),
                  ),
                  validator: validateNulls,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: Form(
                key: _dateOfBirthKey,
                child: InkWell(
                  onTap: () {
                    _selectDateOfBirth(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueAccent.shade100),
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      children: [
                        Icon(
                          Icons.cake_outlined,
                          color: Colors.blueAccent.shade100,
                        ),
                        SizedBox(width: 8.0),
                        Text(
                          formattedDate(selectedDateOfBirth),
                          style: TextStyle(color: Colors.blueAccent.shade100),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Divider(
              endIndent: 20,
              indent: 20,
              thickness: 2,
              color: Colors.blueAccent.shade100,
            ),
            Padding(
                padding: EdgeInsets.all(2),
                child: Text('Контакная информация')),
            Padding(
              padding: EdgeInsets.all(5),
              child: Form(
                key: _emailKey,
                child: TextFormField(
                  controller: emailController,
                  style: TextStyle(color: Colors.blueAccent.shade100),
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.mail_outline,
                      color: Colors.blueAccent.shade100,
                    ),
                    hintText: args.email,
                    hintStyle: TextStyle(color: Colors.blueAccent.shade100),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent.shade100),
                    ),
                  ),
                  validator: validateNulls,
                ),
              ),
            ),
            Divider(
              endIndent: 20,
              indent: 20,
              thickness: 2,
              color: Colors.blueAccent.shade100,
            ),
            Padding(
                padding: EdgeInsets.all(2), child: Text('Паспортные данные')),
            Row(
              children: [
                SizedBox(
                  width: 205.5,
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Form(
                      key: _seriesPassportKey,
                      child: TextFormField(
                        controller: seriesPassportController,
                        style: TextStyle(color: Colors.blueAccent.shade100),
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.edit_document,
                            color: Colors.blueAccent.shade100,
                          ),
                          hintText: args.passport_series,
                          hintStyle:
                              TextStyle(color: Colors.blueAccent.shade100),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blueAccent.shade100),
                          ),
                        ),
                        validator: validatePassportSeries,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 205.5,
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Form(
                      key: _numPassportKey,
                      child: TextFormField(
                        controller: numPassportController,
                        style: TextStyle(color: Colors.blueAccent.shade100),
                        decoration: InputDecoration(
                          hintText: args.passport_number,
                          hintStyle:
                              TextStyle(color: Colors.blueAccent.shade100),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blueAccent.shade100),
                          ),
                        ),
                        validator: validatePassportNumber,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: Form(
                key: _datePassportKey,
                child: InkWell(
                  onTap: () {
                    _selectDatePassport(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueAccent.shade100),
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      children: [
                        SizedBox(width: 8.0),
                        Text(
                          formattedDate(selectedDatePassport),
                          style: TextStyle(color: Colors.blueAccent.shade100),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: Form(
                key: _placeKey,
                child: TextFormField(
                  controller: placeController,
                  style: TextStyle(color: Colors.blueAccent.shade100),
                  decoration: InputDecoration(
                    hintText: args.place_of_issue,
                    hintStyle: TextStyle(color: Colors.blueAccent.shade100),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent.shade100),
                    ),
                  ),
                  validator: validateNulls,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: Form(
                key: _addressKey,
                child: TextFormField(
                  controller: addressController,
                  style: TextStyle(color: Colors.blueAccent.shade100),
                  decoration: InputDecoration(
                    hintText: args.registration_address,
                    hintStyle: TextStyle(color: Colors.blueAccent.shade100),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent.shade100),
                    ),
                  ),
                  validator: validateNulls,
                ),
              ),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent.shade100,
                  fixedSize: Size(230, 50),
                ),
                onPressed: patchUserData,
                child: Text('Сохранить'))
          ],
        ),
      ),
    );
  }

  Future<void> _selectDateOfBirth(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDateOfBirth,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDateOfBirth) {
      setState(() {
        selectedDateOfBirth = picked;
        dateController.text =
            DateFormat('yyyy-MM-dd').format(selectedDateOfBirth);
      });
    }
  }

  Future<void> _selectDatePassport(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDatePassport,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDatePassport) {
      setState(() {
        selectedDatePassport = picked;
        datePassportController.text =
            DateFormat('yyyy-MM-dd').format(selectedDatePassport);
      });
    }
  }
}
