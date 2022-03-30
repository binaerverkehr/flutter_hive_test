import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/todo.dart';

class TodoListPage extends StatelessWidget {
  TodoListPage({Key? key}) : super(key: key);

  final TextEditingController _todoTitleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todos"),
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<Todo>('todosBox').listenable(),
        builder: (context, Box<Todo> box, _) {
          if (box.values.isEmpty) {
            return const Center(
              child: Text("No todos"),
            );
          }
          return ListView.builder(
            itemCount: box.values.length,
            itemBuilder: (context, index) {
              final Todo currentTodo = box.getAt(index) as Todo;

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
                                      currentTodo.delete();

                                      _todoTitleController.clear();
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Delete"),
                                    style: ElevatedButton.styleFrom(primary: Colors.red)),
                                ElevatedButton(
                                  onPressed: () {
                                    //* Get todo index from list
                                    box.put(index,
                                        Todo(title: _todoTitleController.text, completed: currentTodo.completed));
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
                    box.put(index, Todo(title: currentTodo.title, completed: !currentTodo.completed));
                  },
                ),
              );
            },
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
                            Box<Todo> todosBox = Hive.box<Todo>("todosBox");
                            todosBox.add(Todo(title: _todoTitleController.text, completed: false));

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
