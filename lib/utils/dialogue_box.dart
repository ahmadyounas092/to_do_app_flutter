import 'package:flutter/material.dart';
import 'package:to_do_application/utils/my_button.dart';

class DialogueBox extends StatefulWidget {
  final TextEditingController inputController;
  VoidCallback onSave;
  VoidCallback onCancel;
  DialogueBox({super.key, required this.inputController, required this.onSave, required this.onCancel});

  @override
  State<DialogueBox> createState() => _DialogueBoxState();
}

class _DialogueBoxState extends State<DialogueBox> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.deepPurple[200],
      content: Container(
        height: 120,
        width: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // get the user input
            TextField(
              controller: widget.inputController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, style: BorderStyle.solid)
                ),
                hintText: "Add new task",
                hintStyle: TextStyle(color: Colors.white)
              ),
            ),
            // two buttons, save and cancl
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // save button
                MyButton(buttonName: "Save", onTap: widget.onSave),
                const SizedBox(width: 10,),
                // cancel button
                MyButton(buttonName: "Cancel", onTap: widget.onCancel),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
