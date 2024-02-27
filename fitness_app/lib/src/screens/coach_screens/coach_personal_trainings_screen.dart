import 'package:dio/dio.dart';
import 'package:fitness_app/src/repository/data/services/api_service.dart';
import 'package:flutter/material.dart';

import '../../repository/data/coach_services/coach_trainings_service.dart';

class CoachPersonalTrainings extends StatelessWidget {
  const CoachPersonalTrainings({super.key});

  Future<void> postTraining() async {
    try {
      apiService;
      Response response = await apiService.dio.post(
        'https://fohowomsk.ru/api/trainer_events/',
        data: {},
      );
      if (response.statusCode == 200) {
        print('Успешная регистрация');
      } else {
        print('Error in else');
      }
    } catch (e) {
      print('Error in catch: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    apiService;
    final coachService = CoachService(apiService.dio);
    return FutureBuilder(
        future: coachService.getPersonalEvents(query: 'events'),
        builder: (context, snapshot) {
          if (snapshot.error != null || snapshot.stackTrace != null) {
            return Material(
              child: Center(
                child: Text(snapshot.error.toString()),
              ),
            );
          }
          if (snapshot.data != null ||
              snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.blueAccent.shade100,
                title: Icon(Icons.person, color: Colors.white),
                centerTitle: true,
              ),
              body: Center(
                child: ListView.separated(
                    separatorBuilder: (BuildContext context, int index) =>
                        SizedBox(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: ()=> Navigator.of(context).pushNamed('/coach_personal_training', arguments: snapshot.data![index]),
                        child: Card(
                          elevation: 4,
                          shadowColor: Colors.blueAccent.shade100,
                          color: Colors.blueAccent.shade100,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            leading: Column(
                              children: [
                                Text(
                                  snapshot.data![index].training_date!.hour
                                      .toString() +
                                      ':' +
                                      snapshot.data![index].training_date!.minute
                                          .toString(),
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  snapshot.data![index].duration.toString() +
                                      ' минут',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            title: Text(
                              'Персональная тренировка',
                              style: TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                                snapshot.data![index].participant.first_name +
                                    ' ' + snapshot.data![index].participant
                                    .last_name,
                                style: TextStyle(color: Colors.white),
                          ),
                          tileColor: Colors.blueAccent.shade100,
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                          ),
                          isThreeLine: true,
                        ),),
                      );
                    }
                ),
              ),
            );
          }
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blueAccent.shade100,
              title: Icon(Icons.person, color: Colors.white),
              centerTitle: true,
            ),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
