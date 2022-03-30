import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app.dart';
import 'models/todo.dart';

Future<void> main() async {
  await Hive.initFlutter();
  await Hive.openBox<Todo>('todosBox');
  runApp(const MyApp());
}
