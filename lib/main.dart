import 'dart:io';

import 'package:app_tasks_flutter/pages/todo_list_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

void main() async {
  runApp(const MyApp());

  if (!kIsWeb && Platform.isWindows) {
    doWhenWindowReady(() {
      const initialSize = Size(495, 730); //495 × 730 731 × 883
      appWindow.minSize = initialSize;
      appWindow.size = initialSize;
      appWindow.maxSize = const Size(730, 890);
      appWindow.alignment = Alignment.center;
      appWindow.title = 'Task App';
      appWindow.show();
    });
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Stack(
        children: [
          const TodoListPage(),
          if (!kIsWeb && Platform.isWindows)
            Column(
              children: [
                WindowTitleBarBox(
                  child: Row(
                    children: [
                      Expanded(child: MoveWindow()),
                      const WindowButtons(),
                    ],
                  ),
                )
              ],
            ),
        ],
      ),
    );
  }
}

var buttonColors = WindowButtonColors(
  mouseOver: const Color(0xFF00D7F3),
  mouseDown: const Color(0xFFDE318D),
);

class WindowButtons extends StatelessWidget {
  const WindowButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      MinimizeWindowButton(colors: buttonColors),
      CloseWindowButton(),
    ]);
  }
}
