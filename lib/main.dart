import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
            apiKey: 'AIzaSyCrGN3TqkWptozu0cexfHUsskBFNmJCIKs',
            projectId: 'firestore-example-c0198',
            storageBucket: 'firestore-example-c0198.appspot.com',
            messagingSenderId: '794593469334',
            appId: '1:794593469334:web:d633cf05479d281537f3b7'),
  );
  runApp(MyHomePage());
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    CollectionReference groceries =
        FirebaseFirestore.instance.collection('groceries');
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: textController,
        ),
      ),
      body: Center(
          child: StreamBuilder(
              stream: groceries.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                return ListView(
                  children: snapshot.data!.docs.map((grocery) {
                    return Center(
                      child: ListTile(
                        title: Text(grocery['name']),
                      ),
                    );
                  }).toList(),
                );
              })),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.save),
          onPressed: () {
            groceries.add({
              'name': textController.text,
            });
          }),
    ));
  }
}
