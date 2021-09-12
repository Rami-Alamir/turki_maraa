import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 35,
            backgroundColor: Theme.of(context).primaryColor,
            child: Text('ر ا', style: TextStyle(fontSize: 20)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('رامي الأمير',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black)),
                Text('0580809976',
                    style: TextStyle(
                        fontSize: 14,
                        height: 2,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500))
              ],
            ),
          )
        ],
      ),
    );
  }
}
