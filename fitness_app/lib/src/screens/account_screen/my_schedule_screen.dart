import 'package:fitness_app/src/repository/data/services/account_service.dart';
import 'package:flutter/material.dart';

import '../../repository/data/services/api_service.dart';

class MyScheduleScreen extends StatefulWidget {
  const MyScheduleScreen({super.key});

  @override
  State<MyScheduleScreen> createState() => _MyScheduleScreenState();
}

class _MyScheduleScreenState extends State<MyScheduleScreen> {
  @override
  Widget build(BuildContext context) {
    apiService;
    final myEventsService = AccountService(apiService.dio);
    return FutureBuilder(
        future: myEventsService.getMyEvents(query: 'my_events'),
        builder: (context, snapshot) {
          print(snapshot.error);
          if (snapshot.error != null || snapshot.stackTrace != null) {
            return Material(
              child: Center(
                child: Text('${snapshot.error}'),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done ||
              snapshot.data != null) {
            return Scaffold(
              appBar: AppBar(
                iconTheme: IconThemeData(color: Colors.white),
                backgroundColor: Colors.blueAccent.shade100,
                title: Text(
                  'Мое расписание',
                  style: TextStyle(color: Colors.white),
                ),
                centerTitle: true,
              ),
              body: ListView.separated(
                separatorBuilder: (BuildContext context, int index) =>
                    SizedBox(height: 5),
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () => Navigator.of(context).pushNamed(
                        '/event_screen',
                        arguments: snapshot.data![index]),
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        Card(
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
                                  '${snapshot.data![index].start_date!.day.toString().padLeft(2, '0')}.${snapshot.data![index].start_date!.month.toString().padLeft(2, '0')}',
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  '${snapshot.data![index].start_date!.hour.toString().padLeft(2, '0')}:${snapshot.data![index].start_date!.minute.toString().padLeft(2, '0')}',
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  '${snapshot.data![index].duration.toString()} минут',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            title: Text(
                              snapshot.data![index].title.toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              snapshot.data![index].club.toString() +
                                  '\n' +
                                  snapshot.data![index].tags![0].name,
                              style: TextStyle(color: Colors.white),
                            ),
                            tileColor: Colors.blueAccent.shade100,
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                            ),
                            isThreeLine: true,
                          ),
                        ),
                        Positioned(
                          left: 0,
                          top: 0,
                          bottom: 0,
                          child: Container(
                            width: 80,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                // Закругленные углы слева сверху
                                bottomLeft: Radius.circular(
                                    12), // Закругленные углы слева снизу
                              ),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '${snapshot.data![index].start_date!.day.toString().padLeft(2, '0')}.${snapshot.data![index].start_date!.month.toString().padLeft(2, '0')}',
                                    style: TextStyle(
                                        color:
                                        Colors.blueAccent.shade100),
                                  ),
                                  Text(
                                    '${snapshot.data![index].start_date!.hour.toString().padLeft(2, '0')}:${snapshot.data![index].start_date!.minute.toString().padLeft(2, '0')}',
                                    style: TextStyle(
                                        color:
                                        Colors.blueAccent.shade100),
                                  ),
                                  Text(
                                    '${snapshot.data![index].duration.toString()} минут',
                                    style: TextStyle(
                                        color:
                                        Colors.blueAccent.shade100),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
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
