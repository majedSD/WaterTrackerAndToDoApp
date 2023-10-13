import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoproject/todo.dart';

class UpdateNewTaskModel extends StatefulWidget {
  const UpdateNewTaskModel({super.key,required this.todo, required this.onTodoUpdate});
  final Todo todo;///ja todo ka update kora hobe oi todo ka recived korar jonno
  final Function(String) onTodoUpdate;///Todo ka update kora patanu hobe aitar maddome
  @override
  State<UpdateNewTaskModel> createState() => _UpdateNewTaskModelState();
}

class _UpdateNewTaskModelState extends State<UpdateNewTaskModel> {
  late TextEditingController todoTEController=TextEditingController(text: widget.todo.details);///todo er details ka updated korbo
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Update To Do',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close)),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            maxLines: 4,///Textfield 4 line poriman jaiga nibe
            controller: todoTEController,
            decoration: InputDecoration(
              hintText: 'Enter you new to do',
              enabledBorder: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            width: double.infinity,
            height: 45,
            child: ElevatedButton(onPressed: () {
              widget.onTodoUpdate(todoTEController.text.trim());
              ///controler teka prapto text ka ontodoupdate er maddome return korbe
            }, child: Text('Add')),
          )
        ],
      ),
    );
  }
}
//
