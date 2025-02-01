import 'package:flutter/material.dart';
import 'package:mask/ui/view/main_page.dart';
import 'package:mask/viewmodel/store_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding().ensureVisualUpdate();
  runApp(ChangeNotifierProvider.value(
    value: StoreViewModel(), child: const MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mask',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainPage(),
    );
  }
}
