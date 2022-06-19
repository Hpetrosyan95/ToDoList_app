import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late String _userToDo;
  List todoList = [];

  void initFirebase() {}

  @override
  void initState() {
    super.initState();

    initFirebase();
    todoList.addAll(['item']);
  }

  void _menuOpen() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Menu',
              style: TextStyle(
                fontFamily: "Regular",
              ),
            ),
          ),
          body: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushNamedAndRemoveUntil(
                        context, 'main', (route) => false);
                  },
                  child: const Text(
                    'To Main',
                    style: TextStyle(
                      fontFamily: "Regular",
                    ),
                  )),
            ],
          ));
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text(
          'WorkList',
          style: TextStyle(fontFamily: "Regular"),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.menu_outlined),
            onPressed: _menuOpen,
          ),
        ],
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('items').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: Text(
                  'Empty',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.black54,
                  ),
                ),
              );
            }
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  return Dismissible(
                      key: Key(snapshot.data!.docs[index].id),
                      child: Card(
                        color: Colors.white,
                        child: ListTile(
                          title: Text(
                            snapshot.data!.docs[index].get('item'),
                            style: const TextStyle(fontFamily: "Regular"),
                          ),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.delete_sweep,
                              color: Colors.redAccent,
                            ),
                            onPressed: () {
                              FirebaseFirestore.instance
                                  .collection('items')
                                  .doc(snapshot.data!.docs[index].id)
                                  .delete();
                            },
                          ),
                        ),
                      ),
                      onDismissed: (direction) {
                        FirebaseFirestore.instance
                            .collection('items')
                            .doc(snapshot.data!.docs[index].id)
                            .delete();
                      });
                });
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green[300],
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text(
                    'Add Element',
                    style: TextStyle(fontFamily: "Regular"),
                  ),
                  content: TextField(
                    onChanged: (String value) {
                      _userToDo = value;
                    },
                  ),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection('items')
                              .add({'item': _userToDo});

                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'Add',
                          style: TextStyle(fontFamily: "Regular"),
                        ))
                  ],
                );
              });
        },
        child: const Icon(
          Icons.add_box,
          color: Colors.white,
        ),
      ),
    );
  }
}
