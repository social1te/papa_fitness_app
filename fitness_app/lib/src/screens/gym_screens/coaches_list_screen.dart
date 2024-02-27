import 'package:dio/dio.dart';
import 'package:fitness_app/src/repository/data/services/gym_service.dart';
import 'package:flutter/material.dart';

class CoachesListScreen extends StatelessWidget {
  const CoachesListScreen({super.key});

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
                separatorBuilder: (BuildContext context, int index) =>
                    SizedBox(height: 5),
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () => Navigator.of(context).pushNamed(
                        '/coach_screen',
                        arguments: snapshot.data![index]),
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.blueAccent.shade100,
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 40,
                                child: ClipOval(
                                  child: SizedBox(
                                    width: 80,
                                    height: 80,
                                    child: snapshot.data![index].photo != null
                                        ? Image.network(
                                      snapshot.data![index].photo.toString(),
                                      fit: BoxFit.cover,
                                    )
                                        : Icon(
                                      Icons.person,
                                      color: Colors.blueAccent.shade100,
                                      size: 40,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(
                                      snapshot.data![index].first_name +
                                          ' ' +
                                          snapshot.data![index].last_name,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    snapshot.data![index].trainer_type,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      ...List.generate(
                                        snapshot.data![index].rating.clamp(0, 5),
                                            (index) => Icon(
                                          Icons.star,
                                          size: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                      ...List.generate(
                                        (5 - snapshot.data![index].rating).clamp(0, 5),
                                            (index) => Icon(
                                          Icons.star_border,
                                          size: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                              ),
                            ),
                          ],
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
            iconTheme: IconThemeData(color: Colors.black),
            backgroundColor: Colors.blueAccent.shade100,
            centerTitle: true,
            title: Text(
              'Т Р Е Н Е Р Ы',
              style: TextStyle(color: Colors.black),
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
