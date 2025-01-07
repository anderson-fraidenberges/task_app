import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hive_test/hive_test.dart';
import 'package:provider/provider.dart';
import 'package:task_app/models/task.dart';
import 'package:task_app/view_models/task_view_model.dart';
import 'package:task_app/views/widgets/task_search_widget.dart';

void main() async {
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
          home: Scaffold(body: TaskSearchWidget()),
        ),
      ),
    );
  }

  group('Task Search Widget', () {
    setUp(() async {
      await setUpTestHive();

      if (!Hive.isAdapterRegistered(1)) {
        Hive.registerAdapter(TaskAdapter());
      }

      await Hive.openBox<Task>('tasks');
      
    });

    tearDown(() async {      
      Hive.deleteFromDisk();
    });

    testWidgets('Task search text', (WidgetTester tester) async {      
      await pumpWidget(tester);

      expect(find.text('No result found.'), findsOneWidget);
    });
  });
}
