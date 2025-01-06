import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/utils/constants.dart';
import 'package:task_app/view_models/task_view_model.dart';

void showModalBottomSheetCreateTask(BuildContext context) {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final taskViewModel = Provider.of<TaskViewModel>(context, listen: false);
  TextEditingController controllerTaskTitle = TextEditingController();
  TextEditingController controllerDescription = TextEditingController();

  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      ),
    ),
    elevation: 10,
    backgroundColor: Colors.white,
    builder: (BuildContext context) {
      return Container(
        height: 400,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0, left: 12),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextFormField(
                  controller: controllerTaskTitle,
                  decoration: InputDecoration(
                      prefixIcon: Image.asset("assets/images/unchecked.png"),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      label: const Text("What in my mind?"),
                      hintStyle: const TextStyle(color: Consts.colorSlateBlue),
                      hintText: 'type the task title'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "title is required";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: controllerDescription,
                  decoration: InputDecoration(
                      prefixIcon: Image.asset("assets/images/pencil.png"),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      label: const Text("add a note..."),
                      hintStyle: const TextStyle(color: Consts.colorSlateBlue),
                      hintText: 'type the task description'),
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "note is required";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Container()),
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          elevation: 0,
                        ),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            taskViewModel.addTask(controllerTaskTitle.text,
                                controllerDescription.text);
                            Navigator.pop(context);
                          }
                        },
                        child: const Text('Create',
                            style: TextStyle(
                              color: Consts.colorBlue,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
