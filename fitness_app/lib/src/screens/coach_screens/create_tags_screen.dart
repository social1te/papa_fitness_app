import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../repository/data/services/api_service.dart';

class CreateTagsScreen extends StatefulWidget {
  const CreateTagsScreen({super.key});

  @override
  State<CreateTagsScreen> createState() => _CreateTagsScreenState();
}

class _CreateTagsScreenState extends State<CreateTagsScreen> {
  final TextEditingController tagController = TextEditingController();

  Future<void> postTag() async {
    try {
      Response response = await apiService.dio.post(
        'https://fohowomsk.ru/api/tags/',
        data: {
          'name': tagController.text,
        },
      );
      if (response.statusCode == 201) {
        Navigator.pop(context);
      } else {
        print('Error in else');
      }
    } catch (e) {
      print('Error in catch: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent.shade100,
        centerTitle: true,
        title: Text('Создать тег'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: _buildInputField(
                  hintText: 'Название тега',
                  icon: Icons.tag,
                  controller: tagController),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  fixedSize: Size(230, 50),
                  backgroundColor: Colors.blueAccent.shade100),
              onPressed: postTag,
              child: Text('Создать'),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildInputField({
  required String hintText,
  required IconData icon,
  required TextEditingController controller,
  TextInputType keyboardType = TextInputType.text,
}) {
  return Container(
    margin: EdgeInsets.only(bottom: 10),
    child: TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: Colors.blueAccent.shade100,
        ),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.blueAccent.shade100),
        filled: true,
        fillColor: Colors.blue.withOpacity(0.1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    ),
  );
}
