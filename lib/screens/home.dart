import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mytask/widgets/todo_item.dart';

import '../model/todo.dart';
import '../constants/colors.dart';
import '../util/dialog_box.dart';
import '../util/notification.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

DateTime scheduleTime = DateTime.now();

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todosList = ToDo.todoList();
  List<ToDo> _foundToDo = [];

  var _time;
  final _todoController = TextEditingController();

  @override
  void initState() {
    _foundToDo = todosList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
            child: Column(
              children: [
                searchBox(),
                Expanded(
                    child: ListView(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 50, bottom: 15),
                      child: const Text(
                        'Todo List',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w500),
                      ),
                    ),
                    for (ToDo todo in _foundToDo.reversed)
                      ToDoItem(
                          todo: todo,
                          onToDoChanged: _handleToDoChange,
                          onDeleteItem: _deleteToDoItem)
                  ],
                )),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                    child: Container(
                  margin: const EdgeInsets.only(
                    bottom: 20,
                    left: 20,
                    right: 20,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 0.0),
                        blurRadius: 10.0,
                        spreadRadius: 0.0,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: _todoController,
                    decoration: const InputDecoration(
                        hintText: 'Type something...',
                        border: InputBorder.none),
                  ),
                )),
                Container(
                  margin: const EdgeInsets.only(
                    bottom: 20,
                    right: 20,
                  ),
                  child: ElevatedButton(
                    child: Icon(Icons.add_alarm),
                    onPressed: () {
                      _createNewTask();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: tdBlue,
                      minimumSize: Size(60, 60),
                      elevation: 10,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteToDoItem(String id) {
    setState(() {
      todosList.removeWhere((item) => item.id == id);
    });
  }

  void _addToDoItem() {
    NotificationApi().scheduleNotification(
      title: "⌛ It's time!",
      body: _todoController.text,
      scheduledNotificationDateTime: scheduleTime,
    );
    setState(() {
      todosList.add(ToDo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        todoText: _todoController.text,
        dateTime: _time
      ));
    });
    
    print("*****************************************************");
    print("Time is \n");
    print(_time);
    print("*****************************************************");

    Navigator.of(context).pop();
    _todoController.clear();
  }

  void _createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _todoController,
          time: _time,
          onSave: _addToDoItem,
          onCancel: () => Navigator.of(context).pop(),
          chooseTime: () {
            DatePicker.showDateTimePicker(
              context,
              showTitleActions: true,
              onChanged: (date) => {
                scheduleTime = date,
                _time = date
              },
              onConfirm: (date) {},
            );
          },
        );
      },
    );
  }

  Widget searchBox() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: const TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: tdBlack,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 25),
          border: InputBorder.none,
          hintText: 'Search',
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: tdBGColor,
      elevation: 0,
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Container(
            height: 40,
            width: 40,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: SizedBox(
              height: 40,
              width: 40,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset('assets/images/avatar.jpg')),
            )),
        const Icon(
          Icons.calendar_today_outlined,
          color: tdBlack,
          size: 30,
        )
      ]),
    );
  }
}
