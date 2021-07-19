import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoey_flutter/constants.dart';
import 'package:todoey_flutter/models/todo.dart';
import 'package:todoey_flutter/widgets/add_button.dart';
// ignore: must_be_immutable
class Todoey extends StatelessWidget {
  Todoey({Key? key}) : super(key: key);
  final TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ignore: sized_box_for_whitespace
                  Container(
                    width: MediaQuery.of(context).size.width / 5,
                    height: MediaQuery.of(context).size.height / 5,
                    decoration: const BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    child: const Center(
                        child: Icon(
                      Icons.list,
                      size: 40,
                    )),
                  ),
                  sizedSpacing,
                  const Text(
                    'Todoey',
                    style: kLargeText,
                  ),

                  const Text(
                    '12 Tasks',
                    style: kSmallWhiteText,
                  )
                ],
              ),
            ),
            sizedSpacing,
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white, borderRadius: kradiusSheet),
                padding: const EdgeInsets.all(20),
                child: Consumer(
                  builder: (context, watch, child) {
                    final listNotifier = watch(listProvider);
                    return ListView.builder(
                      itemCount: listNotifier.tasks.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onLongPress: () =>  listNotifier.deleteTask(index),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(listNotifier.tasks[index].taskName,
                                  style: TextStyle(
                                      decoration:
                                          listNotifier.tasks[index].isCompleted
                                              ? TextDecoration.lineThrough
                                              : TextDecoration.none)),
                              Checkbox(
                                  value: listNotifier.tasks[index].isCompleted,
                                  onChanged: (value) {
                                    listNotifier.checkCompleted(index);
                                  })
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              shape: const RoundedRectangleBorder(borderRadius: kradiusSheet),
              builder: (context) {
                return Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      sizedSpacing,
                      const Text('Add Task', style: kmiddleText),
                      Expanded(
                          child: TextField(
                        controller: _textEditingController,
                        cursorColor: Colors.blue,
                      )),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            if (_textEditingController.text.isEmpty) {
                              return;
                            }
                            Task task = Task(taskName: _textEditingController.text);
                            context.read(listProvider).addTask(task);
                            _textEditingController.clear();
                          },
                          child: const AddButton()),
                      const Spacer()
                    ],
                  ),
                );
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

