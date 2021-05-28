import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'user_model.dart';

class ListViewPage extends StatefulWidget {
  ListViewPage({Key key}) : super(key: key);

  @override
  _ListViewPageState createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdate();
  }

  UserModel _userModel;
  List<Data> userData = List<Data>();
  List<Data> data = List<Data>();

  Future getdate() async {
    final response = await http.get(
      Uri.parse("https://gorest.co.in/public-api/products"),
    );
    var responseData = json.decode(response.body);
    print(responseData);
    if (response.statusCode == 200) {
      _userModel = UserModel.fromJson(json.decode(response.body));
      setState(() {
        userData = _userModel.data.toList();
      });

      return _userModel;
    } else {
      if (response.statusCode != 200) {
        print("Error Message");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product List"),
      ),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: userData.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 2),
                        color: Colors.grey[300],
                        blurRadius: 10)
                  ]),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 10.0),
                    width: (MediaQuery.of(context).size.width / 5),
                    height: (MediaQuery.of(context).size.height) * 0.10,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                            image:
                                NetworkImage(userData[index].image.toString()),
                            fit: BoxFit.cover)),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Name :" + userData[index].name.toString()),
                      Text("Price :" + userData[index].price.toString()),
                      Text("User ID :" + userData[index].id.toString()),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
