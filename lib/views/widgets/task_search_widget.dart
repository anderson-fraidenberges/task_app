import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/enums/task_action_enum.dart';

import 'package:task_app/utils/constants.dart';
import 'package:task_app/view_models/task_view_model.dart';
import 'package:task_app/views/styles.dart';
import 'package:task_app/views/widgets/custom_search_text_widget.dart';
import 'package:task_app/views/widgets/task_list_widget.dart';

class TaskSearchWidget extends StatelessWidget {
  const TaskSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final taskViewModel = Provider.of<TaskViewModel>(context);
    taskViewModel.setTaskActionEnum(TaskActionEnum.search);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const CustomSearchTextWidget(),
          const SizedBox(height: 10),
          (taskViewModel.tasks.isNotEmpty) ? const TaskListWidget() :
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 80),
                Image.asset("assets/images/undraw_no_data.png"),
                const SizedBox(height: 10),
            Text(
                textAlign: TextAlign.start,
                "No result found.",
                style: urbanistText500.copyWith(color: Consts.colorSlateBlue)),
              ],
            ),
          ),          
        ],
      ),
    );
  }
}
