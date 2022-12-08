import 'package:basarsoft_task/view/map_view.dart';
import 'package:basarsoft_task/models/get_user_data.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await getUsers();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Başarsoft Task",
      home: MapView(),
    );
  }
}
