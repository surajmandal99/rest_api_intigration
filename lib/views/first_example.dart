import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rest_api_intigration/models/photo_model.dart';
import 'package:http/http.dart' as http;

class FirstExample extends StatefulWidget {
  const FirstExample({super.key});

  @override
  State<FirstExample> createState() => _FirstExampleState();
}

class _FirstExampleState extends State<FirstExample> {
  List<PhotoModel> postList = [];
  Future<List<PhotoModel>> getPhotos() async {
    final response = await http
        .get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
    var data = jsonDecode(response.body.toString());
    print(data);

    if (response.statusCode == 200) {
      for (Map i in data) {
        PhotoModel photos =
            PhotoModel(title: i['title'], url: i['url'], id: i["id"]);
        postList.add(photos);
      }
      return postList;
    } else {
      return postList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Api Integration"),
        centerTitle: true,
      ),
      body: Column(children: [
        Expanded(
            child: FutureBuilder(
          future: getPhotos(),
          builder: (context, AsyncSnapshot<List<PhotoModel>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: postList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                                snapshot.data![index].url.toString())),
                        title: Text(snapshot.data![index].title.toString()),
                        subtitle: Text(
                            'Notes id:${snapshot.data![index].id.toString()}'),
                      ),
                    );
                  });
            } else if (snapshot.hasError) {
              return const Center(child: Text("Error"));
            } else {
              return const Center(
                  child: Center(child: CircularProgressIndicator()));
            }
          },
        ))
      ]),
    );
  }
}
