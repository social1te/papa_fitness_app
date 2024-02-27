import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class PhoneCheckScreen extends StatefulWidget {
  const PhoneCheckScreen({Key? key});

  @override
  State<PhoneCheckScreen> createState() => _PhoneCheckScreenState();
}

class _PhoneCheckScreenState extends State<PhoneCheckScreen> {
  final TextEditingController codeController1 = TextEditingController();
  final TextEditingController codeController2 = TextEditingController();
  final TextEditingController codeController3 = TextEditingController();
  final TextEditingController codeController4 = TextEditingController();

  late Timer _timer;
  int _counter = 60;
  bool _canResendCode = false;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_counter > 0) {
        setState(() {
          _counter--;
        });
      } else {
        setState(() {
          _canResendCode = true;
          _timer.cancel();
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Future<void> postCode() async {
    try {
      Dio dio = Dio();
      Response response = await dio.post(
        'https://fohowomsk.ru/api/verify/phone/',
        data: {'code': getCode(), 'phone_number': '+7' + args},
      );
      if (response.statusCode == 200) {
        Navigator.of(context)
            .pushNamed('/password_screen', arguments: '+7' + args.toString());
        print('Верификация пройдена');
      } else {
        print('Error in else');
        showSnackBar('Неверный код или неполный ввод');
      }
    } catch (e) {
      print('Error in catch: $e');
    }
  }

  String getCode() {
    return '${codeController1.text}${codeController2.text}${codeController3.text}${codeController4.text}';
  }

  late final args = ModalRoute.of(context)!.settings.arguments as String;

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent.shade100,
        title: Text(
          'Подтверждение номера',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 195),
              Text(
                'Код был выслан на номер',
                style: TextStyle(fontSize: 26, color: Colors.black),
              ),
              Text('+7' +
                args.toString(),
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent.shade100,
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildInputField(controller: codeController1),
                  SizedBox(width: 10),
                  _buildInputField(controller: codeController2),
                  SizedBox(width: 10),
                  _buildInputField(controller: codeController3),
                  SizedBox(width: 10),
                  _buildInputField(controller: codeController4),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: ElevatedButton(
                  onPressed: () {
                    if (isCodeValid()) {
                      postCode();
                    } else {
                      showSnackBar('Неверный код или неполный ввод');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent.shade100,
                    fixedSize: Size(230, 50),
                  ),
                  child: Text(
                    'Отправить',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 265),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 15),
                  Text(
                    _canResendCode
                        ? 'Отправить еще раз'
                        : 'Отправить еще раз через $_counter',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  IconButton(
                    onPressed: _canResendCode ? postCode : null,
                    icon: Icon(
                      Icons.repeat,
                      color: Colors.blueAccent.shade100,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCodeTextField(TextEditingController controller) {
    return Container(
      width: 50,
      height: 50,
      child: TextFormField(
        controller: controller,
        style: TextStyle(color: Colors.blueAccent.shade100),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueAccent.shade100),
          ),
        ),
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      height: 50,
      width: 50,
      margin: EdgeInsets.only(bottom: 10),
      child: TextFormField(
        style: TextStyle(color: Colors.blueAccent.shade100),
        controller: controller,
        decoration: InputDecoration(
          hintStyle: TextStyle(color: Colors.blueAccent.shade100),
          filled: true,
          fillColor: Colors.blue.withOpacity(0.1),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
  }

  bool isCodeValid() {
    return codeController1.text.isNotEmpty &&
        codeController2.text.isNotEmpty &&
        codeController3.text.isNotEmpty &&
        codeController4.text.isNotEmpty;
  }
}
