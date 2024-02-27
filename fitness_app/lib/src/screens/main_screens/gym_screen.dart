import 'package:flutter/material.dart';

class GymScreen extends StatelessWidget {
  const GymScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Клуб',
          style: TextStyle(color: Colors.white), // Белый цвет текста
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent.shade100,
      ),
      backgroundColor: Colors.grey.shade100, // Более светлый фон
      body: Center(
        child: ListView(
          children: [
            buildCard(
              context,
              'Информация о клубе',
              Icons.info,
              '/club_screen',
            ),
            buildCard(
              context,
              'Тренеры',
              Icons.person,
              '/coaches_list_screen',
            ),
            buildCard(
              context,
              'Групповые тренировки',
              Icons.group,
              '/group_trainings_screen',
            ),
            buildCard(
              context,
              'Абонементы и персональные тренировки',
              Icons.spa,
              '/subscriptions_list_screen',
            ),
            buildCard(
              context,
              'Обратная связь',
              Icons.feedback,
              '/feedback_screen',
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCard(BuildContext context, String title, IconData icon, String route) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(route),
      child: Card(
        elevation: 12, // Эффект левитации
        color: Colors.white, // Цвет фона карточки
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          leading: CircleAvatar(
            backgroundColor: Colors.blueAccent.shade100,
            child: Icon(
              icon,
              color: Colors.white, // Белый цвет иконки
            ),
          ),
          title: Text(
            title,
            style: TextStyle(
              color: Colors.black, // Черный цвет текста
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: Colors.blueAccent.shade100,
          ),
        ),
      ),
    );
  }
}
