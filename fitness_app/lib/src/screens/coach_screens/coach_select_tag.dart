import 'package:dio/dio.dart';
import 'package:fitness_app/src/repository/data/coach_services/coach_trainings_service.dart';
import 'package:fitness_app/src/repository/data/services/api_service.dart';
import 'package:flutter/material.dart';

class CoachSelectTag extends StatefulWidget {
  const CoachSelectTag({super.key});

  @override
  State<CoachSelectTag> createState() => _CoachSelectTagState();
}

class _CoachSelectTagState extends State<CoachSelectTag> {
  Future<void> postTag(int id, String name) async {
    try {
      apiService;
      Response response = await apiService.dio.post(
        'https://fohowomsk.ru/api/tags/',
        data: {"name": name},
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
    final tagsService = CoachService(apiService.dio);
    return FutureBuilder(
        future: tagsService.getTags(query: 'tags'),
        builder: (context, snapshot) {
          if (snapshot.error != null || snapshot.stackTrace != null) {
            return Material(
              child: Center(
                child: Text('${snapshot.error}'),
              ),
            );
          }
          if (snapshot.hasData ||
              snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                backgroundColor: Colors.blueAccent.shade100,
                title: Text('Выберите тег'),
              ),
              body: Center(
                child: ListView.separated(
                    separatorBuilder: (BuildContext context, int index) =>
                        SizedBox(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () => Navigator.of(context).pop([
                          snapshot.data![index].name
                        ]),
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)
                            ),
                            leading: Icon(
                              Icons.tag,
                              color: Colors.white,
                            ),
                            tileColor: Colors.blueAccent.shade100,
                            title: Text(
                              snapshot.data![index].name,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            );
          }
          return Material(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
