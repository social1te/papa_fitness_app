import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:fitness_app/src/repository/data/coach_services/coach_trainings_service.dart';
import 'package:fitness_app/src/repository/data/services/api_service.dart';
import 'package:flutter/material.dart';

class CoachScheduleScreen extends StatefulWidget {
  const CoachScheduleScreen({Key? key});

  @override
  State<CoachScheduleScreen> createState() => _CoachScheduleScreenState();
}

class _CoachScheduleScreenState extends State<CoachScheduleScreen> {
  late DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    apiService;
    final scheduleService = CoachService(apiService.dio);
    return FutureBuilder(
      future: scheduleService.getSchedule(query: 'schedule'),
      builder: (context, snapshot) {
        if (snapshot.error != null || snapshot.stackTrace != null) {
          print(snapshot.error);
          return Material(
            child: Center(
              child: Text(snapshot.error.toString()),
            ),
          );
        }
        if (snapshot.hasData ||
            snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text('Расписание'),
              backgroundColor: Colors.blueAccent.shade100,
              actions: [
                IconButton(
                  onPressed: () => Navigator.of(context)
                      .pushNamed('/coach_create_personal_training'),
                  icon: Icon(Icons.add),
                )
              ],
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Column(
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
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        child: GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 2,
                            mainAxisSpacing: 2,
                            childAspectRatio: 2,
                          ),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            if (snapshot.data![index].time!.year ==
                                _selectedDate.year &&
                                snapshot.data![index].time!.month ==
                                    _selectedDate.month &&
                                snapshot.data![index].time!.day ==
                                    _selectedDate.day) {
                              String hour = snapshot.data![index].time!.hour
                                  .toString()
                                  .padLeft(2, '0');
                              String minute = snapshot.data![index].time!.minute
                                  .toString()
                                  .padLeft(2, '0');
                              return GestureDetector(
                                onTap: () => Navigator.of(context).pushNamed(
                                    '/coach_edit_personal_training',
                                    arguments: snapshot.data![index]),
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
                                    tileColor: Colors.blueAccent.shade100,
                                    title: Text(
                                      '$hour:$minute',
                                      style: TextStyle(color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              // Если время не совпадает с выбранной датой, возвращаем пустой контейнер
                              return Container();
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return Material(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
