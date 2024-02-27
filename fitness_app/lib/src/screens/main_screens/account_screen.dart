import 'package:fitness_app/src/repository/data/models/account_model.dart';
import 'package:flutter/material.dart';

import '../../repository/data/services/account_service.dart';
import '../../repository/data/services/api_service.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    apiService;
    final accountService = AccountService(apiService.dio);
    final eventHistoryService = AccountService(apiService.dio);

    return FutureBuilder(
      future: Future.wait([
        accountService.getAccount(query: 'account'),
        eventHistoryService.getHistory(query: 'history'),
      ]),
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.error != null || snapshot.stackTrace != null) {
          print(snapshot.error);
          return Material(
            child: Center(
              child: Text('${snapshot.error}'),
            ),
          );
        }
        if (snapshot.data != null ||
            snapshot.connectionState == ConnectionState.done) {
          AccountModel account = snapshot.data![0];
          List<EventHistoryModel> eventHistoryList = snapshot.data![1];
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.blueAccent.shade100,
              centerTitle: true,
              title: Text(
                'Ваш профиль',
                style: TextStyle(color: Colors.white),
              ),
            ),
            body: Column(
              children: [
                const SizedBox(height: 20),
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 55,
                      backgroundColor: Colors.blueAccent.shade100,
                      child: account.photo[0] != null
                          ? Image.network(account.photo)
                          : Icon(Icons.person, color: Colors.white)
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.blueAccent.shade100,
                        child: CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.white,
                          child: GestureDetector(
                            onTap: () => Navigator.of(context).pushNamed('/edit_personal_info_screen', arguments: account),
                            child: Icon(
                              Icons.edit,
                              color: Colors.blueAccent.shade100,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 15),
                Text(
                  account.first_name.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () =>
                          Navigator.of(context).pushNamed('/balance_screen'),
                      child: Card(
                        color: Colors.white,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.blueAccent.shade100),
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        child: SizedBox(
                          height: 160,
                          width: 129,
                          child: Center(
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 55,
                                ),
                                Text(
                                  account.balance.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.black),
                                ),
                                Text(
                                  'Баланс',
                                  style: TextStyle(
                                      color: Colors.blueAccent.shade100,
                                      fontWeight: FontWeight.w300),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context)
                          .pushNamed('/my_schedule_screen', arguments: snapshot.data),
                      child: Card(
                        color: Colors.white,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.blueAccent.shade100),
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        child: SizedBox(
                          height: 160,
                          width: 129,
                          child: Center(
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 70,
                                ),
                                Text(
                                  'Моё расписание',
                                  style: TextStyle(
                                      color: Colors.blueAccent.shade100,
                                      fontWeight: FontWeight.w300),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context)
                          .pushNamed('/subscriptions_screen'),
                      child: Card(
                        color: Colors.white,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.blueAccent.shade100),
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        child: SizedBox(
                          height: 160,
                          width: 129,
                          child: Center(
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 70,
                                ),
                                Text(
                                  'Абонементы',
                                  style: TextStyle(
                                      color: Colors.blueAccent.shade100,
                                      fontWeight: FontWeight.w300),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                if (account.role.toString() == 'coach' ||
                    account.role.toString() == 'admin')
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: ElevatedButton(
                      onPressed: () =>
                          Navigator.of(context).pushNamed('/main_coach_screen'),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent.shade100,
                          fixedSize: Size(400, 50)),
                      child: Text(
                        'Тренерская панель',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                else
                  SizedBox(),
                if (account.role.toString() == 'admin')
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: ElevatedButton(
                      onPressed: () =>
                          Navigator.of(context).pushNamed('/admin_screen'),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent.shade100,
                          fixedSize: Size(400, 50)),
                      child: Text(
                        'Админ панель',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                else
                  SizedBox(),
                Text(
                  'История посещений:',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.blueAccent.shade100, fontSize: 20),
                ),
                SizedBox(height: 20),
                Divider(
                  color: Colors.blueAccent.shade100,
                  thickness: 2,
                  endIndent: 20,
                  indent: 20,
                ),
                ListView.separated(
                  shrinkWrap: true,
                    primary: false,
                    separatorBuilder: (BuildContext context, int index) =>
                        SizedBox(),
                    itemCount: eventHistoryList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
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
                                eventHistoryList![index]
                                        .start_date!
                                        .hour
                                        .toString() +
                                    ':' +
                                    eventHistoryList![index]
                                        .start_date!
                                        .minute
                                        .toString(),
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                eventHistoryList![index].duration.toString() +
                                    ' минут',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          title: Text(
                            eventHistoryList![index].title.toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(
                            eventHistoryList![index].club.toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                          tileColor: Colors.blueAccent.shade100,
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                          ),
                          isThreeLine: true,
                        ),
                      );
                    }),
              ],
            ),
          );
        }

        return Material(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
