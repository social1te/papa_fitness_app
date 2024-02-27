import 'package:dio/dio.dart';
import 'package:fitness_app/src/repository/data/services/gym_service.dart';
import 'package:flutter/material.dart';

class CoachesListPersonalTrainingScreen extends StatelessWidget {
  const CoachesListPersonalTrainingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dio = Dio();
    final coachService = GymService(dio);
    return FutureBuilder(
      future: coachService.getCoach(query: 'coach'),
      builder: (context, snapshot) {
        if (snapshot.error != null || snapshot.stackTrace != null) {
          return Material(
            child: Center(
              child: Text('${snapshot.error}'),
            ),
          );
        }
        if (snapshot.data != null ||
            snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              iconTheme: IconThemeData(color: Colors.white),
              backgroundColor: Colors.blueAccent.shade100,
              title: Text(
                'Тренеры',
                style: TextStyle(color: Colors.white),
              ),
              centerTitle: true,
            ),
            body: Container(
              height: 800,
              child: ListView.separated(
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.all(2),
                separatorBuilder: (BuildContext context, int index) => SizedBox(),
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () => Navigator.of(context).pop(
                      [
                        snapshot.data![index].first_name,
                        snapshot.data![index].last_name,
                        snapshot.data![index].id.toString()
                      ],
                    ),
                    child: Card(
                      elevation: 12,
                      color: Colors.blueAccent.shade100,
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        leading: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: snapshot.data![index].photo != null
                              ? Image.network(snapshot.data![index].photo.toString())
                              : Icon(Icons.person, color: Colors.blueAccent.shade100,),
                          // child: Icon(
                          //   Icons.person,
                          //   color: Colors.blueAccent.shade100,
                          // ),
                        ),
                        title: Text(
                          snapshot.data![index].first_name +
                              ' ' +
                              snapshot.data![index].last_name,
                          style: TextStyle(color: Colors.black),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        }
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blueAccent.shade100,
            centerTitle: true,
            title: Text(
              'Тренеры',
              style: TextStyle(color: Colors.white),
            ),
          ),
          backgroundColor: Colors.white,
          body: Center(
            child: CircularProgressIndicator(
              color: Colors.blueAccent.shade100,
            ),
          ),
        );
      },
    );
  }
}
