import 'package:flutter/material.dart';
import 'package:task_app/views/widgets/custom_app_bar_widget.dart';
import 'package:task_app/views/widgets/modal_widget.dart';
import 'package:task_app/views/widgets/task_done_widget.dart';
import 'package:task_app/views/widgets/task_search_widget.dart';
import 'package:task_app/views/widgets/todo_task_widget.dart';

import '../utils/constants.dart';

class TaskView extends StatefulWidget {
  const TaskView({super.key});

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color colorIcon(int idx) {
      return currentIndex == idx ? Consts.colorBlue : Consts.colorSlateBlue;
    }

    return Scaffold(
      appBar: const CustomAppBarWidget(),
      bottomNavigationBar: TabBar(
        onTap: (idx) {
          setState(() {
            currentIndex = idx;
          });

          if (idx == 1) {
            showModalBottomSheetCreateTask(context);
            _tabController.index = 0;
            currentIndex = 0;
          }
        },
        unselectedLabelColor: Consts.colorSlateBlue,
        indicator: const BoxDecoration(),
        labelColor: Consts.colorBlue,
        controller: _tabController,
        tabs: [
          Tab(
              text: 'Todo',
              icon:
                  Image.asset("assets/images/vector.png", color: colorIcon(0))),
          Tab(text: 'Create', icon: Image.asset("assets/images/plus.png")),
          Tab(
              text: 'Search',
              icon:
                  Image.asset("assets/images/search.png", color: colorIcon(2))),
          Tab(
              text: 'Done',
              icon: Image.asset("assets/images/checked.png",
                  color: colorIcon(3))),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          TodoTaskWidget(),
          TodoTaskWidget(),
          TaskSearchWidget(),
          TaskDoneWidget(),
        ],
      ),
    );
  }
}
