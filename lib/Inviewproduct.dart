import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class Inviewproduct extends StatefulWidget {
  DataSnapshot snapshot;


  Inviewproduct(this.snapshot);

  @override
  State<Inviewproduct> createState() => _InviewproductState();
}

class _InviewproductState extends State<Inviewproduct> {
  int i = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(backgroundColor: Colors.black,
          title: Text('${widget.snapshot.child('name').value}'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(5),
                height: 270,
                width: double.infinity,
                child: PageView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return Flexible(
                      child: Container(
                        color: Colors.black,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: PhotoView(
                              imageProvider: NetworkImage(
                                  "${widget.snapshot.child('Images').value}")),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Spacer(),
                        Text(
                          '${widget.snapshot.child('name').value}',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Spacer(),
                        Text(
                          ' ${widget.snapshot.child('Description').value}',
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          'Price ',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        Text(
                          '${widget.snapshot.child('Price').value}',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: 50,
                width: double.infinity,
                color: Colors.grey,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.star, color: Colors.yellow),
                    Icon(Icons.star, color: Colors.yellow),
                    Icon(Icons.star, color: Colors.yellow),
                    Icon(Icons.star, color: Colors.white),
                    Icon(Icons.star, color: Colors.white),
                    SizedBox(width: 10),
                    Text('(4.0)'),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        setState(() {
                          i--;
                        });
                      },
                    ),
                    SizedBox(width: 10),
                    Text("${i}"),
                    SizedBox(width: 10),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          i++;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                      height: 50,
                      width: 150,
                      color: Colors.grey,
                      child: IconButton(
                          onPressed: () {}, icon: Icon(Icons.shopping_cart))),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
