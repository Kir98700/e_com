import 'dart:io';

import 'package:e_com/Inviewproduct.dart';
import 'package:e_com/LogInPage.dart';
import 'package:e_com/main.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:just_audio/just_audio.dart';

import 'addproanim.dart';

class DashbordPage extends StatefulWidget {
  static int count = 0;

  @override
  State<DashbordPage> createState() => _DashbordPageState();
}

class _DashbordPageState extends State<DashbordPage> {
  String fonts = "Font11";
  String? appbar;

  List<Widget> listtt = [View_Products(), Add_Products()];

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
        resizeToAvoidBottomInset: false,
        drawer: Drawer(
            shape: Border.all(width: 2),
            backgroundColor: Colors.red.shade100,
            child: ListView(
              children: [
                UserAccountsDrawerHeader(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                "imagesss/wallpaperflare-cropped.jpg"),
                            fit: BoxFit.fill)),
                    currentAccountPicture: CircleAvatar(
                      maxRadius: 50,
                      backgroundColor: Colors.transparent,
                    ),
                    accountName: Text(
                      "Name : Kirtan Savani",
                      style: TextStyle(fontFamily: fonts),
                    ),
                    accountEmail: Text("Email : Kirtansavani@gmail.com",
                        style: TextStyle(fontFamily: fonts))),
                Column(
                  children: [
                    ListTile(
                      onTap: () {
                        Navigator.pop(context);
                        setState(() {
                          DashbordPage.count = 1;
                        });
                      },
                      tileColor: Colors.purple.shade100,
                      leading: Icon(Icons.add_shopping_cart),
                      title: Text("Add Product"),
                      trailing: Icon(Icons.arrow_right),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.pop(context);
                        setState(() {
                          DashbordPage.count = 0;
                        });
                      },
                      tileColor: Colors.purple.shade100,
                      leading: Icon(Icons.view_comfy_rounded),
                      title: Text("View Product"),
                      trailing: Icon(Icons.arrow_right),
                    ),
                    SizedBox(
                      height: 280,
                    ),
                    ListTile(
                      onTap: () {
                        Spleshscreen.prefs!
                            .setBool("Itslogin", false)
                            .then((value) {
                          Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) {
                              return LogInPage();
                            },
                          ));
                        });
                      },
                      tileColor: Colors.purple.shade100,
                      title: Text("Log Out"),
                      trailing: Icon(Icons.logout_rounded),
                    ),
                  ],
                )
              ],
            )),
        appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text(DashbordPage.count == 1
                ? appbar = "Add_Product"
                : DashbordPage.count == 0
                    ? appbar = "View_Product"
                    : appbar = "Homepage"),
            actions: [
              IconButton(
                  onPressed: () {
                    Spleshscreen.prefs!
                        .setBool("loginstatus", false)
                        .then((value) {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) {
                          return LogInPage();
                        },
                      ));
                    });
                  },
                  icon: Icon(Icons.logout))
            ],
            elevation: 20),
        body: listtt[DashbordPage.count],
      ),
    );
  }
}

class Add_Products extends StatefulWidget {
  const Add_Products({Key? key}) : super(key: key);

  @override
  State<Add_Products> createState() => _Add_ProductsState();
}

class _Add_ProductsState extends State<Add_Products> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  TextEditingController Product_Name = TextEditingController();
  TextEditingController Product_Type = TextEditingController();
  TextEditingController Product_Price = TextEditingController();
  TextEditingController Product_Description = TextEditingController();
  TextEditingController Product_Qty = TextEditingController();

  String font1 = "fonts";

  String thetype = "";

  String Images = "";

  bool Imagelod = false;

  CroppedFile? croppedFile;

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
        // resizeToAvoidBottomInset: false,
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.grey),
          child: SingleChildScrollView(
            child: Column(
              children: [
                InkWell(
                    onTap: () async {
                      final ImagePicker _picker = ImagePicker();
                      // Pick an image
                      final XFile? image = await _picker.pickImage(
                          source: ImageSource.gallery, imageQuality: 10);
                      setState(() {
                        Images = image!.path;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.all(5),
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: FileImage(File(Images)),
                              fit: BoxFit.fitWidth),
                          color: Colors.blueAccent.shade200,
                          border: Border.all(
                              color: Colors.blue.shade800, width: 3)),
                      child: Center(
                          child: Text(
                        "Tab to enter the image",
                        style: TextStyle(fontSize: 20, fontFamily: font1),
                      )),
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                      controller: Product_Name,
                      style: TextStyle(fontFamily: font1),
                      decoration: InputDecoration(
                          filled: true,
                          //errorText: "Your Name Is Incorrect",
                          fillColor: Colors.white,
                          errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red)),
                          hintText: "Enter Your Product Name",
                          hintStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)))),
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Radio(
                          activeColor: Colors.red,
                          value: "Mobile",
                          groupValue: thetype,
                          onChanged: (value) {
                            setState(() {
                              thetype = value!;
                            });
                          },
                        ),
                        Text(
                          "Mobile",
                          style: TextStyle(fontSize: 15),
                        ),
                        Radio(
                          activeColor: Colors.red,
                          value: "Perfume",
                          groupValue: thetype,
                          onChanged: (value) {
                            setState(() {
                              thetype = value!;
                            });
                          },
                        ),
                        Text(
                          "Perfume",
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                          activeColor: Colors.red,
                          value: "Home_Product",
                          groupValue: thetype,
                          onChanged: (value) {
                            setState(() {
                              thetype = value!;
                            });
                          },
                        ),
                        Text(
                          "Home_Product",
                          style: TextStyle(fontSize: 15),
                        ),
                        Radio(
                          activeColor: Colors.red,
                          value: "Cloth",
                          groupValue: thetype,
                          onChanged: (value) {
                            setState(() {
                              thetype = value!;
                            });
                          },
                        ),
                        Text(
                          "Cloth",
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 60,
                            width: 100,
                            child: TextField(
                                controller: Product_Price,
                                style: TextStyle(fontFamily: font1),
                                decoration: InputDecoration(
                                    filled: true,
                                    //errorText: "Your Name Is Incorrect",
                                    fillColor: Colors.white,
                                    errorBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.red)),
                                    hintText: "Price",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)))),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 60,
                            width: 100,
                            child: TextField(
                                controller: Product_Qty,
                                style: TextStyle(fontFamily: font1),
                                decoration: InputDecoration(
                                    filled: true,
                                    //errorText: "Your Name Is Incorrect",
                                    fillColor: Colors.white,
                                    errorBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.red)),
                                    hintText: "Qty",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)))),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                          controller: Product_Description,
                          maxLines: 5,
                          style: TextStyle(fontFamily: font1),
                          decoration: InputDecoration(
                              filled: true,
                              //errorText: "Your Name Is Incorrect",
                              fillColor: Colors.white,
                              errorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red)),
                              hintText: "Enter Your Product Description",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15)))),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () async {
                    final storageRef = FirebaseStorage.instance.ref();

                    String imagename =
                        "Image${DateTime.now().day}${DateTime.now().month}${DateTime.now().year}.jpg";

                    final spaceRef = storageRef.child("Imagess/${imagename}");

                    await spaceRef.putFile(File(Images));

                    spaceRef.getDownloadURL().then((value) async {
                      print(value);

                      DatabaseReference ref =
                          FirebaseDatabase.instance.ref("kirtan").push();

                      String? Idd = ref.key;
                      //
                      // TextEditingController Product_Name = TextEditingController();
                      // TextEditingController Product_Type = TextEditingController();
                      // TextEditingController Product_Price = TextEditingController();
                      // TextEditingController Product_Description = TextEditingController();
                      // TextEditingController Product_Qty = TextEditingController();

                      await ref.set({
                        "Id": Idd,
                        "name": Product_Name.text,
                        // "Type": Product_Type.text,
                        "Price": Product_Price.text,
                        "Description": Product_Description.text,
                        "Qty": Product_Qty.text,

                        "Images": "$value",
                      }).then((value) {
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) {
                            return animetion();
                          },
                        ));
                        print("Thank yu =============================");
                      });
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.blueAccent.shade200,
                        borderRadius: BorderRadius.circular(10),
                        border:
                            Border.all(color: Colors.blue.shade800, width: 3)),
                    child: Center(
                        child: Text(
                      "Add_Product",
                      style: TextStyle(
                          fontSize: 25, color: Colors.white, fontFamily: font1),
                    )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class View_Products extends StatefulWidget {
  const View_Products({Key? key}) : super(key: key);

  @override
  State<View_Products> createState() => _View_ProductsState();
}

class _View_ProductsState extends State<View_Products> {
  List temp = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    forviewdata();
  }

  final player = AudioPlayer();

  bool isload = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.grey.shade300,
          child: GridView.builder(
            itemCount: temp.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  player.setAsset("audioplay/QKTA234-pop.mp3");
                  player.play();
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return Inviewproduct(temp, index);
                    },
                  ));
                },
                onLongPress: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(color: Colors.black),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () {},
                              child: Container(
                                width: 170,
                                height: 60,
                                color: Colors.grey,
                                child: Center(child: Text("Pro_Delete")),
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: Container(
                                width: 170,
                                height: 60,
                                color: Colors.grey,
                                child: Center(child: Text("Pro_Update")),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage("${temp[index]['Images']}"),
                                fit: BoxFit.fill)),
                      ),
                      Text("${temp[index]['name']}"),
                    ],
                  ),
                ),
              );
            },
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          ),
        ),
      ),
    );
  }

  void forviewdata() {
    DatabaseReference ref = FirebaseDatabase.instance.ref("kirtan");
    // Stream<DatabaseEvent> de = ref.onValue;         // stream<Databaseevent>
    //
    // de.listen((DatabaseEvent event) {
    //   print('Event Type == ${event.type}');
    //   print('Event Snepshot == ${event.snapshot}');
    //
    //   map = event.snapshot.value as Map;
    //
    // });

    ref.onValue.listen((event) {
      // var snapshot = event.snapshot;
      temp.clear();
      Map mm = event.snapshot.value as Map;
      mm.forEach((key, value1) {
        setState(() {
          temp.add(value1);
        });
      });
    });
  }
}
