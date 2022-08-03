import 'package:flutter/material.dart';
import 'package:flutter_google_map_example/map_page.dart';
import 'package:flutter_google_map_example/map_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Map Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true
      ),
      home: ChangeNotifierProvider(
        create: (_) => MapProvider(),
        child: const MapPage(),
      ),
    );
  }
}
