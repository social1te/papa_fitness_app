import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BalanceConfirmScreen extends StatelessWidget {
  const BalanceConfirmScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as List<String>;

    void _launchUrl() async {
      final Uri url = Uri.parse(args[2]);
      if (!await launchUrl(url)) {
        throw Exception('nea))');
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Подтверждение оплаты',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: Colors.blueAccent.shade100,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Вы собираетесь оплатить абонемент на сумму: ${args[0]}',
              style: TextStyle(color: Colors.black, fontSize: 20),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              'Чек придет на вашу почту: ${args[1]}',
              style: TextStyle(color: Colors.black, fontSize: 20),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: _launchUrl,
              style: ElevatedButton.styleFrom(
                primary: Colors.blueAccent.shade100,
                onPrimary: Colors.white,
                fixedSize: Size(230, 50),
              ),
              child: Text(
                'Пополнить',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
