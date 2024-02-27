import 'package:fitness_app/src/repository/data/models/gym_model.dart';
import 'package:flutter/material.dart';

class CoachScreen extends StatelessWidget {
  const CoachScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as CoachModel;
    print(args!.photo.toString());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent.shade100,
        title: Text(
          'Тренер',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            ClipOval(
              child: SizedBox(
                width: 176,
                height: 176,
                child: args.photo != null
                    ? Image.network(
                        args.photo.toString(),
                        fit: BoxFit.cover,
                      )
                    : CircleAvatar(
                        radius: 44,
                        backgroundColor: Colors.blueAccent.shade100,
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                          size:
                              88, // Устанавливаем размер иконки, чтобы она была по центру
                        ),
                      ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              '${args.first_name} ${args.last_name}',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Text(
              args.trainer_type,
              style: TextStyle(fontSize: 18, color: Colors.blueAccent.shade100),
            ),
            SizedBox(height: 10),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...List.generate(
                    args.rating.clamp(0, 5),
                    (index) => Icon(
                      Icons.star,
                      size: 24,
                      color: Colors.black,
                    ),
                  ),
                  ...List.generate(
                    (5 - args.rating).clamp(0, 5),
                    (index) => Icon(
                      Icons.star_border,
                      size: 24,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Divider(
                thickness: 2,
                color: Colors.blueAccent.shade100,
                indent: 20,
                endIndent: 20),
            Text(args.description, style: TextStyle(fontSize: 18))
          ],
        ),
      ),
    );
  }
}
