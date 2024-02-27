import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../repository/data/services/api_service.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final TextEditingController typeController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  File? attachedFile;
  bool isRulesChecked = false;

  Future<void> postFeedback() async {
    try {
      if (isRulesChecked) {
        FormData formData = FormData.fromMap({
          'subject': typeController.text,
          'message': messageController.text,
          'phone_number': phoneController.text,
          'email': emailController.text,
          if (attachedFile != null)
            'file': await MultipartFile.fromFile(attachedFile!.path),
        });

        Response response = await apiService.dio.post(
          'https://fohowomsk.ru/api/contact/',
          data: formData,
        );

        if (response.statusCode == 200) {
          print('Отправлено');
        } else {
          print('Ошибка');
        }
      } else {
        print('Подтвердите ознакомление с правилами');
      }
    } catch (e) {
      print('Ошибка: $e');
    }
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        attachedFile = File(result.files.single.path!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.blueAccent.shade100,
        centerTitle: true,
        title: Text(
          'Обратная связь',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Есть вопросы или пожелания? Мы всегда на связи!',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: TextFormField(
                  minLines: 1,
                  maxLines: 5,
                  style: TextStyle(color: Colors.blueAccent.shade100),
                  controller: typeController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.message,
                      color: Colors.blueAccent.shade100,
                    ),
                    hintText: 'Тип обращения',
                    hintStyle: TextStyle(color: Colors.blueAccent.shade100),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent.shade100),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    // Changed to white color
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent.shade100),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: Stack(
                  children: [
                    TextFormField(
                      minLines: 1,
                      maxLines: 5,
                      style: TextStyle(color: Colors.blueAccent.shade100),
                      controller: messageController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.message,
                          color: Colors.blueAccent.shade100,
                        ),
                        hintText: 'Введите свое обращение здесь',
                        hintStyle: TextStyle(color: Colors.blueAccent.shade100),
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blueAccent.shade100),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blueAccent.shade100),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      bottom: 0,
                      child: ElevatedButton(
                        onPressed: _pickFile,
                        child: Icon(Icons.attach_file),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blueAccent.shade100,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(0),
                              bottomLeft: Radius.circular(0),
                              topRight: Radius.circular(4),
                              bottomRight: Radius.circular(4),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: TextFormField(
                  minLines: 1,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.blueAccent.shade100),
                  controller: phoneController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.phone,
                      color: Colors.blueAccent.shade100,
                    ),
                    hintText: 'Ваш номер телефона',
                    hintStyle: TextStyle(color: Colors.blueAccent.shade100),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent.shade100),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    // Changed to white color
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent.shade100),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: TextFormField(
                  minLines: 1,
                  style: TextStyle(color: Colors.blueAccent.shade100),
                  controller: emailController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.blueAccent.shade100,
                    ),
                    hintText: 'Ваша почта',
                    hintStyle: TextStyle(color: Colors.blueAccent.shade100),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent.shade100),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    // Changed to white color
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent.shade100),
                    ),
                  ),
                ),
              ),
              attachedFile != null
                  ? ListTile(
                      title: Text(attachedFile!.path.split('/').last),
                      trailing: IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            attachedFile = null;
                          });
                        },
                      ),
                    )
                  : Container(),
              Padding(
                padding: EdgeInsets.all(5),
                child: Row(
                  children: [
                    Checkbox(
                      value: isRulesChecked,
                      onChanged: (value) {
                        setState(() {
                          isRulesChecked = value ?? false; // Обновляем состояние чекбокса
                        });
                      },
                    ),
                    GestureDetector(
                      onTap: ()=> Navigator.of(context).pushNamed('/user_agreement_screen'),
                      child: Text(
                        'Ознакомлен с правилами, согласен на'+ '\n'+ 'обработку персональных данных',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blueAccent,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: postFeedback,
                child: Text('Отправить'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent.shade100,
                  fixedSize: Size(230, 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
