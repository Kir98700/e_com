import 'package:e_com/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottie/lottie.dart';

import 'DashbordPage.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  String fonts = "Font11";
  bool Seeotp = true;
  String phoneRegex = r'(^(?:[+0]9)?[0-9]{10,12}$)';
  String verficid = "";

  TextEditingController Phoneno = TextEditingController();
  TextEditingController Otp = TextEditingController();

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
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Text(
                        "Welcome\tBack !\nLog in",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: fonts,
                            fontSize: 35),
                      ),
                    ),
                  ],
                ),
                Container(
                    height: Bodyheigth * 0.4,
                    child: Lottie.asset('Flutter_Anime/Comp 1.json',
                        fit: BoxFit.fill)),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.number,
                    controller: Phoneno,
                    style: TextStyle(fontFamily: fonts),
                    decoration: InputDecoration(
                        filled: true,
                        //errorText: "Your Name Is Incorrect",
                        fillColor: Colors.white,
                        prefixIcon: Icon(Icons.phone),
                        errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red)),
                        hintText: "Enter Your Phoneno",
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15))),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please fill empty field";
                      } else if (!RegExp(phoneRegex).hasMatch(value)) {
                        return "Enter valid phone number";
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () async {
                    await FirebaseAuth.instance.verifyPhoneNumber(
                      phoneNumber: '+91${Phoneno.text}'.trim(),
                      verificationFailed: (FirebaseAuthException e) {
                        if (e.code == 'invalid-phone-number') {
                          print('The provided phone number is not valid.');
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("invalid-phone-number")));
                        }
                        // Handle other errors
                      },
                      verificationCompleted:
                          (PhoneAuthCredential credential) {},
                      codeSent: (String verificationId, int? resendToken) {
                        setState(() {
                          verficid = verificationId;
                        });
                      },
                      codeAutoRetrievalTimeout: (String verificationId) {},
                    );
                  },
                  child: Container(
                    height: 50,
                    width: 150,
                    decoration: BoxDecoration(
                        color: Colors.blueGrey.shade100,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(width: 2, color: Colors.white)),
                    child: Center(
                        child: Text(
                      "Get Otp",
                      style: TextStyle(
                          color: Colors.black, fontFamily: fonts, fontSize: 20),
                    )),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.number,
                    controller: Otp,
                    obscureText: Seeotp,
                    //style: TextStyle(fontFamily: fonts),
                    decoration: InputDecoration(
                        filled: true,
                        //errorText: "Your Name Is Incorrect",
                        fillColor: Colors.white,
                        prefixIcon: Icon(Icons.password),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              if (Seeotp) {
                                Seeotp = false;
                              } else if (!Seeotp) {
                                Seeotp = true;
                              }
                            });
                          },
                          icon: Seeotp
                              ? Icon(
                                  Icons.visibility_off_outlined,
                                  color: Colors.black,
                                )
                              : Icon(
                                  Icons.visibility_outlined,
                                  color: Colors.black,
                                ),
                        ),
                        errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red)),
                        hintText: "Enter Your OTP",
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15))),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please fill empty field";
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () async {
                      FirebaseAuth auth = FirebaseAuth.instance;

                      String smsCode = Otp.text;

                      // Create a PhoneAuthCredential with the code
                      PhoneAuthCredential credential =
                          PhoneAuthProvider.credential(
                              verificationId: verficid, smsCode: smsCode);

                      // Sign the user in (or link) with the credential
                      await auth.signInWithCredential(credential).then((value) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Succsecfully")));

                        Spleshscreen.prefs!.setBool("Itslogin", true);

                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) {
                            return DashbordPage();
                          },
                        ));
                        print("==$value");
                      });
                    },
                    child: Container(
                      height: 50,
                      width: 200,
                      decoration: BoxDecoration(
                          color: Colors.blueGrey.shade100,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(width: 2, color: Colors.white)),
                      child: Center(
                          child: Text(
                        "Log In",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: fonts,
                            fontSize: 20),
                      )),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextButton(
                    onPressed: () {
                      signInWithGoogle().then((value) {
                        Spleshscreen.prefs!.setBool("Itslogin", true);
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) {
                            return DashbordPage();
                          },
                        ));
                      });
                    },
                    child: Text("Create Account With Google ??",
                        style: TextStyle(
                            color: Colors.white60, fontFamily: fonts)))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
