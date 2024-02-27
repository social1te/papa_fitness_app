import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> phoneFormKey = GlobalKey<FormState>();
  bool isRulesChecked = false;

  Future<void> postReg() async {
    if (phoneFormKey.currentState!.validate()) {
      try {
        if (isRulesChecked) {
          Dio dio = Dio();
          Response response = await dio.post(
            'https://fohowomsk.ru/api/send/phone/',
            data: {'phone_number': '+7' + phoneController.text!},
          );
          if (response.statusCode == 200) {
            Navigator.of(context).pushNamed('/phone_check_screen',
                arguments: phoneController.text.toString());
            print('Успешная регистрация');
          } else {
            print('Error in else');
          }
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
        backgroundColor: Colors.blueAccent.shade100,
        title: Text(
          'Регистрация',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Приветствуем в ПапаФитнес!',
              style: TextStyle(color: Colors.black, fontSize: 28),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 5, top: 5, right: 20, left: 20),
              child: Form(
                key: phoneFormKey,
                child: _buildInputField(
                  hintText: 'Номер телефона',
                  icon: Icons.phone_android,
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  key: UniqueKey(), // Добавлен ключ
                ),
              ),
            ),
            // Padding(
            //   padding: EdgeInsets.all(5),
            //   child: Form(
            //     key: phoneFormKey,
            //     child: TextFormField(
            //       style: TextStyle(color: Colors.blueAccent.shade100),
            //       controller: phoneController,
            //       decoration: InputDecoration(
            //         prefixIcon: Icon(
            //           Icons.phone_android,
            //           color: Colors.blueAccent.shade100,
            //         ),
            //         hintText: 'Номер телефона',
            //         prefixText: '+7 ',
            //         hintStyle: TextStyle(color: Colors.blueAccent.shade100),
            //         border: OutlineInputBorder(
            //           borderSide: BorderSide(color: Colors.white),
            //         ),
            //         filled: true,
            //         fillColor: Colors.white,
            //         enabledBorder: OutlineInputBorder(
            //           borderSide: BorderSide(color: Colors.blueAccent.shade100),
            //         ),
            //       ),
            //       validator: (value) {
            //         if (value == null || value.isEmpty) {
            //           return 'Номер телефона не может быть пустым';
            //         }
            //         if (!RegExp(r'^\d{10}$').hasMatch(value)) {
            //           return 'Введите корректный номер телефона';
            //         }
            //         return null;
            //       },
            //     ),
            //   ),
            // ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              child: Row(
                children: [
                  Checkbox(
                    value: isRulesChecked,
                    onChanged: (value) {
                      setState(() {
                        isRulesChecked = value ?? false; // Обновляем состояние чекбокса
                      });
                    },
                  ),
                  GestureDetector(
                    onTap: ()=> Navigator.of(context).pushNamed('/user_agreement_screen'),
                    child: Text(
                      'Ознакомлен с правилами, согласен на ' + '\n' + 'обработку персональных данных',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blueAccent,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: ElevatedButton(
                onPressed: () {
                  postReg();
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent.shade100,
                    fixedSize: Size(230, 50)),
                child: Text(
                  'Получить SMS-код',
                ),
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: 60,
                ),
                Text(
                  'Есть аккаунт?',
                  style: TextStyle(
                      color: Colors.blueAccent.shade100,
                      fontWeight: FontWeight.w300,
                      fontSize: 25),
                ),
                SizedBox(width: 10),
                Text(
                  'Войти',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                      fontSize: 25),
                ),
                IconButton(
                  onPressed: () =>
                      Navigator.of(context).pushNamed('/authorization_screen'),
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
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
  required Key key, // Добавлен обязательный параметр ключа
}) {
  return Container(
    margin: EdgeInsets.only(bottom: 10),
    child: TextFormField(
      style: TextStyle(color: Colors.blueAccent.shade100),
      key: key,
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: Colors.blueAccent.shade100,
        ),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.blueAccent.shade100),
        prefixText: '+7 ',
        filled: true,
        fillColor: Colors.blue.withOpacity(0.1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Номер телефона не может быть пустым';
        }
        if (!RegExp(r'^\d{10}$').hasMatch(value)) {
          return 'Введите корректный номер телефона';
        }
        return null;
      },
    ),
  );
}
