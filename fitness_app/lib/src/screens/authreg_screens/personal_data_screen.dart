import 'package:dio/dio.dart';
import 'package:fitness_app/src/repository/data/models/account_model.dart';
import 'package:fitness_app/src/repository/data/services/api_service.dart';
import 'package:flutter/material.dart';

class PersonalDataScreen extends StatefulWidget {
  const PersonalDataScreen({super.key});

  @override
  State<PersonalDataScreen> createState() => _PersonalDataScreenState();
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
DateTime selectedDateOfBirth = DateTime.now();
DateTime selectedDatePassport = DateTime.now();

String? _validateText(String? value) {
  if (value == null || value.isEmpty) {
    return 'Это поле не может быть пустым';
  }
  return null;
}

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

class _PersonalDataScreenState extends State<PersonalDataScreen> {
  final GlobalKey<FormState> _surnameKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _nameKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _patronymicKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _dateOfBirthKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _emailKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _seriesPassportKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _numPassportKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _datePassportKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _placeKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _addressKey = GlobalKey<FormState>();


  void showSuccessSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Данные успешно сохранены'),
        backgroundColor:
            Colors.blueAccent.shade100,
      ),
    );
  }

  Future<void> patchUserData() async {
    if (_surnameKey.currentState!.validate() &&
        _nameKey.currentState!.validate() &&
        _patronymicKey.currentState!.validate() &&
        _patronymicKey.currentState!.validate() &&
        _dateOfBirthKey.currentState!.validate() &&
        _emailKey.currentState!.validate() &&
        _seriesPassportKey.currentState!.validate() &&
        _numPassportKey.currentState!.validate() &&
        _datePassportKey.currentState!.validate() &&
        _placeKey.currentState!.validate() &&
        _addressKey.currentState!.validate()) {
      try {
        apiService;
        print('https://fohowomsk.ru/api/users-update/$args');
        Response response = await apiService.dio
            .patch('https://fohowomsk.ru/api/user-update/$args/', data: {
          'last_name': surnameController.text,
          'first_name': nameController.text,
          'patronymic': patronymicController.text,
          'date_of_birth': dateController.text,
          'email': emailController.text,
          'passport_series': seriesPassportController.text,
          'passport_number': numPassportController.text,
          'date_of_issue': datePassportController.text,
          'place_of_issue': placeController.text,
          'registration_address': addressController.text,
        });
        if (response.statusCode == 200) {
          Navigator.of(context).pushNamed('/email_confirm_screen',
              arguments: [args.id.toString(), args.email.toString()]);
          showSuccessSnackBar();
        } else {
          print('Error in else');
        }
      } catch (e) {
        print('Error in catch: $e');
      }
    }
  }

  late final args = ModalRoute.of(context)!.settings.arguments as AccountModel;

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
                    hintText: 'Фамилия',
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
                    hintText: 'Имя',
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
                    hintText: 'Отчество',
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
                child: TextFormField(
                  controller: dateController,
                  style: TextStyle(color: Colors.blueAccent.shade100),
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.cake_outlined,
                      color: Colors.blueAccent.shade100,
                    ),
                    hintText: 'Дата рождения (год - месяц - день)',
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
                    hintText: 'Эл. почта',
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
                          hintText: 'Серия паспорта',
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
                          hintText: 'Номер паспорта',
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
                child: TextFormField(
                  controller: datePassportController,
                  style: TextStyle(color: Colors.blueAccent.shade100),
                  decoration: InputDecoration(
                    hintText: 'Дата выдачи (год - месяц - день)',
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
                key: _placeKey,
                child: TextFormField(
                  controller: placeController,
                  style: TextStyle(color: Colors.blueAccent.shade100),
                  decoration: InputDecoration(
                    hintText: 'Место выдачи',
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
                    hintText: 'Адрес регистрации',
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
}

Widget _buildInputField({
  required String hintText,
  required IconData icon,
  required TextEditingController controller,
  TextInputType keyboardType = TextInputType.text,
}) {
  return Container(
    margin: EdgeInsets.only(bottom: 10),
    child: TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: Colors.blueAccent.shade100,
        ),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.blueAccent.shade100),
        filled: true,
        fillColor: Colors.blue.withOpacity(0.1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    ),
  );
}

// Widget _buildDatePickerField(BuildContext context) {
//   return Container(
//     margin: EdgeInsets.only(bottom: 10),
//     child: InkWell(
//       onTap: () {
//         _selectDate(context);
//       },
//       child: InputDecorator(
//         decoration: InputDecoration(
//           prefixIcon: Icon(
//             Icons.calendar_today,
//             color: Colors.blueAccent.shade100,
//           ),
//           hintText: 'Выберите день',
//           hintStyle: TextStyle(color: Colors.blueAccent.shade100),
//           filled: true,
//           fillColor: Colors.blue.withOpacity(0.1),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide: BorderSide.none,
//           ),
//         ),
//         child: Text(
//           "${selectedDate.toLocal()}".split(' ')[0],
//           style: TextStyle(color: Colors.blueAccent.shade100),
//         ),
//       ),
//     ),
//   );
// }



// Future<void> _selectDate(BuildContext context) async {
//   final DateTime? picked = await showDatePicker(
//     context: context,
//     initialDate: selectedDate,
//     firstDate: DateTime(1900),
//     lastDate: DateTime.now(),
//   );
//   if (picked != null && picked != selectedDate)
//     setState(() {
//       selectedDate = picked;
//     });
// }
