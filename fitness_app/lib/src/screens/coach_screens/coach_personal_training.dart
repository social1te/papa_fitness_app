import 'package:dio/dio.dart';
import 'package:fitness_app/src/repository/data/coach_models/coach_trainings_model.dart';
import 'package:flutter/material.dart';

import '../../repository/data/services/api_service.dart';

class CoachPersonalTrainingScreen extends StatefulWidget {
  const CoachPersonalTrainingScreen({super.key});

  @override
  State<CoachPersonalTrainingScreen> createState() => _CoachPersonalTrainingScreenState();
}

class _CoachPersonalTrainingScreenState extends State<CoachPersonalTrainingScreen> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as CoachPersonalTrainingsModel;

    String monthString;
    if (args!.training_date!.month < 10) {
      monthString = '0${args!.training_date!.month}';
    } else {
      monthString = args!.training_date!.month.toString();
    }

    Future<void> patchPersonalTraining() async {
      try {
        apiService;
        Response response = await apiService.dio.patch(
          'https://fohowomsk.ru/api/trainer_update_individual_event/${args.id}/',
          data: {
            'quantity': args.quantity - 1
          },
        );
        if (response.statusCode == 200) {
          Navigator.pop(context);
          print('Успешная регистрация');
        } else {
          print('Error in else');
        }
      } catch (e) {
        print('Error in catch: $e');
        print('https://fohowomsk.ru/api/trainer_update_individual_event/${args.id}/');
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent.shade100,
        centerTitle: true,
        title: Text('Персональная тренировка'),
      ),
      body: Center(
        child: ListView(
          children: [
            Card(
              elevation: 4,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.access_time,
                      color: Colors.blueAccent.shade100,
                    ),
                    title: Text(
                      '${args!.training_date!.day.toString()}.${monthString}',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      '${args!.training_date!.hour.toString()}:${args!.training_date!.minute.toString()} - ${args!.duration.toString()} минут',
                      style: TextStyle(color: Colors.grey, fontSize: 18),
                    ),
                    isThreeLine: true,
                  ),
                  Card(
                    elevation: 12,
                    color: Colors.white, // Изменен цвет фона
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      leading: CircleAvatar(
                        backgroundColor: Colors.blueAccent.shade100,
                        child: Icon(Icons.person_outlined, color: Colors.white),
                      ),
                      title: Text(
                        '${args.participant.first_name} ${args.participant.last_name}',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),


            Padding(
              padding: EdgeInsets.all(5),
              child: ElevatedButton(
                onPressed: patchPersonalTraining,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent.shade100,
                  fixedSize: Size(230, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Тренировка пройдена',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
