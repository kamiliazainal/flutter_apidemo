import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List data; // data asal null

  Future<void> getPosts() async {
    var url = 'https://ams-api.astro.com.my/ams/v3/getChannelList';
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      
      setState(() {
        data = jsonResponse['channels'];
        print(data);
      });
    } else {
      print('error');
    }
  }

  @override
  void initState() {
    super.initState();
    getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('API Demo'),
        ),
        body: ListView.builder(
            itemCount: data == null? 0: data.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(data[index]['channelTitle']),
                subtitle: Text(data[index]['channelStbNumber'].toString()),
              );
            }),
      ),
    );
  }
}
