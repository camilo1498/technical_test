import 'dart:convert';

import 'package:technical_test/src/data/model/post_model.dart';
import 'package:http/http.dart' as http;

/// api url
const String _url = 'https://jsonplaceholder.typicode.com/posts/';
var client = http.Client();

/// store data after fetching the api
List<PostModel> _posts = [];

/// fetch data
Future<List<PostModel>> fetchPost() async {
  http.Response response = await client.get(Uri.parse(_url));
  try {
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      jsonResponse.map((data) => _posts.add(PostModel.fromJson(data))).toList();
      return _posts;
    } else {
      throw Exception('There was a problem while fetching the data');
    }
  } catch (e) {
    rethrow;
  }
}
