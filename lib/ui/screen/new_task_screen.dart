import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoproject/ui/screen/add_new_task_screen.dart';
import 'package:todoproject/ui/widgets/profile_summaryCard.dart';
import 'package:todoproject/ui/widgets/summary_card.dart';

import '../widgets/task_item_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ProfileSummaryCard(),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SummeryCard(count: '92', title: 'New'),
                    SummeryCard(count: '92', title: 'In Progress'),
                    SummeryCard(count: '92', title: 'Completed'),
                    SummeryCard(count: '92', title: 'Canceled'),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return TaskItemCard();
                  }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddNewTaskScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
