///Each task in the app is an object of the following Class "ToDoTask"-->
///why you creat anthor floder above task
class ToDoTask {
  final int id;
  final String title;
  final String discription;
  final int complete;
  static const String titleString = "title";
  static const String discriptionString = "discription";
  static const String completeString = "complete";
  static const String idString = "id";

  /// ToDoTask Constructor
  ToDoTask(
      {required this.id,
      required this.title,
      required this.discription,
      required this.complete});

  ///Named Constructor to convert from take map and return an object "TASK"
  factory ToDoTask.fromMap(Map<String, dynamic> json) => ToDoTask(
        id: json[idString],
        title: json[titleString],
        discription: json[discriptionString],
        complete: json[completeString],
      );

  ///Method to convert the objects data into a Map to save it in the Database
  Map<String, dynamic> toMap() {
    return {
      idString: id,
      titleString: title,
      discriptionString: discription,
      completeString: complete,
    };
  }
}
