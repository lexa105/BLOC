import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hiringappjson/models/model.dart';
import 'package:dio/dio.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<UsersDetail> _list = [];
  var loading = false;

  Future<void> _fetchData() async {
    setState(() {
      loading = true;
    });

    final response =
        await Dio().get('http://jsonplaceholder.typicode.com/users');
    if (response.statusCode == 200) {
      final data = jsonDecode(response.data);
      setState(() {
        for (Map i in data) {
          _list.add(UsersDetail.fromJson(i));
        }
        loading = false;
      });
    } else {
      print(response.statusCode);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Container(
            child: loading
                ? Container(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: _list.length,
                    itemBuilder: (context, i) {
                      final x = _list[i];
                      return Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(x.name),
                            Text(x.username),
                            Text(x.email),
                            Text(x.phone),
                            Text(x.website),
                            //Text(x.address.city),
                          ],
                        ),
                      );
                    },
                  )),
      ),
    );
  }
}
