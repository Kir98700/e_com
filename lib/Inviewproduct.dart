import 'package:flutter/material.dart';

class Inviewproduct extends StatefulWidget {
  List temp;
  int index;

  Inviewproduct(this.temp, this.index);

  @override
  State<Inviewproduct> createState() => _InviewproductState();
}

class _InviewproductState extends State<Inviewproduct> {
  int i = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(backgroundColor: Colors.black,
          title: Text('${widget.temp[widget.index]['name']}'),
        ),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.all(5),
              height: 270,
              width: double.infinity,
              child: Image.network(
                '${widget.temp[widget.index]['Images']}',
                fit: BoxFit.cover,
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
                        '${widget.temp[widget.index]['name']}',
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
                        ' ${widget.temp[widget.index]['Description']}',
                        style: TextStyle(fontSize: 16),
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
                        '${widget.temp[widget.index]['Price']}',
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
    );
  }
}
