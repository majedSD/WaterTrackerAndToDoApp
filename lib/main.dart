import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todoproject/add_new_task_model.dart';
import 'package:todoproject/todo.dart';
import 'package:todoproject/updat_new_task_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To Do Project',
      /**
       * CRUD--means---Creat,Read,Update,Delet
       */
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Todo> todoList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return AddNewTaskModel(
                onAddTap: (Todo task) {
                  addTodo(task);
                },
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.separated(
        itemCount: todoList.length,
        itemBuilder: (context, index) {
          final Todo todo = todoList[index];
          final String formattedDate =
          DateFormat('hh:mm a dd-MM-yy').format(todo.createdDateTime);
          return ListTile(
            tileColor: todo.status == 'done' ? Colors.grey : null, // ternary
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Actions'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            leading: const Icon(Icons.edit),
                            title: const Text('Update'),
                            onTap: () {
                              Navigator.pop(context);
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return UpdateNewTaskModel(
                                      todo: todo,///todo ka update korar jonno nia jabe
                                      onTodoUpdate: (String todoDetails ) {
                                        Navigator.pop(context);
                                        updateTodo(index,todoDetails);///ekan teka method a value patabe
                                    },

                                    );
                                  });
                            },
                          ),
                          const Divider(
                            height: 0,
                          ),
                          ListTile(
                            leading: const Icon(Icons.delete_outline),
                            title: const Text('Delete'),
                            onTap: () {
                              deletTodo(index);
                            },
                          ),
                        ],
                      ),
                    );
                  });
            },
            onLongPress: () {
              String currentStatus = todo.status == 'pending' ? 'done' : 'pending';
              updateTodoStatus(index, currentStatus);
            },
            leading: CircleAvatar(
              child: Text('${index + 1}'),
            ),
            title: Text(todo.details),
            subtitle: Text(formattedDate),
            trailing: Text(todo.status.toUpperCase()),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(
            height: 4,
          );
        },
      ),
    );
  }

  void addTodo(Todo todo) {
    todoList.add(todo);
    setState(() {});
  }
  void deletTodo(index){
    Navigator.pop(context);
    todoList.removeAt(index);
    setState(() {});
  }
 void updateTodo(int index,String todoDetails){
    todoList[index].details=todoDetails;
    setState(() {});
 }
  void updateTodoStatus(int index,String status){
    todoList[index].status=status;
    setState(() {});
  }
}

