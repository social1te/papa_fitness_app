import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class ClubScreen extends StatefulWidget {
  const ClubScreen({super.key});

  @override
  State<ClubScreen> createState() => _ClubScreenState();
}

class _ClubScreenState extends State<ClubScreen> {
  _launchTg() async {
    final Uri url = Uri.parse('https://www.google.ru/t.me/solevar_fitnessBot');
    if (!await launchUrl(url)) {
      throw Exception('nea))');
    }
  }

  _launchVk() async {
    final Uri url = Uri.parse('https://www.google.ru');
    if (!await launchUrl(url)) {
      throw Exception('nea))');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.blueAccent.shade100,
        centerTitle: true,
        title: Text('О клубе', style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.all(5),
                child: Text('Рекорд фитнес ЭКО',
                    style:
                        TextStyle(fontSize: 21, fontWeight: FontWeight.w600))),
            Padding(
              padding: EdgeInsets.all(5),
              child: Text('Великий Новгород, пл. Мира, д. 21А',
                  style: TextStyle(fontSize: 18)),
            ),
            Card(
              elevation: 12,
              color: Colors.white,
              child: ListTile(
                isThreeLine: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                leading: Icon(
                  Icons.access_time_rounded,
                  color: Colors.blueAccent.shade100,
                  size: 28,
                ),
                title: Text(
                  'Режим работы:',
                  style: TextStyle(color: Colors.black),
                ),
                subtitle: Text(
                  'Пн-Пт: 7:00 - 23:00'
                  '\n'
                  'Сб-Вс 10:00 - 22:00',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
            ),
            GestureDetector(
              onTap: ()=> launch('tel://88162689968'),
              child: Card(
                elevation: 12,
                color: Colors.white,
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  leading: Icon(
                    Icons.phone_android,
                    color: Colors.blueAccent.shade100,
                    size: 28,
                  ),
                  title: Text(
                    '+7(816)2689958',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
            Card(
              elevation: 12,
              color: Colors.white,
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                leading: Icon(
                  Icons.email,
                  color: Colors.blueAccent.shade100,
                  size: 28,
                ),
                title: Text(
                  'rekord.fitness@mail.ru',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            Card(
              elevation: 12,
              color: Colors.white,
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
            SizedBox(height: 10),
            Text('Мы в соц. сетях', style: TextStyle(fontSize: 18),),
            Divider(
              indent: 20,
              endIndent: 20,
              color: Colors.blueAccent.shade100,
              thickness: 2,
            ),
            GestureDetector(
              onTap: () => _launchVk(),
              child: Card(
                elevation: 12,
                color: Colors.lightBlue.shade900,
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  leading: SvgPicture.asset(
                    'assets/logovk1.svg',
                    color: Colors.white,
                  ),
                  title: Text(
                    'ВКонтакте',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => _launchTg(),
              child: Card(
                elevation: 12,
                color: Colors.blue,
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  leading: Icon(
                    Icons.telegram_sharp,
                    color: Colors.white,
                    size: 28,
                  ),
                  title: Text(
                    'Телеграм',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
