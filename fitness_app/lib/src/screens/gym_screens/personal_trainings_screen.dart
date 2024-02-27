import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../repository/data/services/api_service.dart';



class PersonalTrainingsScreen extends StatefulWidget {
  PersonalTrainingsScreen({super.key});

  bool coachSelected = false;
  bool timeSelected = false;
  bool isSigned = true;
  final List<String> selectedCoach = [];
  final List<DateTime> selectedTime = [];

  @override
  State<PersonalTrainingsScreen> createState() =>
      _PersonalTrainingsScreenState();
}

class _PersonalTrainingsScreenState extends State<PersonalTrainingsScreen> {
  Future<void> getCoachTime(BuildContext context) async {
    try {
      apiService;
      print("1");
      Response response = await apiService.dio.get(
        'https://fohowomsk.ru/api/individual_event_schedules/${widget.selectedCoach[2].toString()}/',
      );
      print("2");
      if (response.statusCode == 200) {
        print("3");
        final List<dynamic> responseData = response.data;
        print("4");
        List<DateTime> coachTimeList = [];
        print("5");
        for (final timeData in responseData) {
          coachTimeList.add(DateTime.parse(timeData["time"]));
        }

        print("6");
        final List<DateTime>? selectedTime = await Navigator.of(context).pushNamed(
          '/personal_training_calendar_screen',
          arguments: coachTimeList,
        ) as List<DateTime>?;
        print("7");

        if (selectedTime != null && selectedTime.isNotEmpty) {
          setState(() {
            widget.selectedTime
              ..clear()
              ..addAll(selectedTime);
            widget.timeSelected = true;
          });
        }
      } else {
        print('Ошибка при получении времени тренера');
      }
    } catch (e) {
      print('Ошибка при получении времени тренера: $e'+ 'индекс' + '${widget.selectedCoach[2]}');
    }
  }

  Future<void> selectingCoach(BuildContext context) async {
    final List<String> coach = await Navigator.of(context)
        .pushNamed('/coaches_list_personal_training_screen') as List<String>;

    setState(() {
      widget.selectedCoach
        ..clear()
        ..addAll(coach);
    });

    if (widget.selectedCoach.isNotEmpty) {
      setState(() {
        widget.coachSelected = true;
      });
    }

    if (!mounted) return;
  }

  Future<void> postTraining() async {
    final formattedDate = widget.selectedTime[0].year.toString() + '-' +
        widget.selectedTime[0].month.toString() + '-' +
        widget.selectedTime[0].day.toString() + ' ' +
        widget.selectedTime[0].hour.toString() + ':' +
        widget.selectedTime[0].minute.toString();
    try {
      apiService;
      Response response = await apiService.dio
          .post('https://fohowomsk.ru/api/create/individual_events/',
          data: {
            'price': args[1],
            'training_date': formattedDate,
            'coach': widget.selectedCoach[2]
          });
      if (response.statusCode == 201) {
        Navigator.of(context).pushNamed('/main');
      } else {
        print('ОШИБКА В ELSE POSTTRAINING');
      }
    } catch (e) {
      print('ОШИБКА В CATCH POSTTRAINING $e');
      print(args[1]);
      print('${formattedDate}');
      print('${widget.selectedCoach[2]}');
    }
  }

  late final args = ModalRoute.of(context)!.settings.arguments as List<String>;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.blueAccent.shade100,
        title: Text(
          'Персональная тренировка',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            GestureDetector(
              onTap: () => selectingCoach(context),
              child: Card(
                elevation: 12,
                color: Colors.blueAccent.shade100,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      color: Colors.blueAccent.shade100,
                    ),
                  ),
                  title: Text(
                    widget.selectedCoach.isEmpty
                        ? 'Выберите тренера'
                        : '${widget.selectedCoach[0] } ${widget.selectedCoach[1]}',
                    style: TextStyle(color: Colors.black),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => getCoachTime(context),
              child: Card(
                elevation: 12,
                color: Colors.blueAccent.shade100,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.access_time_outlined,
                      color: Colors.blueAccent.shade100,
                    ),
                  ),
                  title: Text(
                    widget.selectedTime.isEmpty
                        ? 'Выберите время'
                        : '${widget.selectedTime[0]}',
                    style: TextStyle(color: Colors.black),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 25),
            Text(
              'Если не нашли удобное время...',
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
            Divider(
              color: Colors.blueAccent.shade100,
              thickness: 2,
              endIndent: 20,
              indent: 20,
            ),
            GestureDetector(
              onTap: ()=> launch('tel://88162689968'),
              child: Card(
                elevation: 12,
                color: Colors.blueAccent.shade100,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.call,
                      color: Colors.blueAccent.shade100,
                    ),
                  ),
                  title: Text(
                    'Позвоните в клуб',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.of(context).pushNamed('/chat_screen'),
              child: Card(
                elevation: 12,
                color: Colors.blueAccent.shade100,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.email,
                      color: Colors.blueAccent.shade100,
                    ),
                  ),
                  title: Text(
                    'Напишите нам',
                    style: TextStyle(color: Colors.black),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: ElevatedButton(
                onPressed: () async {
                  if (widget.coachSelected && widget.timeSelected) {
                    postTraining();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Пожалуйста, выберите тренера и время'),
                    ));
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent.shade100,
                  fixedSize: Size(330, 50),
                  side: BorderSide(
                    color: Colors.blueAccent.shade100,
                  ),
                ),
                child: Text(
                  widget.isSigned ? 'Записаться' : 'Отменить запись',
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