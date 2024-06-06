// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:todo_app/Components/my_button.dart';

class DialogBox extends StatelessWidget {
  final controller;

  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      backgroundColor: Colors.yellow,
      content: Container(
        height: 120.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // U S E R  I N P U T
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter New Task',
                focusedBorder: InputBorder.none,
              ),
              controller: controller,
            ),

            // B U T T O N S
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // a) save button
                MyButton(
                  text: 'Save',
                  onPressed: onSave,
                ),
                // b) cancel button
                MyButton(
                  text: 'Cancel',
                  onPressed: onCancel,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
