import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Map<String, dynamic>> _todoList = [];
  final TextEditingController _textController = TextEditingController();

  bool isActive = true;
  bool isEdit = false;

  int editId = -1;

  _editNote() {
    _todoList[editId]['title'] = _textController.text;
    editId = -1;
    isEdit = false;
  }

  _deleteItem(int index) {
    _todoList.removeAt(index);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Todo List")),
        body: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  suffixIcon: IconButton(
                      onPressed: () {
                        isEdit
                            ? _editNote()
                            : _todoList.add({
                                "title": _textController.text,
                                "time": DateTime.now(),
                                "isDone": false
                              });
                        _textController.clear();
                        setState(() {});
                      },
                      icon: isEdit
                          ? const Icon(Icons.edit_note_outlined)
                          : const Icon(Icons.archive_rounded))),
              controller: _textController,
              onFieldSubmitted: (String? value) {
                if (value == null) return;
                _todoList.add(
                    {"title": value, "time": DateTime.now(), "isDone": false});
                _textController.clear();
                setState(() {});
              },
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _todoList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  _todoList[index]["title"],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            Checkbox(
                              value: _todoList[index]["isDone"],
                              onChanged: (val) {
                                setState(() {
                                  _todoList[index]["isDone"] = val;
                                });
                              },
                            )
                          ],
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(DateFormat.MMMEd('en_US')
                                        .format(_todoList[index]["time"]) +
                                    " " +
                                    DateFormat.jm('en_US')
                                        .format(_todoList[index]["time"])),
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      overlayColor: MaterialStateProperty.all(
                                          Colors.transparent),
                                      onTap: () {
                                        setState(() {
                                          isEdit = true;
                                          editId = index;
                                          _textController.text =
                                              _todoList[index]["title"];
                                        });
                                      },
                                      child: const Icon(Icons.edit_outlined,
                                          color: Colors.greenAccent),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      overlayColor: MaterialStateProperty.all(
                                          Colors.transparent),
                                      onTap: isActive
                                          ? () {
                                              _deleteItem(index);
                                            }
                                          : null,
                                      child: const Icon(
                                        Icons.delete,
                                        color: Colors.redAccent,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
