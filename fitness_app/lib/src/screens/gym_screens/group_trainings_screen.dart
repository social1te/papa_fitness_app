import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';

import '../../repository/data/services/api_service.dart';
import '../../repository/data/services/gym_service.dart';

class GroupTrainingsScreen extends StatefulWidget {
  const GroupTrainingsScreen({Key? key});

  @override
  State<GroupTrainingsScreen> createState() => _GroupTrainingsScreenState();
}

class _GroupTrainingsScreenState extends State<GroupTrainingsScreen> {
  late DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final eventService = GymService(apiService.dio);
    return FutureBuilder(
      future: eventService.getEvent(query: 'event'),
      builder: (context, snapshot) {
        if (snapshot.error != null || snapshot.stackTrace != null) {
          return Material(
            child: Center(
              child: Text('${snapshot.error}'),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            backgroundColor: Colors.grey.shade200,
            appBar: AppBar(
              title: Text(
                'Групповые тренировки',
                style: TextStyle(color: Colors.white),
              ),
              centerTitle: true,
              backgroundColor: Colors.blueAccent.shade100,
              iconTheme: IconThemeData(color: Colors.white),
            ),
            body: Column(
              children: [
                CalendarTimeline(
                  leftMargin: 8,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(Duration(days: 14)),
                  initialDate: _selectedDate,
                  onDateSelected: (date) {
                    setState(() {
                      _selectedDate = date;
                    });
                  },
                  dayColor: Colors.blueAccent.shade100,
                  activeBackgroundDayColor: Colors.blueAccent.shade100,
                ),
                Divider(
                  indent: 20,
                  endIndent: 20,
                  color: Colors.blueAccent.shade100,
                  thickness: 2,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      final event = snapshot.data![index];
                      if (event.start_date!.year == _selectedDate.year &&
                          event.start_date!.month == _selectedDate.month &&
                          event.start_date!.day == _selectedDate.day) {
                        return GestureDetector(
                          onTap: () => Navigator.of(context).pushNamed(
                            '/event_screen',
                            arguments: event,
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(top: 5),
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
                          ),
                          // child: Card(
                          //   elevation: 4,
                          //   shadowColor: Colors.blueAccent.shade100,
                          //   color: Colors.blueAccent.shade100,
                          //   shape: RoundedRectangleBorder(
                          //     borderRadius: BorderRadius.circular(12),
                          //   ),
                          //   child: ListTile(
                          //     shape: RoundedRectangleBorder(
                          //       borderRadius: BorderRadius.circular(12),
                          //     ),
                          //     leading: Column(
                          //       mainAxisAlignment: MainAxisAlignment.center,
                          //       children: [
                          //         Text(
                          //           '${event.start_date!.hour.toString().padLeft(2, '0')}:${event.start_date!.minute.toString().padLeft(2, '0')}',
                          //           style: TextStyle(color: Colors.white),
                          //         ),
                          //         Text(
                          //           '${event.duration.toString()} минут',
                          //           style: TextStyle(color: Colors.white),
                          //         ),
                          //       ],
                          //     ),
                          //     title: Text(
                          //       event.title.toString(),
                          //       style: TextStyle(color: Colors.white),
                          //     ),
                          //     subtitle: Text(
                          //       '${event.club.toString()}\n${snapshot.data![index].tags![0].name}',
                          //       style: TextStyle(color: Colors.white),
                          //     ),
                          //     tileColor: Colors.blueAccent.shade100,
                          //     trailing: Icon(
                          //       Icons.arrow_forward_ios,
                          //       color: Colors.white,
                          //     ),
                          //     isThreeLine: true,
                          //   ),
                          // ),
                        );
                      } else {
                        return SizedBox.shrink();
                      }
                    },
                  ),
                ),
              ],
            ),
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: Text('Групповые тренировки'),
            centerTitle: true,
            backgroundColor: Colors.blueAccent.shade100,
          ),
          backgroundColor: Colors.grey.shade200,
          body: Center(
            child: Column(
              children: [
                CalendarTimeline(
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(Duration(days: 14)),
                  initialDate: _selectedDate,
                  onDateSelected: (date) {
                    setState(() {
                      _selectedDate = date;
                    });
                  },
                  dayColor: Colors.blueAccent.shade100,
                  activeBackgroundDayColor: Colors.blueAccent.shade100,
                ),
                CircularProgressIndicator(
                  color: Colors.blueAccent.shade100,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
