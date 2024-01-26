class TaskModel {

   int? id;

  final String title;
   int isDone;


  TaskModel({ required this.title, required this.isDone});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'isDone': isDone,

    };
  }

  TaskModel.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        title=res['title'],
        isDone=res['isDone'];


// Implement toString to make it easier to see information about
// each dog when using the print statement.
  @override
  String toString() {
    return 'Tasks{id: $id,title: $title,isDone: $isDone,}';
  }

}