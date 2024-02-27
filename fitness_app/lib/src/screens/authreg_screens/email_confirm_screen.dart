import 'package:dio/dio.dart';
import 'package:fitness_app/src/repository/data/models/account_model.dart';
import 'package:flutter/material.dart';

class EmailConfirmScreen extends StatelessWidget {
  const EmailConfirmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    late final args =
        ModalRoute.of(context)!.settings.arguments as AccountModel;

    Future<void> getEmail() async {
      try {
        Dio dio = Dio();
        Response response = await dio.get(
          'https://fohowomsk.ru/api/check-email-verify/${args.id.toString()}/',
        );
        if (response.statusCode == 200) {
          Navigator.of(context).pushNamed('/authorization_screen');
          print('Успешная регистрация');
        } else {
          print('Error in else');
        }
      } catch (e) {
        print('Error in catch: $e');
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent.shade100,
        centerTitle: true,
        title: Text('Подтверждение почты'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Сообщение было отправлено на вашу почту:' +
                  args.email.toString() +
                  '\n' +
                  'пожалуйста, следуйте указаниям в нем',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent.shade100,
                    fixedSize: Size(230, 50)),
                onPressed: getEmail,
                child: Text('Подтвердить'))
          ],
        ),
      ),
    );
  }
}
