class ToDo {
  String? id;
  String? todoText;
  bool isDone;
  DateTime? dateTime;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
    this.dateTime
  });

  static List<ToDo> todoList() {
    return [
      ToDo(id: '100', todoText: 'Visit doctor.', isDone: true, dateTime: DateTime.now()),
      ToDo(id: '101', todoText: 'Call Dr. Mirza for consultation.', isDone: true, dateTime: DateTime.now()),
      ToDo(id: '102', todoText: 'Send message to the manager.', dateTime: DateTime.now()),
    ];
  }
}
