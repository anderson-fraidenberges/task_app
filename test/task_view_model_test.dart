import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_test/hive_test.dart';
import 'package:task_app/models/task.dart';
import 'package:task_app/view_models/task_view_model.dart';

class MockTaskViewModel extends TaskViewModel {
  @override
  String generateNewGuid() {
    return "1419d8e2-807a-4a48-8f94-68567694fdd3";
  }
}

void main() async {
  late Box<Task> mockBox;
  late MockTaskViewModel taskViewModel;

  setUp(() async {
    await setUpTestHive();
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(TaskAdapter());
    }
    mockBox = await Hive.openBox<Task>('tasks');
    taskViewModel = MockTaskViewModel();
  });

  tearDown(() async {
    await mockBox.close();
    Hive.deleteFromDisk();
  });

  group('TaskViewModel Tests', () {
    test('should add a task successfully', () async {
      const title = "Test Task";
      const description = "This is a test task.";

      await taskViewModel.addTask(title, description);

      expect(taskViewModel.tasks.length, 1);
      final task = taskViewModel.tasks.first;

      expect(task.id, taskViewModel.generateNewGuid());
      expect(task.title, title);
      expect(task.description, description);
      expect(task.completed, false);
    });

    test('should update a task status successfully', () async {
      const title = "Task to Update";
      const description = "Update the completed status.";

      await taskViewModel.addTask(title, description);
      final task = taskViewModel.tasks.first;

      await taskViewModel.updateTaskStatus(task);

      expect(taskViewModel.tasks.first.completed, true);
    });

    test('should search tasks successfully', () async {
      await taskViewModel.addTask("Another Task", "Another description");

      taskViewModel.searchTask("Another");

      expect(taskViewModel.length, 1);
      expect(taskViewModel.tasks.first.title, "Another Task");
    });

    test('should remove a task successfully', () async {
      await taskViewModel.addTask(
          "Task to Remove", "This task will be removed.");
      final task = taskViewModel.tasks.first;

      await taskViewModel.removeTask(task);

      expect(taskViewModel.tasks.isEmpty, true);
    });

    test('should remove all completed tasks successfully', () async {
      await taskViewModel.addTask("Incomplete Task", "This task is not done.");

      final completedTask = taskViewModel.tasks.first;
      await taskViewModel.updateTaskStatus(completedTask);
      await taskViewModel.removeAllTask();

      expect(taskViewModel.tasks.isEmpty, true);
    });
  });
}
