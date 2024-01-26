import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/api_controller.dart';
import '../model/api_model/api_response.dart';

class ApiPostScreen extends StatelessWidget {
  ApiPostScreen({super.key});

  final ApiController apiController = Get.put(ApiController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Api Screen'),
      ),
      body: Center(
          child: FutureBuilder<APIResponse>(
              future: apiController.fetchDataFromAPI(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.data == null) {
                  return const Center(
                    child: Center(child: Text('لا يوجد بيانات')),
                  );
                } else {
                  return Directionality(
                    textDirection: TextDirection.rtl,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Obx(() => Text('name : ${apiController.profileText.value}')),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.posts.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                ListTile(
                                  title: Text('${snapshot.data!.posts[index].title}'),
                                  subtitle: Text('التعليقات ${snapshot.data!.comments.where((c) => c.postId == snapshot.data!.posts[index].id).length}'),
                                  onTap:(){
                                    apiController.showComment(context,snapshot.data!.comments.where((c) => c.postId == snapshot.data!.posts[index].id).toList()) ;
                                  }
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  );
                }
              })
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          apiController.changingName();
        },
        child: Icon(Icons.change_circle_rounded),
      ),
    );
  }
}
