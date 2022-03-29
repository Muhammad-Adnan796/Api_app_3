import 'dart:convert';

import 'package:api_app_3/user_model/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiData extends StatefulWidget {
  const ApiData({Key? key}) : super(key: key);

  @override
  State<ApiData> createState() => _ApiDataState();
}

class _ApiDataState extends State<ApiData> {
  List<UserModel> apiList = [];

  Future<List<UserModel>> getdata() async {
    final response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/users"),
    );
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map i in data) {
        apiList.add(UserModel.fromJson(i));
      }
      return apiList;
    } else {
      return apiList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Api Data 3",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getdata(),
                builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return ListView.builder(
                        itemCount: apiList.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  ReUseableData(
                                    title: "Name : ",
                                    value:
                                        snapshot.data![index].name.toString(),
                                  ),
                                  ReUseableData(
                                    title: "User NAme : ",
                                    value: snapshot.data![index].username
                                        .toString(),
                                  ),
                                  ReUseableData(
                                    title: "Email : ",
                                    value:
                                        snapshot.data![index].email.toString(),
                                  ),
                                  ReUseableData(
                                    title: "Addres : ",
                                    value: snapshot.data![index].address!.city
                                        .toString(),
                                  ),
                                  ReUseableData(
                                    title: "House Address : ",
                                    value: snapshot
                                        .data![index].address!.geo!.lat
                                        .toString(),
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  }
                }),
          )
        ],
      ),
    );
  }
}

class ReUseableData extends StatelessWidget {
  ReUseableData({required this.value, required this.title});

  String value;
  String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
            ),
            Text(
              value,
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
            )
          ],
        )
      ],
    );
  }
}
