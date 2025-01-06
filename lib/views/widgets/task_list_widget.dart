import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/view_models/task_view_model.dart';
import 'package:task_app/views/widgets/task_list_item_widget.dart';

class TaskListWidget extends StatelessWidget {  
  const TaskListWidget({super.key});
  

  @override
  Widget build(BuildContext context) {
    final taskViewModel = Provider.of<TaskViewModel>(context);    

    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: taskViewModel.tasks.length,
        itemBuilder: (ctx, idx) {
          final currentTask = taskViewModel.tasks[idx];

          void updateTaskStatus() {
            taskViewModel.updateTaskStatus(currentTask);
          }

          return TaskListItemWidget(
              task: currentTask, updateFunction: updateTaskStatus);
        },
      ),
    );
  }
}
