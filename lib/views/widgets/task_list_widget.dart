import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/view_models/task_view_model.dart';
import 'package:task_app/views/widgets/task_list_item_widget.dart';

class TaskListWidget extends StatefulWidget {
  const TaskListWidget({super.key});

  @override
  State<TaskListWidget> createState() => _TaskListWidgetState();
}

class _TaskListWidgetState extends State<TaskListWidget> {
  late ScrollController _scrollController;
    bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() async {
    final taskViewModel = Provider.of<TaskViewModel>(context, listen: false);

    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent) {
           setState(() {
      _isLoading = true;
    });
       await Future.delayed(const Duration(seconds: 2));

      taskViewModel.incrementPageSize();
       setState(() {
      _isLoading = false;
    });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final taskViewModel = Provider.of<TaskViewModel>(context);

    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        controller: _scrollController,
        itemCount: taskViewModel.tasks.length + 1,
        itemBuilder: (ctx, idx) {
      
           if (idx == taskViewModel.tasks.length) {
                return _isLoading
                    ? const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: Center(child: CircularProgressIndicator()),
                      )
                    : const SizedBox.shrink();
                    
              }
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
