import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:fitness_app/src/repository/data/services/api_service.dart';
import 'package:fitness_app/src/repository/data/services/gym_service.dart';
import 'package:flutter/material.dart';

class PersonalTrainingsCalendarScreen extends StatefulWidget {
  const PersonalTrainingsCalendarScreen({Key? key}) : super(key: key);

  @override
  State<PersonalTrainingsCalendarScreen> createState() =>
      _PersonalTrainingsCalendarScreenState();
}

late DateTime _selectedDate = DateTime.now();

class _PersonalTrainingsCalendarScreenState
    extends State<PersonalTrainingsCalendarScreen> {
  @override
  Widget build(BuildContext context) {
    apiService;
    final timeService = GymService(apiService.dio);
    return FutureBuilder(
        future: timeService.getTime(query: 'time'),
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
                centerTitle: true,
                iconTheme: IconThemeData(color: Colors.white),
                title: Text(
                  'Выбор времени тренировки',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              body: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CalendarTimeline(
                        leftMargin: 8,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(Duration(days: 30)),
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
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 2,
                              mainAxisSpacing: 2,
                              childAspectRatio: 2,
                            ),
                            itemCount: snapshot.data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              String hour = snapshot.data![index].time.hour
                                  .toString()
                                  .padLeft(2, '0');
                              String minute = snapshot.data![index].time.minute
                                  .toString()
                                  .padLeft(2, '0');
                              final event = snapshot.data![index];
                              if (event.time.year == _selectedDate.year &&
                                  event.time.month == _selectedDate.month &&
                                  event.time.day == _selectedDate.day){
                                return GestureDetector(
                                  onTap: () => Navigator.of(context)
                                      .pop([snapshot.data![index].time]),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: ListTile(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(12)),
                                      tileColor: Colors.blueAccent.shade100,
                                      title: Text(
                                        hour + ':' + minute,
                                        style: TextStyle(color: Colors.white),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                );
                              };
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
        });
  }
}
