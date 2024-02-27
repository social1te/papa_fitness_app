import 'package:dio/dio.dart';
import 'package:fitness_app/src/repository/data/models/gym_model.dart';
import 'package:fitness_app/src/repository/data/services/gym_service.dart';
import 'package:flutter/material.dart';

import '../../repository/data/services/api_service.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({Key? key}) : super(key: key);

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  late bool isJoined = false;
  @override
  Widget build(BuildContext context) {
    apiService;
    final coachService = GymService(apiService.dio);
    final args = ModalRoute.of(context)!.settings.arguments as EventModel;

    Future<void> joinEvent() async {
      try {
        Response response = await apiService.dio.put(
            'https://fohowomsk.ru/api/join_event/',
            data: {'pk': args!.id});

        if (response.statusCode == 200) {
          setState(() {
            isJoined = !isJoined;
          });
          print('Пользователь записан');
        } else {
          print('nea))');
        }
      } catch (e) {
        print('Error in catch: $e');
      }
    }

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
          String minute = args.start_date!.minute.toString().padLeft(2, '0');
          String day = args.start_date!.day.toString().padLeft(2, '0');
          String month = args.start_date!.month.toString().padLeft(2, '0');
          return Scaffold(
            backgroundColor: Colors.grey.shade100,
            appBar: AppBar(
              iconTheme: IconThemeData(color: Colors.white),
              backgroundColor: Colors.blueAccent.shade100,
              title: Text(
                args!.title.toString(),
                style: TextStyle(color: Colors.white),
              ),
              centerTitle: true,
            ),
            body: Center(
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Card(
                      elevation: 0,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            leading: args!.status == 'edit'
                                ? Icon(
                                    Icons.error,
                                    color: Colors.blueAccent.shade100,
                                    size: 30,
                                  )
                                : Icon(Icons.fitness_center,
                                    color: Colors.blueAccent.shade100),
                            title: Text(
                              args!.title.toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              args!.club.toString(),
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 18),
                            ),
                            isThreeLine: true,
                          ),
                          Divider(
                            endIndent: 20,
                            indent: 20,
                            thickness: 2,
                            color: Colors.blueAccent.shade100,
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.access_time,
                              color: Colors.blueAccent.shade100,
                            ),
                            title: Text(
                              '$day.$month',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              '${args.start_date!.hour.toString()}:$minute - ${args!.duration.toString()} минут',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 18),
                            ),
                            isThreeLine: true,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: GestureDetector(
                      onTap: ()=> Navigator.of(context).pushNamed('/coach_screen', arguments: snapshot.data![0]),
                      child: Card(
                        elevation: 4,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          leading: snapshot.data![0].photo != null
                              ? CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      snapshot.data![0].photo.toString()),
                                )
                              : CircleAvatar(
                                  backgroundColor: Colors.blueAccent.shade100,
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.white,
                                  ),
                                ),
                          title: Text(
                            args.created_by.first_name +
                                ' ' +
                                args.created_by.last_name.toString(),
                            style: TextStyle(color: Colors.black),
                          ),
                          subtitle:
                              Text(snapshot.data![0].trainer_type.toString()),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.blueAccent.shade100,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: ElevatedButton(
                      onPressed: joinEvent,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent.shade100,
                        fixedSize: Size(230, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        isJoined ? 'Отменить запись' : 'Записаться', // Изменяем текст кнопки в зависимости от состояния
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Card(
                      elevation: 0,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: SizedBox(
                        width: 300,
                        child: ListTile(
                          leading: Icon(
                            Icons.info,
                            color: Colors.blueAccent.shade100,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          title: Text(
                            'О тренировке:',
                            style: TextStyle(
                                fontSize: 26, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            args!.content.toString(),
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                          isThreeLine: true,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 60,
                    child: ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          width: 200,
                          decoration: BoxDecoration(
                            color: Colors.blueAccent.shade100,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              args.tags![index].name.toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          SizedBox(width: 10),
                      itemCount: args.tags!.length,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return Material(
          color: Colors.black,
          child: Center(
            child: CircularProgressIndicator(
              color: Colors.blueAccent.shade100,
            ),
          ),
        );
      },
    );
  }
}
