import 'package:flutter/material.dart';
import 'package:good_dentist_mobile/src/screens/menu/ClinicInformationScreen.dart';
import 'package:good_dentist_mobile/src/screens/common/LoginScreen.dart';
import 'package:good_dentist_mobile/src/screens/menu/ProfileInformationScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MenuScreenState();
  }
}

class _MenuScreenState extends State<MenuScreen> {

  Future<void> _signOut(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
          (Route<dynamic> route) => false,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Menu'),
            ],
          ),
          backgroundColor: Colors.purple[400]),
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                          const ProfileInformationScreen()),
                    );
                  },
                  child: Container(
                    height: 70,
                    margin: const EdgeInsets.only(right: 15, left: 15),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 0.8, color: Colors.grey),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.account_circle,
                            color: Color(0xFFAB47AC)),
                        SizedBox(width: constraints.maxWidth * 0.05),
                        SizedBox(
                          width: constraints.maxWidth * 0.5,
                          child: const Text(
                            "Profile Information",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(width: constraints.maxWidth * 0.25),
                        const Icon(Icons.navigate_next),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                          const ClinicInformationScreen()),
                    );
                  },
                  child: Container(
                    height: 70,
                    margin: const EdgeInsets.only(right: 15, left: 15),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 0.8, color: Colors.grey),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.business, color: Color(0xFFAB47AC)),
                        SizedBox(width: constraints.maxWidth * 0.05),
                        SizedBox(
                          width: constraints.maxWidth * 0.5,
                          child: const Text(
                            "Clinic Information",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(width: constraints.maxWidth * 0.25),
                        const Icon(Icons.navigate_next),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap:() => _signOut(context),
                  child: Container(
                      height: 70,
                      alignment: Alignment.center,
                      margin:
                      const EdgeInsets.only(right: 15, left: 15, top: 50),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius:
                        BorderRadius.circular(220), // Add border radius
                      ),
                      child: const Text("Sign Out",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold))),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
