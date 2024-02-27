import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({Key? key}) : super(key: key);

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController = TextEditingController();

  Future<void> postPassword() async {
    if (_formKey.currentState!.validate()) {
      try {
        Dio dio = Dio();
        Response response = await dio.post(
          'https://fohowomsk.ru/auth/users/',
          data: {
            'phone_number': args,
            'password': passwordConfirmController.text
          },
        );
        if (response.statusCode == 201) {
          Map<String, dynamic> responseData = response.data;
          int id = responseData['id'];
          if (passwordController.text == passwordConfirmController.text) {
            Navigator.of(context)
                .pushNamed('/personal_data_screen', arguments: id);
          } else {
            print('Пароли не совпадают');
          }
        } else {
          print('Error in else');
        }
      } catch (e) {
        print('Error in catch: $e');
      }
    }
  }

  late final args = ModalRoute.of(context)!.settings.arguments as String;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent.shade100,
        title: Text(
          'Создание пароля',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Text(
                    'Создайте надежный пароль',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                    'Придумайте надежный пароль, состоящий из букв, цифр и других символов',
                    style: TextStyle(fontSize: 22),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                  child: _buildInputField(
                    hintText: 'Пароль',
                    icon: Icons.lock,
                    controller: passwordController,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                  child: _buildInputField(
                    hintText: 'Пароль (повторно)',
                    icon: Icons.lock,
                    controller: passwordConfirmController,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: ElevatedButton(
                    onPressed: postPassword,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent.shade100,
                      fixedSize: Size(230, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Ввести пароль',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
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
      style: TextStyle(color: Colors.blueAccent.shade100),
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
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Введите пароль';
        }
        if (value.length < 8) {
          return 'Пароль должен содержать не менее 8 символов';
        }
        if (!value.contains(RegExp(r'[a-zA-Z]'))) {
          return 'Пароль должен содержать хотя бы одну букву';
        }
        if (!value.contains(RegExp(r'\d'))) {
          return 'Пароль должен содержать хотя бы одну цифру';
        }
        return null;
      },
    ),
  );
}
