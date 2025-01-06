import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/enums/task_action_enum.dart';
import 'package:task_app/utils/constants.dart';
import 'package:task_app/view_models/task_view_model.dart';
import 'package:task_app/views/styles.dart';
import 'package:task_app/views/widgets/task_done_item_widget.dart';

class TaskDoneWidget extends StatelessWidget {
  const TaskDoneWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final taskViewModel = Provider.of<TaskViewModel>(context);
    taskViewModel.setTaskActionEnum(TaskActionEnum.done);
    return (taskViewModel.tasks.isEmpty)
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              Image.asset("assets/images/undraw_no_data.png"),
              const SizedBox(height: 10),
              Text(
                  textAlign: TextAlign.start,
                  "No done tasks.",
                  style: urbanistText500.copyWith(color: Consts.colorSlateBlue)),
            ],
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Visibility(
                visible: taskViewModel.tasks.length > 0,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Completed Tasks", style: urbanistText700),
                      GestureDetector(
                          onTap: () {
                            taskViewModel.removeAllTask();
                          },
                          child: Text(
                            "Delete all",
                            style:
                                urbanistText600.copyWith(color: Consts.colorFireRed),
                          ))
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: taskViewModel.tasks.length,
                  itemBuilder: (ctx, idx) {
                    final currentTask = taskViewModel.tasks[idx];

                    void deleteTask() {
                      taskViewModel.removeTask(currentTask);
                    }

                    return TaskDoneItemWidget(
                        task: currentTask, deleteFunction: deleteTask);
                  },
                ),
              ),
            ],
          );
  }
}
