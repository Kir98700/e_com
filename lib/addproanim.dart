import 'package:e_com/DashbordPage.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class animetion extends StatefulWidget {
  const animetion({Key? key}) : super(key: key);

  @override
  State<animetion> createState() => _animetionState();
}

class _animetionState extends State<animetion> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    foranimetion();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(color: Color(0xFFE8DFCA)),
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Lottie.asset("Flutter_Anime/checkmark.json"),
              Text("SuccessFully Add")
            ],
          ),
        ),
      ),
    );
  }
  void foranimetion() {

    Future.delayed(Duration(seconds: 3)).then((value) {

      setState(() {
        DashbordPage.count=0;
      });

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return DashbordPage();
      },));

    });

  }
}
