import 'package:dio/dio.dart';
import 'package:fitness_app/src/repository/data/services/api_service.dart';
import 'package:fitness_app/src/repository/data/services/gym_service.dart';
import 'package:flutter/material.dart';

import '../../repository/data/services/account_service.dart';

final accountService = AccountService(apiService.dio);

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> postChatRoom() async {
    try {
      Response response = await apiService.dio.post(
        'https://fohowomsk.ru/api/create-room/',
      );
      if (response.statusCode == 201) {
        Map<String, dynamic> responseData = response.data;
        String id = responseData['uuid'];
        String user = 'user';
        String firstname_user = responseData['name'];
        Navigator.of(context)
            .pushNamed('/chat_screen', arguments: [id, user, firstname_user]);
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
    final dio = Dio();
    final eventService = GymService(dio);
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
        if (snapshot.data != null ||
            snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            backgroundColor: Colors.grey.shade200,
            body: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  pinned: true,
                  shadowColor: Colors.blueAccent.shade100,
                  automaticallyImplyLeading: false,
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  elevation: 12,
                  backgroundColor: Colors.blueAccent.shade100,
                  expandedHeight: 100,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(
                      'П А П А Ф И Т Н Е С',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    centerTitle: true,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Card(
                    elevation: 10,
                    shadowColor: Colors.blueAccent.shade100,
                    color: Colors.grey.shade100,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Container(
                        child: Column(
                          children: [
                            SizedBox(height: 20),
                            Row(
                              children: [
                                SizedBox(width: 25),
                                Text(
                                  '777',
                                  style: TextStyle(
                                      fontSize: 48,
                                      color:
                                      Colors.black), // Обновлен цвет текста
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(width: 25),
                                Text(
                                  'Текущая загруженность',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color:
                                      Colors.black), // Обновлен цвет текста
                                ),
                              ],
                            ),
                          ],
                        ),
                        height: 130,
                        width: 480,
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 20,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Text(
                          'Ближайшие тренировки',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: ()=> Navigator.of(context).pushNamed('/group_trainings_screen'),
                        child: Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Text(
                            'Все',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: Divider(
                    thickness: 2,
                    color: Colors.blueAccent.shade100,
                    indent: 20,
                    endIndent: 20,
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 10,
                  ),
                ),
                SliverToBoxAdapter(
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: ListView.separated(
                      primary: false,
                      shrinkWrap: true,
                      separatorBuilder: (BuildContext context, int index) =>
                          SizedBox(height: 5,),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () => Navigator.of(context).pushNamed(
                            '/event_screen',
                            arguments: snapshot.data![index],
                          ),
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
                  ),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.blueAccent.shade100,
              onPressed: postChatRoom,
              child: Icon(Icons.message),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
            ),
          );
        }
        return Material(
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
