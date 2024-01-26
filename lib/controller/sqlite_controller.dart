import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:test_interview/DB/sqflite.dart';
import 'package:test_interview/model/sqlite_model/task_model.dart';

class SqliteController extends GetxController{
  var tasks = <TaskModel>[].obs;

  DataBasesLocal dataBasesLocal =DataBasesLocal();

  Future<void> insert(  TaskModel taskModel) async {
    final db = await   dataBasesLocal.initializeDB();

    await db.insert(
      'Tasks',
      taskModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<TaskModel>> reads() async {

    final db = await  dataBasesLocal.initializeDB();

    final List<Map<String, dynamic>> queryResult = await db.query('Tasks',);
    tasks.clear();
    tasks.addAll(queryResult.map((e) => TaskModel.fromMap(e)).toList());
    return tasks.toList();
  }

  Future<void> updateDate(TaskModel taskModel) async {
    final db = await dataBasesLocal.initializeDB();

    Map<String, dynamic> taskMap = taskModel.toMap();

    if (db != null) {
      await db.update(
        'Tasks',
        taskMap,
        where: 'id = ?',
        whereArgs: [taskModel.id],
      );
    }
  }

  Future<void> delete(TaskModel taskModel) async {
    final db = await   dataBasesLocal.initializeDB();

    await db.delete(
      'Tasks',
      where: 'id = ?',
      whereArgs: [taskModel.id],
    );
    tasks.remove(taskModel);
  }

 var taskTitle =''.obs;
  addTask(context){
    Get.bottomSheet(
      backgroundColor: Colors.white,
      Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              autofocus: true,
              onChanged: (value) {
                taskTitle.value = value;
              },
            ),

            TextButton(
              onPressed: () async {
              TaskModel task=  TaskModel( title: taskTitle.value, isDone: 0);
               await insert(task);
               tasks.add(task);

               Get.back();

              },
              child: Text('Add Task'),
            ),
          ],
        ),
      ),
    );
  }
  updateTask(context,TaskModel taskModel,index){
    Get.bottomSheet(
      backgroundColor: Colors.white,
      Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              autofocus: true,
              onChanged: (value) {
                taskTitle.value = value;
              },
            ),

            TextButton(
              onPressed: () async {
                TaskModel task=  TaskModel( title: taskTitle.value, isDone:taskModel.isDone );
                await updateDate(task);
                tasks[index]=task;
                Get.back();
              },
              child: Text('update Task'),
            ),
          ],
        ),
      ),
    );
  }

   onChange(bool? value, int index) async {
    print(value);
    TaskModel task=  TaskModel( title: tasks[index].title, isDone:value==false ? 0 : 1 );
    await updateDate(task);
    tasks[index]=task;
  }
@override
  void onInit() {
  reads();
  super.onInit();
  }
}