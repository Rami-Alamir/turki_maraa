import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.only(top: 60),
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text('المساعدة',
                style: TextStyle(
                    color: Color.fromRGBO(132, 15, 15, 1),
                    fontSize: 20,
                    fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }
}
