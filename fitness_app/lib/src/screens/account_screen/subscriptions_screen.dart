import 'package:fitness_app/src/repository/data/services/api_service.dart';
import 'package:fitness_app/src/repository/data/services/subscriptions_service.dart';
import 'package:flutter/material.dart';

class SubscriptionsScreen extends StatefulWidget {
  const SubscriptionsScreen({super.key});

  @override
  State<SubscriptionsScreen> createState() => _SubscriptionsScreenState();
}

class _SubscriptionsScreenState extends State<SubscriptionsScreen> {
  @override
  Widget build(BuildContext context) {
    apiService;
    final subscriptionsService = SubscriptionsService(apiService.dio);
    return FutureBuilder(
        future: subscriptionsService.getSubscriptions(query: 'subscriptions'),
        builder: (context, snapshot) {
          if (snapshot.error != null || snapshot.stackTrace != null) {
            return Material(
              child: Center(
                child: Text('${snapshot.error}'),
              ),
            );
          }
          if (snapshot.data != null ||
              snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              appBar: AppBar(
                iconTheme: IconThemeData(color: Colors.white),
                backgroundColor: Colors.blueAccent.shade100,
                title: Text(
                  'Мои абонементы',
                  style: TextStyle(color: Colors.white),
                ),
                centerTitle: true,
              ),
              body: Center(
                child: ListView.separated(
                  separatorBuilder: (BuildContext context, int index) =>
                      SizedBox(height: 5),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index){
                    return Card(
                      elevation: 12,
                      color: Colors.grey.shade900,
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        leading: CircleAvatar(
                          backgroundColor: Colors.blueAccent.shade100,
                          child: Icon(
                            Icons.fitness_center,
                            color: Colors.white,
                          ),
                        ),
                        title: Text(
                          snapshot.data![index].price,
                          style: TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          snapshot.data![index].number.toString(),
                          style: TextStyle(color: Colors.blueAccent.shade100),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          }
          return Material(
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.blueAccent.shade100,
              ),
            ),
          );
        });
  }
}
