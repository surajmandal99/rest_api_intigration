import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';

import '../models/user_model.dart';
import 'package:http/http.dart' as http;

class SecondExample extends StatefulWidget {
  const SecondExample({super.key});

  @override
  State<SecondExample> createState() => _SecondExampleState();
}

class _SecondExampleState extends State<SecondExample> {
  List<UserModel> userList = [];

  Future<List<UserModel>> getUserApi() async {
    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map<String, dynamic> i in data) {
        // print(i['name']);
        userList.add(UserModel.fromJson(i));
      }
      return userList;
    } else {
      return userList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Second Example"),
        centerTitle: true,
      ),
      body: Column(children: [
        Expanded(
          child: FutureBuilder(
            future: getUserApi(),
            builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: userList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                                transform: GradientRotation(54),
                                begin: Alignment.bottomCenter,
                                end: Alignment.center,
                                colors: [Colors.grey, Colors.yellow]),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black),
                          ),
                          child: Column(
                            children: [
                              ResusableRow(
                                  title: "Name:",
                                  value: snapshot.data![index].name.toString()),
                              ResusableRow(
                                  title: "UserName:",
                                  value: snapshot.data![index].username
                                      .toString()),
                              ResusableRow(
                                  title: "Email:",
                                  value:
                                      snapshot.data![index].email.toString()),
                              ResusableRow(
                                  title: "Address:",
                                  value: snapshot.data![index].address!.street
                                      .toString()),
                              ResusableRow(
                                  title: "Street:",
                                  value: snapshot.data![index].address!.street
                                      .toString()),
                              ResusableRow(
                                  title: "Suite:",
                                  value: snapshot.data![index].address!.suite
                                      .toString()),
                              ResusableRow(
                                  title: "City:",
                                  value: snapshot.data![index].address!.city
                                      .toString()),
                              ResusableRow(
                                  title: "ZipCode:",
                                  value: snapshot.data![index].address!.zipcode
                                      .toString()),
                              ResusableRow(
                                  title: "Lat:",
                                  value: snapshot.data![index].address!.geo!.lat
                                      .toString()),
                              // ResusableRow(
                              //     title: "Lng:",
                              //     value: snapshot.data![index].address!.geo!.lng
                              //         .toString()),
                            ],
                          ),
                        ),
                      );
                    });
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        )
      ]),
    );
  }
}

// ignore: must_be_immutable
class ResusableRow extends StatelessWidget {
  String title, value;
  ResusableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ),
        Text(value)
      ]),
    );
  }
}
