import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fitness_app/src/repository/data/admin_data/admin_service.dart';
import 'package:fitness_app/src/repository/data/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  Future<void> putChatRoom(String uuid) async {
    try {
      Response response = await apiService.dio.get(
        'https://fohowomsk.ru/api/update-room/${uuid}/', // PUT SNAPSHOT UUID HERE
      );
      if (response.statusCode == 200) {
        String user = 'admin';
        String firstname_admin = response.data['name'];
        Navigator.of(context).pushNamed('/chat_screen',
            arguments: [uuid, user, firstname_admin]);
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
    final adminService = AdminService(apiService.dio);
    return FutureBuilder(
      future: adminService.getAdmin(query: 'admin'),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Material(
            child: Center(
              child: Text('${snapshot.error}'),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Material(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (snapshot.data != null && snapshot.data!.isNotEmpty) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Панель администратора'),
              centerTitle: true,
              backgroundColor: Colors.blueAccent.shade100,
            ),
            body: Padding(
              padding: EdgeInsets.only(top: 5),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  childAspectRatio: 1,
                ),
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () => putChatRoom(snapshot.data![index].uuid),
                    child: Card(
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              '${snapshot.data![index].client.split(' ')[0]} ${snapshot.data![index].client.split(' ')[1]}',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            SizedBox(height: 8),
                            Text(
                              '${snapshot.data![index].created_at.hour.toString().padLeft(2, '0')}:${snapshot.data![index].created_at.minute.toString().padLeft(2, '0')}',
                              style: TextStyle(
                                fontSize: 16,
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
        } else {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blueAccent.shade100,
              title: Text('Панель администратора'),
              centerTitle: true,
            ),
            body: Center(
              child: Text('Нет сообщений'),
            ),
          );
        }
      },
    );
  }
}
