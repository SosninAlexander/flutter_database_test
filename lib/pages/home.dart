import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: unused_import
import 'package:firebase_core/firebase_core.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late String _userTask;
  List taskList = [];

  // void initFirebase() async {
  //   WidgetsFlutterBinding.ensureInitialized();
  //   await Firebase.initializeApp();
  // }

  @override
  void initState() {
    super.initState();

    // initFirebase();

    taskList.addAll([]);
  }

  void _menuOpen() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            elevation: 0,
            title: const Text('Menu'),
          ),
          body: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: TextButton(
                    style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 20),
                        backgroundColor: Colors.black),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/', (route) => false);
                    },
                    child: const Text('Main')),
              ),
            ],
          ));
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text('Tasks'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: _menuOpen, icon: const Icon(Icons.menu)),
        ],
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('items').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) return const Text('No items');
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  return Dismissible(
                      key: Key(snapshot.data!.docs[index].id),
                      child: Card(
                        child: ListTile(
                          trailing: IconButton(
                            color: Colors.black,
                            icon: const Icon(
                              Icons.delete_outline_outlined,
                            ),
                            onPressed: () {
                              FirebaseFirestore.instance
                                  .collection('items')
                                  .doc(snapshot.data!.docs[index].id)
                                  .delete();
                            },
                          ),
                          title: Text(snapshot.data!.docs[index].get('item')),
                        ),
                      ),
                      onDismissed: (direction) {
                        if (direction == DismissDirection.endToStart) {
                          FirebaseFirestore.instance
                              .collection('items')
                              .doc(snapshot.data!.docs[index].id)
                              .delete();
                        }
                      });
                });
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Add task'),
                  content: TextField(
                    onChanged: (String value) {
                      _userTask = value;
                    },
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        FirebaseFirestore.instance
                            .collection('items')
                            .add({'item': _userTask});

                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'Add',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                );
              });
        },
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }
}
