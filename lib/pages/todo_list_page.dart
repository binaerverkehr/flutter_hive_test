import 'package:flutter/material.dart';

import '../models/todo.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final TextEditingController _todoTitleController = TextEditingController();

  final List<Todo> todos = [
    Todo(title: "Einkaufen", completed: false),
    Todo(title: "Putzen", completed: false),
    Todo(title: "Aufräumen", completed: true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todos"),
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          final currentTodo = todos[index];

          return InkWell(
            onLongPress: () {
              _todoTitleController.text = currentTodo.title;
              showDialog(
                  context: context,
                  builder: (context) {
                    return SimpleDialog(
                      title: const Text("Update todo"),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            autofocus: true,
                            controller: _todoTitleController,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    todos.remove(currentTodo);
                                  });
                                  _todoTitleController.clear();
                                  Navigator.pop(context);
                                },
                                child: const Text("Delete"),
                                style: ElevatedButton.styleFrom(primary: Colors.red)),
                            ElevatedButton(
                              onPressed: () {
                                //* Get todo index from list
                                final currentTodoIndex = todos.indexOf(currentTodo);

                                setState(() {
                                  //* Exchange todos
                                  todos[currentTodoIndex] = currentTodo.copyWith(title: _todoTitleController.text);
                                });
                                _todoTitleController.clear();
                                Navigator.pop(context);
                              },
                              child: const Text("Update"),
                            ),
                          ],
                        )
                      ],
                    );
                  });
            },
            child: CheckboxListTile(
              title: Text(currentTodo.title),
              value: currentTodo.completed,
              onChanged: (newValue) {
                //* Get current todo's index
                final indexOfCurrentTodo = todos.indexOf(currentTodo);
                //* Exchange todo with new todo
                setState(() {
                  todos[indexOfCurrentTodo] = currentTodo.copyWith(completed: !currentTodo.completed);
                });
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return SimpleDialog(
                  title: const Text("New todo"),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        autofocus: true,
                        controller: _todoTitleController,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              todos.add(Todo(title: _todoTitleController.text, completed: false));
                            });
                            _todoTitleController.clear();
                            Navigator.pop(context);
                          },
                          child: const Text("Add"),
                        ),
                      ],
                    )
                  ],
                );
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
