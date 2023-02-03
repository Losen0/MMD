class todoTask {
  final int id;
  final String title;
  final String discription;
  final int complete;
  static const String titleString = "title";
  static const String discriptionString = "discription";
  static const String completeString = "complete";
  static const String idString = "id";
  todoTask(
      {required this.id,
      required this.title,
      required this.discription,
      required this.complete});
  factory todoTask.fromMap(Map<String, dynamic> json) => todoTask(
        id: json[idString],
        title: json[titleString],
        discription: json[discriptionString],
        complete: json[completeString],
      );

  Map<String, dynamic> toMap() {
    return {
      idString: id,
      titleString: title,
      discriptionString: discription,
      completeString: complete,
    };
  }
}
