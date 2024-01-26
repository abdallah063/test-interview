import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../model/api_model/api_response.dart';
import '../model/api_model/comment_model.dart';
class ApiController extends GetxController {
showComment(context,List<CommentModel> comment) {
  Get.bottomSheet(
  backgroundColor: Colors.white,
  Container(
    width: MediaQuery.of(context).size.width,
    padding: EdgeInsets.all(16),
    child: Column(
      children: [
        Text('Comment',style: TextStyle(fontSize: 24,color: Colors.deepPurple)),
        comment.isEmpty?Center(child: Text('لا يوجد تعليق',style: TextStyle(color: Colors.deepOrange),)) :  Expanded(
          child: ListView.builder(
              itemCount: comment.length,
              itemBuilder:(context, index) =>
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(comment[index].body,
                        style: TextStyle(fontSize: 16,)),
                  ),

            ),
        ),
      ],
    ),
  ),
  );
}
  var posts = [].obs;
  var comments = [].obs;
  var profile = {}.obs;

  var  profileText =''.obs;

  changingName(){
    profileText.value='abdallah hussein';
  }
  void Data() async {

    final apiResponse = await fetchDataFromAPI();
  print(apiResponse.posts.length);
  print(apiResponse.comments.length);

  posts.value = apiResponse.posts;
  comments.value = apiResponse.comments;
  profileText.value =apiResponse.profile.name;
  }


  Future<APIResponse> fetchDataFromAPI() async {

    final response = await http.get(
      Uri.parse("https://my-json-server.typicode.com/typicode/demo/db"),
    );
    if (response.statusCode == 200) {
      print(APIResponse.fromJson(jsonDecode(response.body)));

      return APIResponse.fromJson(jsonDecode(response.body));

    } else {

      throw Exception('Failed to load data');
    }
  }

  @override
  void onInit() {
    Data();
    super.onInit();
  }
}