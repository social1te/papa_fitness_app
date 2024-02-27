import 'package:dio/dio.dart';
import 'package:fitness_app/src/repository/data/coach_models/coach_trainings_model.dart';
import 'package:fitness_app/src/repository/data/services/api_service.dart';
import 'package:flutter/material.dart';

class CoachEditPersonalTraining extends StatefulWidget {
  const CoachEditPersonalTraining({super.key});

  @override
  State<CoachEditPersonalTraining> createState() => _CoachEditPersonalTrainingState();
}

final TextEditingController titleController = TextEditingController();
final TextEditingController timeController = TextEditingController();
final TextEditingController durationController = TextEditingController();
final TextEditingController priceController = TextEditingController();
final TextEditingController limitOfParticipantsController =
TextEditingController();
final TextEditingController contentController = TextEditingController();
DateTime selectedDate = DateTime.now();

class _CoachEditPersonalTrainingState extends State<CoachEditPersonalTraining> {
  Future<void> patchSchedulePersonalTraining() async {
    try {
      String startDateValue = selectedDate.year.toString() +
          '-' +
          selectedDate.month.toString().padLeft(2, '0') +
          '-' +
          selectedDate.day.toString().padLeft(2, '0') +
          ' ' +
          timeController.text;

      if (args.time != null && timeController.text.isEmpty) {
        startDateValue = args.time.toString();
      }

      Response response = await apiService.dio.patch(
        'https://fohowomsk.ru/api/schedule/${args.id}/',
        data: {
          'time': startDateValue,
          'is_selected': args.is_selected
        },
      );
      print(selectedDate.year.toString() +
          '-' +
          selectedDate.month.toString() +
          '-' +
          selectedDate!.day.toString() +
          ' ' +
          timeController.text);
      if (response.statusCode == 200) {
        print('Успешная регистрация');
        Navigator.pop(context);
      } else {
        print('Error in else');
      }
    } catch (e) {
      print(selectedDate.year.toString() +
          '-' +
          selectedDate.month.toString() +
          '-' +
          selectedDate!.day.toString() +
          ' ' +
          timeController.text);
      print('Error in catch: $e');
    }
  }

  Future<void> deleteSchedulePersonalTraining() async {
    try {
      Response response = await apiService.dio
          .delete('https://fohowomsk.ru/api/schedule/${args.id}/');
      if (response.statusCode == 204) {
        print('Успешно удалено');
        Navigator.pop(context);
      } else {
        print('Error in else');
      }
    } catch (e) {
      print('Error in catch: $e');
    }
  }

  late final args =
  ModalRoute.of(context)!.settings.arguments as CoachSchedule;

  void _showDeleteConfirmationBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Вы уверены, что хотите удалить тренировку?',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  deleteSchedulePersonalTraining();
                  Navigator.of(context).pop();
                },
                child: Text('Удалить'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
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
      appBar: AppBar(
        centerTitle: true,
        title: Text('Изменение тренировки'),
        backgroundColor: Colors.blueAccent.shade100,
        actions: [
          IconButton(
              onPressed: () {
                _showDeleteConfirmationBottomSheet(context);
              },
              icon: Icon(
                Icons.delete,
                color: Colors.white,
              ))
        ],
      ),
      body: Center(
        child: ListView(
          children: [
            InkWell(
              onTap: () {
                _selectDate(context);
              },
              child: InputDecorator(
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.calendar_today,
                    color: Colors.blueAccent.shade100,
                  ),
                  hintText: args.time.toString(),
                  hintStyle: TextStyle(color: Colors.blueAccent.shade100),
                ),
                child: Text(
                  '${args.time.year}-${args.time.month < 10 ? '0${args.time.month}' : args.time.month}-${args.time.day < 10 ? '0${args.time.day}' : args.time.day}',
                  style: TextStyle(color: Colors.blueAccent.shade100),
                ),
              ),
            ),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value:
              timeController.text.isNotEmpty ? timeController.text : null,
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
              onChanged: (newValue) {
                setState(() {
                  timeController.text = newValue!;
                });
              },
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.calendar_today,
                  color: Colors.blueAccent.shade100,
                ),
                hintText: args.time.hour.toString() +
                    ':' +
                    args.time.minute.toString(),
                hintStyle: TextStyle(color: Colors.blueAccent.shade100),
              ),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent.shade100,
                  fixedSize: Size(230, 50),
                ),
                onPressed: patchSchedulePersonalTraining,
                child: Text('Сохранить'))
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
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }
}
