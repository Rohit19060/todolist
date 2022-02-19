import 'package:flutter/material.dart';

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

  @override
  void initState() {
    super.initState();
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
              decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 30)),
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
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(_todoList[index]["title"]),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(_todoList[index]["time"].toString()),
                          ),
                        ],
                      ),
                      ClipOval(
                        child: Material(
                          child: IconButton(
                            onPressed: isActive
                                ? () {
                                    _deleteItem(index);
                                  }
                                : null,
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.redAccent,
                            ),
                          ),
                        ),
                      ),
                      Checkbox(
                          value: _todoList[index]["isDone"],
                          onChanged: (val) {
                            setState(() {
                              _todoList[index]["isDone"] = val;
                            });
                          })
                    ],
                  ));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
