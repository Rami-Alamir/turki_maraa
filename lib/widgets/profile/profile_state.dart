import 'package:flutter/material.dart';
import 'package:new_turki/screens/orders/orders.dart';
import 'package:new_turki/screens/profile/points.dart';
import 'package:new_turki/screens/profile/wallet.dart';
import 'package:new_turki/utilities/size_config.dart';

class ProfileState extends StatefulWidget {
  const ProfileState({Key? key}) : super(key: key);

  @override
  _ProfileStateState createState() => _ProfileStateState();
}

class _ProfileStateState extends State<ProfileState> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: SizeConfig.screenWidth! * .85,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Orders(
                              back: true,
                            )),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('6',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w600)),
                      Text('طلباتي',
                          style: TextStyle(
                              fontSize: 14,
                              height: 2,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 40,
                    color: Colors.grey.withOpacity(0.5),
                    width: 1,
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserPoints()),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('150',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              //     color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w600)),
                      Text('نقاطي',
                          style: TextStyle(
                              fontSize: 14,
                              height: 2,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 40,
                    color: Colors.grey.withOpacity(0.5),
                    width: 1,
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserWallet()),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('100',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              //     color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w600)),
                      Text('رصيدي',
                          style: TextStyle(
                              fontSize: 14,
                              height: 2,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
