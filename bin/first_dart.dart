import 'package:http/http.dart' as http;
import 'dart:convert';

const String baseUrl = 'https://jsonplaceholder.typicode.com/posts';

Future<void> fetchPosts() async {
  final response = await http.get(Uri.parse(baseUrl));

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    var prettyJson = const JsonEncoder.withIndent('  ').convert(jsonResponse);
    print('GET Request:');
    print(prettyJson);
  } else {
    print('GET Request failed with status: ${response.statusCode}');
  }
}

Future<void> createPost() async {
  final response = await http.post(
    Uri.parse(baseUrl),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'title': 'foo',
      'body': 'bar',
      'userId': 1,
    }),
  );

  if (response.statusCode == 201) {
    var jsonResponse = jsonDecode(response.body);
    var prettyJson = const JsonEncoder.withIndent('  ').convert(jsonResponse);
    print('POST Request:');
    print(prettyJson);
  } else {
    print('POST Request failed with status: ${response.statusCode}');
  }
}

Future<void> updatePost(int id) async {
  final response = await http.put(
    Uri.parse('$baseUrl/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'id': id,
      'title': 'Updated title',
      'body': 'Updated body',
      'userId': 1,
    }),
  );

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    var prettyJson = const JsonEncoder.withIndent('  ').convert(jsonResponse);
    print('PUT Request:');
    print(prettyJson);
  } else {
    print('PUT Request failed with status: ${response.statusCode}');
  }
}

Future<void> deletePost(int id) async {
  final response = await http.delete(Uri.parse('$baseUrl/$id'));

  if (response.statusCode == 200) {
    print('DELETE Request: Successfully deleted post with id $id.');
  } else {
    print('DELETE Request failed with status: ${response.statusCode}');
  }
}

void main() async {
  await fetchPosts();   
  await createPost();    
  await updatePost(1);   
  await deletePost(1);   
}

