import 'dart:io';

import 'package:app_tasks_flutter/pages/todo_list_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:desktop_window/desktop_window.dart';

void main() async {
  if (!kIsWeb && Platform.isWindows) {
    WidgetsFlutterBinding.ensureInitialized();
    await DesktopWindow.setWindowSize(Size(495, 730));
    await DesktopWindow.setMinWindowSize(Size(495, 730));
    await DesktopWindow.setMaxWindowSize(Size(730, 880));
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TodoListPage(),
    );
  }
}
