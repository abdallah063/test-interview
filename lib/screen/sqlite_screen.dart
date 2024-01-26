import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../controller/sqlite_controller.dart';
import 'package:get/get.dart';

class SqliteScreen extends StatelessWidget {
  SqliteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SqliteController sqliteController = Get.put(SqliteController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('sqlite Screen'),
      ),
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          sqliteController.addTask(context);
        },
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('مهامي',style: TextStyle(fontSize: 24,color: Colors.deepPurple)),
            ),
            Expanded(
              child: Obx(() {
                if (sqliteController.tasks.isEmpty) {
                  return const Center(child: Text('لا يوجد بيانات'));
                }  else {
                  return Directionality(
                    textDirection: TextDirection.rtl,
                    child: ListView.builder(
                      itemCount: sqliteController.tasks.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                          onDismissed: (direction) {
                            sqliteController.delete(sqliteController.tasks[index]);
                          },
                          key: Key('${sqliteController.tasks[index].id}'),
                          child: ListTile(
                            onLongPress: (){
                              sqliteController.updateTask(context,sqliteController.tasks[index],index);

                            },
                            onTap: (){
                            },
                            title: Text(sqliteController.tasks[index].title),
                            // subtitle:Text('${sqliteController.tasks[index].isDone}') ,
                            leading: Checkbox(
                              value: sqliteController.tasks[index].isDone == 1?true:false,
                              onChanged: (v) {
                                sqliteController.onChange(v, index);
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
