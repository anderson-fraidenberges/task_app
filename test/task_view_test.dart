import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hive_test/hive_test.dart';
import 'package:provider/provider.dart';
import 'package:task_app/models/task.dart';
import 'package:task_app/view_models/task_view_model.dart';
import 'package:task_app/views/task_view.dart';
import 'package:task_app/views/widgets/task_done_widget.dart';
import 'package:task_app/views/widgets/task_search_widget.dart';
import 'package:task_app/views/widgets/todo_task_widget.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;

  Future<void> pumpWidget(WidgetTester tester) {
    return tester.pumpWidget(
      MultiProvider(
        providers: [
          Provider<TaskViewModel>(
            create: (_) => TaskViewModel(),
          ),
        ],
        child: const MaterialApp(
          home: TaskView(),
        ),
      ),
    );
  }

  group('TaskView', () {
    setUp(() async {      
      await setUpTestHive();

      if (!Hive.isAdapterRegistered(1)) {
        Hive.registerAdapter(TaskAdapter());
      }

      await Hive.openBox<Task>('tasks');
    });

    tearDown(() async {
      await Hive.close();
    });

    testWidgets('TaskView has four tabs and changes content on tap',
        (WidgetTester tester) async {

      await pumpWidget(tester);

      expect(find.text('Todo'), findsOneWidget);

      expect(find.text('Create'), findsOneWidget);

      expect(find.text('Search'), findsOneWidget);

      expect(find.text('Done'), findsOneWidget);
    });

    testWidgets('TaskView tab todo content on tap',
        (WidgetTester tester) async {
      await pumpWidget(tester);
      await tester.tap(find.text('Todo'));
      await tester.pumpAndSettle();
      
      expect(find.byType(TodoTaskWidget), findsOneWidget);
    });

    testWidgets('TaskView tab search content on tap',
        (WidgetTester tester) async {
      await pumpWidget(tester);
      await tester.tap(find.text('Search'));
      await tester.pumpAndSettle();

      expect(find.byType(TaskSearchWidget), findsOneWidget);
    });

    testWidgets('TaskView tab done content on tap',
        (WidgetTester tester) async {
      await pumpWidget(tester);
      await tester.tap(find.text('Done'));
      await tester.pumpAndSettle();

      expect(find.byType(TaskDoneWidget), findsOneWidget);
    });
  });
}
