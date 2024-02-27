import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../repository/data/services/api_service.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late String jwtToken;
  late WebSocketChannel channel;
  TextEditingController messageController = TextEditingController();
  List<Map<String, dynamic>> messages = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)!.settings.arguments as List<String>;
      jwtToken = apiService.dio.options.headers['Authorization'];
      channel = IOWebSocketChannel.connect(
          'wss://fohowomsk.ru/ws/${args[0]}/?token=$jwtToken');
      channel.stream.listen((message) {
        print('polucheno: $message');
        handleMessage(message);
      }, onError: (error) {
        print('WebSocket Error: $error');
      });
      Map<String, dynamic> adminMessage = {
        'type': 'message',
        'message': 'Доброго времени суток! Чем могу вам помочь?',
        'username': 'Администратор'
      };
      setState(() {
        messages.insert(0, adminMessage);
      });
    });
  }

  void handleMessage(message) {
    Map<String, dynamic> data = jsonDecode(message);
    setState(() {
      messages.insert(0, data);
    });
  }

  void sendMessage(String message, String username) {
    if (message.isNotEmpty) {
      Map<String, dynamic> data = {
        'type': 'message',
        'message': message,
        'username': username,
      };
      channel.sink.add(jsonEncode(data));
      messageController.clear();
      print('zalupa send' + message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as List<String>;
    return Scaffold(
      appBar: AppBar(
        title: Text('Поддержка', style: TextStyle(color: Colors.white),),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.blueAccent.shade100,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> message = messages[index];
                final bool isCurrentUser = message['username'] == args[2];
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  child: Row(
                    mainAxisAlignment: isCurrentUser
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Container(
                          decoration: BoxDecoration(
                            color: isCurrentUser
                                ? Colors.blueAccent.shade100
                                : Colors.grey.shade600,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                              bottomLeft: !isCurrentUser
                                  ? Radius.circular(0)
                                  : Radius.circular(16),
                              bottomRight: isCurrentUser
                                  ? Radius.circular(0)
                                  : Radius.circular(16),
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 8, horizontal: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                message['username'],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                message['message'],
                                style: TextStyle(
                                  color: Colors.white
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: 'Введите сообщение',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.send,
                    color: Colors.blueAccent.shade100,
                  ),
                  onPressed: () {
                    sendMessage(messageController.text, args[2]);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }
}
