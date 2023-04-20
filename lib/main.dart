import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'DashbordPage.dart';
import 'LogInPage.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  );
  runApp(MaterialApp(debugShowCheckedModeBanner: false,
    home: Spleshscreen(),
  ));
}

class Spleshscreen extends StatefulWidget {
  static SharedPreferences? prefs;

  @override
  State<Spleshscreen> createState() => _SpleshscreenState();
}

class _SpleshscreenState extends State<Spleshscreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Forshareprefrence();
  }

  bool Islogin = false;

  @override
  Widget build(BuildContext context) {
    double theheigth = MediaQuery.of(context).size.height;
    double thewidth = MediaQuery.of(context).size.width;
    double Statusbarheight = MediaQuery.of(context).padding.top;
    double Navibarheight = MediaQuery.of(context).padding.bottom;
    double Appbarheight = kToolbarHeight;
    double Bodyheigth = theheigth - Statusbarheight - Navibarheight;

    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.black),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  height: Bodyheigth * 0.5,
                  child: Lottie.asset('Flutter_Anime/opener-loading.json',
                      fit: BoxFit.fill))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> Forshareprefrence() async {
    Spleshscreen.prefs = await SharedPreferences.getInstance();

    setState(() {
      Islogin = Spleshscreen.prefs!.getBool("Itslogin") ?? false;
    });

    Future.delayed(Duration(seconds: 4)).then((value) {
      if (Islogin) {
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return DashbordPage();
          },
        ));
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return LogInPage();
          },
        ));
      }
    });
  }
}
