import 'package:flutter/material.dart';
import './main_page.dart' as main_page;
import './chatting_page.dart' as chatting_page;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/chatting_page': (context) => chatting_page.ChattingPage(),
      },
      title: 'Flutter',
      theme: ThemeData(),
      debugShowCheckedModeBanner: false,
      home: App(),
    );
  }
}


class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return main_page.MainPage();
  }
}