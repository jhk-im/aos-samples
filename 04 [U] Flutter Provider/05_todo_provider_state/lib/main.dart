import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:provider/provider.dart';

import 'pages/todos_page.dart';
import 'providers/providers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      /// StateNotifier 적용
      providers: [
        StateNotifierProvider<TodoFilter, TodoFilterState>(
          create: (context) => TodoFilter(),
        ),
        StateNotifierProvider<TodoSearch, TodoSearchState>(
          create: (context) => TodoSearch(),
        ),
        StateNotifierProvider<TodoList, TodoListState>(
          create: (context) => TodoList(),
        ),
        StateNotifierProvider<ActiveTodoCount, ActiveTodoCountState>(
          create: (context) => ActiveTodoCount(),
        ),
        StateNotifierProvider<FilteredTodos, FilteredTodosState>(
          create: (context) => FilteredTodos(),
        ),
      ],
      // providers: [
      //   ChangeNotifierProvider<TodoFilter>(
      //     create: (context) => TodoFilter(),
      //   ),
      //   ChangeNotifierProvider<TodoSearch>(
      //     create: (context) => TodoSearch(),
      //   ),
      //   ChangeNotifierProvider<TodoList>(
      //     create: (context) => TodoList(),
      //   ),
      //   ProxyProvider<TodoList, ActiveTodoCount>(
      //     update: (
      //       BuildContext context,
      //       TodoList todoList,
      //       ActiveTodoCount? _,
      //     ) =>
      //         ActiveTodoCount(todoList: todoList),
      //   ),
      //   ProxyProvider3<TodoFilter, TodoSearch, TodoList, FilteredTodos>(
      //     update: (
      //       BuildContext context,
      //       TodoFilter todoFilter,
      //       TodoSearch todoSearch,
      //       TodoList todoList,
      //       FilteredTodos? _,
      //     ) =>
      //         FilteredTodos(
      //       todoFilter: todoFilter,
      //       todoSearch: todoSearch,
      //       todoList: todoList,
      //     ),
      //   ),
      // ],
      child: MaterialApp(
        title: 'TODOS',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const TodosPage(),
      ),
    );
  }
}
