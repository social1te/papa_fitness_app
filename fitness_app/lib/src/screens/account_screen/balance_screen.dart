import 'package:dio/dio.dart';
import 'package:fitness_app/src/repository/data/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BalanceScreen extends StatefulWidget {
  const BalanceScreen({Key? key});

  @override
  State<BalanceScreen> createState() => _BalanceScreenState();
}

class _BalanceScreenState extends State<BalanceScreen> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  late String paymentUrl;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Поле не может быть пустым';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Некорректный формат электронной почты';
    }
    return null;
  }

  String? _validateAmount(String? value) {
    if (value == null || value.isEmpty) {
      return 'Поле не может быть пустым';
    }
    return null;
  }

  void _launchUrl() async {
    final Uri url = Uri.parse(paymentUrl);
    if (!await launchUrl(url)) {
      throw Exception('nea))');
    }
  }

  Future<void> postPayment() async {
    try {
      apiService;
      Response response = await apiService.dio.post(
        'https://fohowomsk.ru/api/payment/create/',
        data: {'email': emailController.text, 'amount': amountController.text},
      );
      if (response.statusCode == 200) {
        paymentUrl = response.data['payment_url'];
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Container(
              height: 200,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Вы собираетесь пополнить счет на сумму: ${amountController.text}',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      'Чек придет на почту: ${emailController.text}',
                      style: TextStyle(fontSize: 18),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: ElevatedButton(
                        onPressed: () {
                          _launchUrl();
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(230, 50),
                          backgroundColor: Colors.blueAccent.shade100
                        ),
                        child: Text('Перейти к оплате'),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
        print('Успешно');
      } else {
        print('Error in else');
      }
    } catch (e) {
      print('Error in catch: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Мой баланс',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent.shade100,
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  'Пожалуйста, введите почту, на которую придет чек и сумму, на которую вы хотите пополнить баланс',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: TextFormField(
                  style: TextStyle(color: Colors.blueAccent.shade100),
                  controller: emailController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.mail,
                      color: Colors.blueAccent.shade100,
                    ),
                    hintText: 'Почта',
                    hintStyle: TextStyle(color: Colors.blueAccent.shade100),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: Colors.blueAccent.shade100),
                    ),
                  ),
                  validator: _validateEmail,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: TextFormField(
                  style: TextStyle(color: Colors.blueAccent.shade100),
                  controller: amountController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.attach_money,
                      color: Colors.blueAccent.shade100,
                    ),
                    hintText: 'Сумма',
                    hintStyle: TextStyle(color: Colors.blueAccent.shade100),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: Colors.blueAccent.shade100),
                    ),
                  ),
                  validator: _validateAmount,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      postPayment();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      fixedSize: Size(230, 50),
                      side: BorderSide(
                        color: Colors.blueAccent.shade100,
                      )),
                  child: Text(
                    'Пополнить',
                    style: TextStyle(color: Colors.blueAccent.shade100),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}