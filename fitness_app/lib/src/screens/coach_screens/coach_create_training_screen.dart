import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../repository/data/services/api_service.dart';

class CoachCreateTraining extends StatefulWidget {
  const CoachCreateTraining({Key? key}) : super(key: key);

  @override
  State<CoachCreateTraining> createState() => _CoachCreateTrainingState();
}

class _CoachCreateTrainingState extends State<CoachCreateTraining> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController limitOfParticipantsController =
      TextEditingController();
  final TextEditingController contentController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  bool tagSelected = false;
  final List<String> selectedTag = [];

  Future<void> selectingTag(BuildContext context) async {
    final List<String> tag = await Navigator.of(context)
        .pushNamed('/coach_select_tag') as List<String>;

    setState(() {
      selectedTag
        ..clear()
        ..addAll(tag);
    });

    if (selectedTag.isNotEmpty) {
      setState(() {
        tagSelected = true;
      });
    }

    if (!mounted) return;
  }

  @override
  bool _validateFields() {
    if (titleController.text.isEmpty ||
        contentController.text.isEmpty ||
        timeController.text.isEmpty ||
        durationController.text.isEmpty ||
        priceController.text.isEmpty ||
        limitOfParticipantsController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Пожалуйста, заполните все поля'),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }
    return true;
  }

  Widget build(BuildContext context) {
    Future<void> postTraining() async {
      if (_validateFields()) {
        try {
          Response response = await apiService.dio.post(
            'https://fohowomsk.ru/api/trainer_events/',
            data: {
              'title': titleController.text,
              'content': contentController.text,
              'start_date': selectedDate.year.toString() +
                  '-' +
                  selectedDate.month.toString() +
                  '-' +
                  selectedDate.day.toString() +
                  ' ' +
                  timeController.text,
              'duration': durationController.text,
              'price': priceController.text,
              'limit_of_participants': limitOfParticipantsController.text,
            },
          );
          if (response.statusCode == 201) {
            print('Успешная регистрация');
            Navigator.pop(context);
          } else {
            print('Error in else');
          }
        } catch (e) {
          print('Error in catch: $e');
        }
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.blueAccent.shade100,
        centerTitle: true,
        title: Text(
          'Создание тренировки',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                    'Введите информацию о тренировке',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                _buildInputField(
                  hintText: 'Название',
                  icon: Icons.title,
                  controller: titleController,
                ),
                _buildInputField(
                  hintText: 'Описание',
                  icon: Icons.text_snippet_sharp,
                  controller: contentController,
                ),
                _buildDatePickerField(context),
                _buildTimePickerField(),
                _buildInputField(
                  hintText: 'Продолжительность',
                  icon: Icons.access_time,
                  controller: durationController,
                  keyboardType: TextInputType.number,
                ),
                _buildInputField(
                  hintText: 'Цена',
                  icon: Icons.attach_money,
                  controller: priceController,
                  keyboardType: TextInputType.number,
                ),
                _buildInputField(
                  hintText: 'Кол-во участников',
                  icon: Icons.people,
                  controller: limitOfParticipantsController,
                  keyboardType: TextInputType.number,
                ),
                _buildTagCard(
                  hintText: selectedTag.isEmpty
                      ? 'Выберите тег'
                      : '${selectedTag[0]}',
                  icon: Icons.edit,
                  keyboardType: TextInputType.number,
                ),
                ElevatedButton(
                  onPressed: postTraining,
                  child: Text('Создать'),
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(230, 50),
                    backgroundColor: Colors.blueAccent.shade100,
                    padding: EdgeInsets.all(15),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
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

  Widget _buildDatePickerField(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: () {
          _selectDate(context);
        },
        child: InputDecorator(
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.calendar_today,
              color: Colors.blueAccent.shade100,
            ),
            hintText: 'Выберите день',
            hintStyle: TextStyle(color: Colors.blueAccent.shade100),
            filled: true,
            fillColor: Colors.blue.withOpacity(0.1),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
          child: Text(
            "${selectedDate.toLocal()}".split(' ')[0],
            style: TextStyle(color: Colors.blueAccent.shade100),
          ),
        ),
      ),
    );
  }

  Widget _buildTagCard({
    required String hintText,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return GestureDetector(
      onTap: () => selectingTag(context),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: (BorderRadius.circular(10)),
            color: Colors.blue.withOpacity(0.1)),
        margin: EdgeInsets.only(bottom: 10),
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Row(
            children: [
              Icon(
                icon,
                color: Colors.blueAccent.shade100,
              ),
              SizedBox(width: 10),
              Text(
                hintText,
                style: TextStyle(color: Colors.blueAccent.shade100),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimePickerField() {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: DropdownButtonFormField<String>(
        value: timeController.text.isNotEmpty ? timeController.text : null,
        items: <String>[
          '07:00',
          '07:30',
          '08:00',
          '08:30',
          '09:00',
          '09:30',
          '10:00',
          '10:30',
          '11:00',
          '11:30',
          '12:00',
          '12:30',
          '13:00',
          '13:30',
          '14:00',
          '14:30',
          '15:00',
          '15:30',
          '16:00',
          '16:30',
          '17:00',
          '17:30',
          '18:00',
          '18:30',
          '19:00',
          '19:30',
          '20:00',
          '20:30',
          '21:00',
          '21:30',
          '22:00',
          '22:30',
          '23:00'
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (newValue) {
          setState(() {
            timeController.text = newValue!;
          });
        },
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.calendar_today,
            color: Colors.blueAccent.shade100,
          ),
          hintText: 'Выберите время',
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }
}
