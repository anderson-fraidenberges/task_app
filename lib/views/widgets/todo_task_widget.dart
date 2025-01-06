import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/enums/task_action_enum.dart';
import 'package:task_app/utils/constants.dart';
import 'package:task_app/view_models/task_view_model.dart';
import 'package:task_app/views/styles.dart';
import 'package:task_app/views/widgets/modal_widget.dart';
import 'package:task_app/views/widgets/task_list_widget.dart';

class TodoTaskWidget extends StatelessWidget {
  
  const TodoTaskWidget({super.key});
  
  @override
  Widget build(BuildContext context) {
    final taskViewModel = Provider.of<TaskViewModel>(context);
    taskViewModel.setTaskActionEnum(TaskActionEnum.todo);

    String subWelcomeMessage() {
      if (taskViewModel.tasks.isNotEmpty) {

        return "You're got ${taskViewModel.tasks.length} tasks to do";
      }

      return "Create tasks to achieve more.";
    } 

   
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 24, top:16),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                    text: 'Welcome, ',
                    style: urbanistText700.copyWith(color: Consts.colorSlatePurple)),
                TextSpan(
                    text: 'John',
                    style: urbanistText700.copyWith(color: Consts.colorBlue)),
              ],
            ),
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(left: 24, top: 12),
            child: Text(subWelcomeMessage(),
                style: urbanistText500.copyWith(color: Consts.colorSlateBlue))),
        const SizedBox(height: 15),
        (taskViewModel.tasks.isEmpty
            ? Center(
                child: Column(
                  children: [
                    Image.asset("assets/images/undraw_no_data.png"),
                    const SizedBox(height: 10),
                    Text(
                        textAlign: TextAlign.start,
                        "You have no task Listed",
                        style:
                            urbanistText500.copyWith(color: Consts.colorSlateBlue)),
                    const SizedBox(height: 30),
                    ElevatedButton.icon(
                      onPressed: () {                        
                         showModalBottomSheetCreateTask(context);
                      },
                      icon: const Icon(
                        Icons.add,
                        color: Consts.colorBlue,
                      ),
                      label: Text(
                        'Create Task',
                        style: urbanistText600.copyWith(color: Consts.colorBlue),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Consts.colorButton,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : const TaskListWidget())
      ],
    );

    //);
  }
}
