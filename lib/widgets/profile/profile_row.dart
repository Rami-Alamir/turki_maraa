import 'package:flutter/material.dart';

class ProfileRow extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function onTap;

  const ProfileRow(
      {required this.title, required this.icon, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          onTap();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0, top: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Icon(
                          icon,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                      Text(title,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          )),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black.withOpacity(0.8),
                    size: 18,
                  ),
                ),
              ],
            ),
            Divider(
              indent: 10,
              endIndent: 10,
              color: Colors.grey.withOpacity(0.3),
            )
          ],
        ),
      ),
    );
  }
}
