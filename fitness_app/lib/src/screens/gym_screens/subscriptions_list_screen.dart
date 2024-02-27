import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../repository/data/services/api_service.dart';

class SubscriptionsListScreen extends StatefulWidget {
  const SubscriptionsListScreen({Key? key});

  @override
  State<SubscriptionsListScreen> createState() =>
      _SubscriptionsListScreenState();
}

class _SubscriptionsListScreenState extends State<SubscriptionsListScreen> {

  void _showConfirmationDialog(String duration, String price) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Вы собираетесь приобрести абонемент длиной в $duration стоимостью в $price?',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(230, 50),
                    backgroundColor: Colors.blueAccent.shade100),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Да'),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Отмена'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.blueAccent.shade100,
        title: Text(
          'Абонементы',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: () => _showConfirmationDialog('1', '3000'),
              child: Card(
                elevation: 12,
                color: Colors.blueAccent.shade100,
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  leading: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Center(
                      child: Text(
                        '1',
                        style: TextStyle(
                          color: Colors.blueAccent.shade100,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    'Абонемент 1 месяц',
                    style: TextStyle(color: Colors.black),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                  subtitle: Text(
                    '3000 руб',
                    style: TextStyle(color: Colors.blue.shade100),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => _showConfirmationDialog('3', '6000'),
              child: Card(
                elevation: 12,
                color: Colors.blueAccent.shade100,
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  leading: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Center(
                      child: Text(
                        '3',
                        style: TextStyle(
                          color: Colors.blueAccent.shade100,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    'Абонемент 3 месяца',
                    style: TextStyle(color: Colors.black),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                  subtitle: Text(
                    '6000 руб',
                    style: TextStyle(color: Colors.blue.shade100),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => _showConfirmationDialog('6', '7000'),
              child: Card(
                elevation: 12,
                color: Colors.blueAccent.shade100,
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  leading: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Center(
                      child: Text(
                        '6',
                        style: TextStyle(
                          color: Colors.blueAccent.shade100,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    'Абонемент 6 месяцев',
                    style: TextStyle(color: Colors.black),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                  subtitle: Text(
                    '7000 руб',
                    style: TextStyle(color: Colors.blue.shade100),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => _showConfirmationDialog('12', '12000'),
              child: Card(
                elevation: 12,
                color: Colors.blueAccent.shade100,
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  leading: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Center(
                      child: Text(
                        '12',
                        style: TextStyle(
                          color: Colors.blueAccent.shade100,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    'Абонемент 12 месяцев',
                    style: TextStyle(color: Colors.black),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                  subtitle: Text(
                    '12000 руб',
                    style: TextStyle(color: Colors.blue.shade100),
                  ),
                ),
              ),
            ),
            Divider(
              thickness: 2,
              color: Colors.blueAccent.shade100,
              endIndent: 20,
              indent: 20,
            ),
            GestureDetector(
              onTap: () => Navigator.of(context).pushNamed(
                  '/personal_trainings_screen',
                  arguments: ['1', '1000']),
              child: Card(
                elevation: 12,
                color: Colors.blueAccent.shade100,
                child: ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  leading: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Center(
                      child: Text(
                        '1',
                        style: TextStyle(
                            color: Colors.blueAccent.shade100,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                  ),
                  title: Text(
                    '1 тренировка с тренером',
                    style: TextStyle(color: Colors.black),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                  subtitle: Text('1000 рублей',
                      style: TextStyle(color: Colors.blue.shade100)),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.of(context).pushNamed(
                  '/personal_trainings_screen',
                  arguments: ['8', '8000']),
              child: Card(
                elevation: 12,
                color: Colors.blueAccent.shade100,
                child: ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  leading: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Center(
                      child: Text(
                        '8',
                        style: TextStyle(
                            color: Colors.blueAccent.shade100,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                  ),
                  title: Text(
                    '8 тренировок с тренером',
                    style: TextStyle(color: Colors.black),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                  subtitle: Text('8000 рублей',
                      style: TextStyle(color: Colors.blue.shade100)),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.of(context).pushNamed(
                  '/personal_trainings_screen',
                  arguments: ['16', '12800']),
              child: Card(
                elevation: 12,
                color: Colors.blueAccent.shade100,
                child: ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  leading: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Center(
                      child: Text(
                        '16',
                        style: TextStyle(
                            color: Colors.blueAccent.shade100,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                  ),
                  title: Text(
                    '16 тренировок с тренером',
                    style: TextStyle(color: Colors.black),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                  subtitle: Text('12800 рублей',
                      style: TextStyle(color: Colors.blue.shade100)),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.of(context).pushNamed(
                  '/personal_trainings_screen',
                  arguments: ['32', '19200']),
              child: Card(
                elevation: 12,
                color: Colors.blueAccent.shade100,
                child: ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  leading: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Center(
                      child: Text(
                        '32',
                        style: TextStyle(
                            color: Colors.blueAccent.shade100,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                  ),
                  title: Text(
                    '32 тренировки с тренером',
                    style: TextStyle(color: Colors.black),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                  subtitle: Text('19200 рублей',
                      style: TextStyle(color: Colors.blue.shade100)),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.of(context).pushNamed(
                  '/subscription_buy_screen',
                  arguments: ['64', '25600']),
              child: Card(
                elevation: 12,
                color: Colors.blueAccent.shade100,
                child: ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  leading: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Center(
                      child: Text(
                        '64',
                        style: TextStyle(
                            color: Colors.blueAccent.shade100,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                  ),
                  title: Text(
                    '64 тренировки с тренером',
                    style: TextStyle(color: Colors.black),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                  subtitle: Text('25600 рублей',
                      style: TextStyle(color: Colors.blue.shade100)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
