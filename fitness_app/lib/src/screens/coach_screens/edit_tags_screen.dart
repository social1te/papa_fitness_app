import 'package:dio/dio.dart';
import 'package:fitness_app/src/repository/data/coach_models/coach_trainings_model.dart';
import 'package:flutter/material.dart';

import '../../repository/data/services/api_service.dart';

class EditTagsScreen extends StatefulWidget {
  const EditTagsScreen({super.key});

  @override
  State<EditTagsScreen> createState() => _EditTagsScreenState();
}

class _EditTagsScreenState extends State<EditTagsScreen> {
  final TextEditingController tagController = TextEditingController();

  Future<void> patchTag() async {
    try {
      apiService;
      Response response = await apiService.dio.patch(
        'https://fohowomsk.ru/api/tags/${args.id}/',
        data: {
          'name': tagController.text
        },
      );
      if (response.statusCode == 200) {
        print('Успешная регистрация');
        Navigator.pop(context);
      } else {
        print('Error in else');
      }
    } catch (e) {
      print('Error in catch: $e');
    }
  }

  Future<void> deleteTag() async {
    try {
      apiService;
      Response response = await apiService.dio.delete(
        'https://fohowomsk.ru/api/tags/${args.id}/',
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

  late final args = ModalRoute.of(context)!.settings.arguments as Tag;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blueAccent.shade100,
        title: Text('Изменение тега'),
        actions: [
          IconButton(
              onPressed: () {
                deleteTag();
                Navigator.pop(context);
              },
              icon: Icon(Icons.delete))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(5),
              child: Form(
                child: TextFormField(
                  controller: tagController,
                  style: TextStyle(color: Colors.blueAccent.shade100),
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.tag,
                      color: Colors.blueAccent.shade100,
                    ),
                    hintText: args.name,
                    hintStyle: TextStyle(color: Colors.blueAccent.shade100),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent.shade100),
                    ),
                  ),
                ),
              ),
            ),
            ElevatedButton(
                onPressed: patchTag,
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(230, 55),
                    backgroundColor: Colors.blueAccent.shade100),
                child: Text('Сохранить'))
          ],
        ),
      ),
    );
  }
}
