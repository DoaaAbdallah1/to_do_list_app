class TaskModel {
  late String title;

  late bool status;

  TaskModel({
    required this.title,
    required this.status,
  });

  static TaskModel fromMap(Map<String, dynamic> map) {
    return TaskModel(
      title: map['title'],
      status: map['status'],
    
    );
  }
}