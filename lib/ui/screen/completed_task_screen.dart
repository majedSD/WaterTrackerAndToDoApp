import 'package:flutter/material.dart';
import 'package:todoproject/ui/widgets/task_item_card.dart';

import '../widgets/profile_summaryCard.dart';

class CompletedTaskScreen extends StatefulWidget {
  CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => CompletedTaskScreenState();
}

class CompletedTaskScreenState extends State<CompletedTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          ProfileSummaryCard(),
          Expanded(
            child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return TaskItemCard();
                }),
          ),
        ],
      ),
    ));
  }
}
