import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AuthorizationScreen extends StatefulWidget {
  const AuthorizationScreen({Key? key});

  @override
  State<AuthorizationScreen> createState() => _AuthorizationScreenState();
}

class _AuthorizationScreenState extends State<AuthorizationScreen> {
  final TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> phoneFormKey = GlobalKey<FormState>();

  Future<void> postAuth() async {
    if (phoneFormKey.currentState!.validate()) {
      try {
        Dio dio = Dio();
        Response response = await dio.post(
          'https://fohowomsk.ru/api/send/phone/',
          data: {'phone_number': '+7' + phoneController.text},
        );
        if (response.statusCode == 200) {
          Navigator.of(context).pushNamed('/auth_phone_check_screen',
              arguments: phoneController.text.toString());
          print('Успешная регистрация');
        } else {
          print('Error in else');
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
          'Авторизация',
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
            Padding(
              padding: EdgeInsets.all(5),
              child: ElevatedButton(
                onPressed: () {
                  postAuth();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent.shade100,
                  fixedSize: Size(230, 50),
                ),
                child: Text(
                  'Войти',
                ),
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: 35,
                ),
                Text(
                  'Нет аккаунта?',
                  style: TextStyle(
                    color: Colors.blueAccent.shade100,
                    fontWeight: FontWeight.w300,
                    fontSize: 25,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  'Регистрация',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                    fontSize: 25,
                  ),
                ),
                IconButton(
                  onPressed: () =>
                      Navigator.of(context).pushNamed('/registration_screen'),
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
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
