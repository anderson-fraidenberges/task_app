import 'package:flutter/material.dart';
import 'package:task_app/models/task.dart';
import 'package:task_app/utils/constants.dart';

class TaskListItemWidget extends StatefulWidget {
  final Task task;  
  final Function() updateFunction;

  const TaskListItemWidget({super.key, required this.task, required this.updateFunction});

  @override
    State<TaskListItemWidget> createState() => _TaskListItemWidgetState();
}

class _TaskListItemWidgetState extends State<TaskListItemWidget> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
     
          elevation: 4, 
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),   
      borderOnForeground: true,   
      child: SizedBox(width: 338,
        child: Container(
          decoration: BoxDecoration(
                color: Consts.colorPaleWhite,
                border: Border.all(
                  color: Consts.colorPaleWhite,
                  width: 2.0,      
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
          child: ListTile(
                      
            leading: Checkbox(
              value: widget.task.completed,
              onChanged: (value) async {           
               widget.updateFunction();
              },
            ),
            title: Text(widget.task.title, style: const TextStyle(color:Consts.colorSlatePurple, fontWeight: FontWeight.bold),),
            subtitle: isExpanded && widget.task.description.isNotEmpty
                ? Text(widget.task.description, style: const TextStyle(color:Consts.colorSlateBlue),)
                : null,
            trailing: IconButton(
              icon: Image.asset("assets/images/tabler_dots.png"), onPressed: () {  setState(() {
                  isExpanded = !isExpanded;
                }); },               
              ),              
            ),
          ),
        ),      
    );
  }
}