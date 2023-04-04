import 'package:flutter/material.dart';
import 'package:mytask/constants/colors.dart';

import 'my_button.dart';

class DialogBox extends StatelessWidget {
  final controller;
  final time;
  VoidCallback onSave;
  VoidCallback onCancel;
  VoidCallback chooseTime;

  DialogBox({
    super.key,
    required this.controller,
    required this.time,
    required this.onSave,
    required this.onCancel,
    required this.chooseTime,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: Container(
        height: 160,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // get user input
            SizedBox(
              height: 50, // Set a fixed height for the SizedBox
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Your task title",
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: chooseTime,
                    icon: Icon(Icons.date_range),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // save button
                MyButton(text: "Save", onPressed: onSave,color: Colors.blueAccent),

                const SizedBox(width: 8),

                // cancel button
                MyButton(text: "Cancel", onPressed: onCancel,color: Colors.red),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
