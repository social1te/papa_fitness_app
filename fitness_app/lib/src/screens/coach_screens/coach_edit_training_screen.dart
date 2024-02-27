import 'package:dio/dio.dart';
import 'package:fitness_app/src/repository/data/coach_models/coach_trainings_model.dart';
import 'package:fitness_app/src/repository/data/services/api_service.dart';
import 'package:flutter/material.dart';

class CoachEditTraining extends StatefulWidget {
  const CoachEditTraining({super.key});

  @override
  State<CoachEditTraining> createState() => _CoachEditTrainingState();
}

final TextEditingController titleController = TextEditingController();
final TextEditingController timeController = TextEditingController();
final TextEditingController durationController = TextEditingController();
final TextEditingController priceController = TextEditingController();
final TextEditingController limitOfParticipantsController =
    TextEditingController();
final TextEditingController contentController = TextEditingController();
DateTime selectedDate = DateTime.now();

class _CoachEditTrainingState extends State<CoachEditTraining> {
  Future<void> patchTraining() async {
    try {
      String startDateValue = selectedDate.year.toString() +
          '-' +
          selectedDate.month.toString().padLeft(2, '0') +
          '-' +
          selectedDate.day.toString().padLeft(2, '0') +
          ' ' +
          timeController.text;

      if (args.start_date != null && timeController.text.isEmpty) {
        startDateValue = args.start_date!.toString();
      }

      Response response = await apiService.dio.patch(
        'https://fohowomsk.ru/api/trainer_events/${args.id}/',
        data: {
          'title': titleController.text.isNotEmpty
              ? titleController.text
              : args.title,
          'content': contentController.text.isNotEmpty
              ? contentController.text
              : args.content,
          'start_date': startDateValue,
          'duration': durationController.text.isNotEmpty
              ? durationController.text
              : args.duration.toString(),
          'price': priceController.text.isNotEmpty
              ? priceController.text
              : args.price.toString(),
          'limit_of_participants': limitOfParticipantsController.text.isNotEmpty
              ? limitOfParticipantsController.text
              : args.limit_of_participants.toString(),
        },
      );
      print(selectedDate.year.toString() +
          '-' +
          selectedDate.month.toString() +
          '-' +
          selectedDate!.day.toString() +
          ' ' +
          timeController.text);
      if (response.statusCode == 200) {
        print('Успешная регистрация');
        Navigator.pop(context);
      } else {
        print('Error in else');
      }
    } catch (e) {
      print(selectedDate.year.toString() +
          '-' +
          selectedDate.month.toString() +
          '-' +
          selectedDate!.day.toString() +
          ' ' +
          timeController.text);
      print('Error in catch: $e');
    }
  }

  Future<void> deleteTraining() async {
    try {
      Response response = await apiService.dio
          .delete('https://fohowomsk.ru/api/trainer_events/${args.id}/');
      if (response.statusCode == 204) {
        print('Успешно удалено');
        Navigator.pop(context);
      } else {
        print('Error in else');
      }
    } catch (e) {
      print('Error in catch: $e');
    }
  }

  late final args =
      ModalRoute.of(context)!.settings.arguments as CoachTrainingsModel;

  void _showDeleteConfirmationBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Вы уверены, что хотите удалить тренировку?',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(230, 55),
                    backgroundColor: Colors.blueAccent.shade100),
                onPressed: () {
                  deleteTraining();
                  Navigator.of(context).pop();
                },
                child: Text('Удалить'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(230, 55),
                    backgroundColor: Colors.blueAccent.shade100),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Отмена'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Изменение тренировки'),
        backgroundColor: Colors.blueAccent.shade100,
        actions: [
          IconButton(
              onPressed: () {
                _showDeleteConfirmationBottomSheet(context);
              },
              icon: Icon(
                Icons.delete,
                color: Colors.white,
              ))
        ],
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              _buildInputField(
                  hintText: args.title.toString(),
                  icon: Icons.title,
                  controller: titleController
              ),
              _buildInputField(
                  hintText: args.content.toString(),
                  icon: Icons.copy,
                  controller: contentController
              ),
              _buildInputField(
                  hintText: args.duration.toString(),
                  icon: Icons.access_time,
                  controller: durationController
              ),
              _buildInputField(
                  hintText: args.price.toString(),
                  icon: Icons.money_outlined,
                  controller: priceController
              ),
              _buildDatePickerField(context),
              _buildTimePickerField(),
              _buildInputField(
                  hintText: args.limit_of_participants.toString(),
                  icon: Icons.group_outlined,
                  controller: limitOfParticipantsController
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent.shade100,
                    fixedSize: Size(230, 50),
                    padding: EdgeInsets.all(15),
                  ),
                  onPressed: patchTraining,
                  child: Text('Сохранить'),
              )
            ],
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
