import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../repository/data/services/api_service.dart';

class CoachCreatePersonalTrainingScreen extends StatefulWidget {
  const CoachCreatePersonalTrainingScreen({Key? key});

  @override
  State<CoachCreatePersonalTrainingScreen> createState() =>
      _CoachCreatePersonalTrainingScreenState();
}

class _CoachCreatePersonalTrainingScreenState
    extends State<CoachCreatePersonalTrainingScreen> {
  late DateTime selectedDate;

  _CoachCreatePersonalTrainingScreenState() {
    selectedDate = DateTime.now();
  }

  Future<void> postPersonalTraining() async {
    try {
      apiService;
      Response response = await apiService.dio.post(
        'https://fohowomsk.ru/api/schedule/',
        data: {
          'time': formattedDateTime
        },
      );
      if (response.statusCode == 201) {
        Navigator.pop(context, selectedDate);
        print('Успешная регистрация');
      } else {
        print('Error in else');
      }
    } catch (e) {
      print('Error in catch: $e');
    }
  }

  String formattedDateTime = DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Создать расписание'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent.shade100,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(5),
              child: Text(
                'Введите данные о расписании',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: InkWell(
                onTap: () {
                  _selectDate(context);
                },
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueAccent.shade100),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        color: Colors.blueAccent.shade100,
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        selectedDate != null
                            ? DateFormat('yyyy-MM-dd').format(selectedDate)
                            : 'Выберите дату',
                        style: TextStyle(color: Colors.blueAccent.shade100),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueAccent.shade100),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                    border: InputBorder.none,
                    hintText: 'Укажите время',
                    hintStyle: TextStyle(color: Colors.blueAccent.shade100),
                  ),
                  items: <String>[
                    '07:00',
                    '07:30',
                    '08:00',
                    '08:30',
                    '09:00',
                    '09:30',
                    '10:00',
                    '10:30',
                    '11:00',
                    '11:30',
                    '12:00',
                    '12:30',
                    '13:00',
                    '13:30',
                    '14:00',
                    '14:30',
                    '15:00',
                    '15:30',
                    '16:00',
                    '16:30',
                    '17:00',
                    '17:30',
                    '18:00',
                    '18:30',
                    '19:00',
                    '19:30',
                    '20:00',
                    '20:30',
                    '21:00',
                    '21:30',
                    '22:00',
                    '22:30',
                    '23:00'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {},
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: ElevatedButton(
                  onPressed: postPersonalTraining,
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(230, 50),
                      backgroundColor: Colors.blueAccent.shade100),
                  child: Text('Создать')),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
}
