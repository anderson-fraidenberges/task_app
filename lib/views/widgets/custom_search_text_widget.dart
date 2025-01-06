import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/utils/constants.dart';
import 'package:task_app/view_models/task_view_model.dart';

class CustomSearchTextWidget extends StatelessWidget {
  const CustomSearchTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final taskViewModel = Provider.of<TaskViewModel>(context);
    final TextEditingController controllerSearch = TextEditingController();

    void onSearch() {
      if (controllerSearch.text.isNotEmpty) {
        taskViewModel.searchTask(controllerSearch.text);
      }
    }

    return SizedBox(
      width: MediaQuery.of(context).size.width * .9,
      child: TextField(
        controller: controllerSearch,
        onSubmitted: (_) => onSearch,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          filled: true,
          fillColor: Consts.colorPaleWhite,
          prefixIcon: IconButton(
              icon: const Icon(Icons.search),
              color: Consts.colorBlue,
              onPressed: onSearch),
          hintText: 'Type title or description',
          hintStyle: const TextStyle(color: Colors.grey),
          suffixIcon: IconButton(
              icon: Image.asset("assets/images/close.png"),
              color: Colors.grey,
              onPressed: () {
                controllerSearch.clear();
              }),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                color: Consts.colorBlue,
                width: 2.0,
              )),
        ),
      ),
    );
  }
}
