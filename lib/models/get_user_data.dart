// ignore_for_file: prefer_typing_uninitialized_variables, prefer_final_fields
import 'package:basarsoft_task/models/users.dart';
import 'package:dio/dio.dart';

final client = Dio();

List<Users> user = [];

Future<List<Users>> getUsers() async {
  final response = await client
      .get("https://dummyjson.com/users/?select=firstName,lastName,address");
  if (response.statusCode == 200) {
    return user = List<Users>.from(
      (response.data["users"]).map(
        (json) => Users.fromJson(json),
      ),
    );
  } else {
    throw Exception("Veriler Getirilemedi");
  }
}
