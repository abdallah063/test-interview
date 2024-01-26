import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/local_json_model/item_model.dart';
import '../controller/local_json_controller.dart';

class LocalJsonScreen extends StatelessWidget {
  LocalJsonScreen({super.key});

  ServicesController servicesController = Get.put(ServicesController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Local Json Screen'),
      ),
        body: SafeArea(
            child: FutureBuilder(
      future: servicesController.fetchItems(),
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
          final data = snapshot.data ?? <ItemModel>[];

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(data[index].name),
                subtitle: Text(data[index].description),
              );
            },
          );
        }
      },
    )));
  }
}
