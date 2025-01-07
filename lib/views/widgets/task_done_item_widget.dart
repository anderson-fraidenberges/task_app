import 'package:flutter/material.dart';
import 'package:task_app/models/task.dart';
import 'package:task_app/utils/constants.dart';

class TaskDoneItemWidget extends StatelessWidget {
   final Task task;  
   final Function() deleteFunction;
   const TaskDoneItemWidget({super.key, required this.task, required this.deleteFunction});

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
            leading: Image.asset("assets/images/disabled_checked.png"),
            title: Text(task.title, style: const TextStyle(color:Consts.colorSlatePurple, fontWeight: FontWeight.bold),),
            trailing: IconButton(
              icon: Image.asset("assets/images/delete.png", color: Consts.colorFireRed), onPressed: () {  deleteFunction();  },               
              ),              
            ),
          ),
        ),      
    );
  }
}