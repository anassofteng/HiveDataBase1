import 'dart:ffi';

import 'package:flutter/material.dart';

import 'package:hivedatabase/Models/nodes_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'Boxes/Boxes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Hive')),
      ),
      body: ValueListenableBuilder<Box<NotesModel>>(
        valueListenable: Boxes.getData().listenable(),
        builder: (context, box, _) {
          var data = box.values.toList().cast<NotesModel>();
          return ListView.builder(
              itemCount: box.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              data[index].title.toString(),
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Spacer(),
                            Icon(Icons.edit),
                            SizedBox(
                              width: 15,
                            ),
                            InkWell(
                              onTap: () {
                                delete(data[index]);
                              },
                              child: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          data[index].description.toString(),
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                );
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showMyDialog();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void delete(NotesModel notesModel) async {
    await notesModel.delete();
  }

  Future<void> _showMyDialog() async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Add notes'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(
                      hintText: 'Enter title',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                      hintText: 'Enter Description',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    final data = NotesModel(
                        title: titleController.text,
                        description: descriptionController.text);
                    final box = Boxes.getData();
                    box.add(data);
                    data.save();
                    titleController.clear();
                    descriptionController.clear();
                    Navigator.pop(context);
                  },
                  child: Text('Add')),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel')),
            ],
          );
        });
  }
}
















// Column(
// children: [
// FutureBuilder(
// future: Hive.openBox('asif'),
// builder: (context , snapshot){
// return Column(
// children: [
//
// ListTile(
// title: Text(snapshot.data!.get('name').toString()),
// subtitle: Text(snapshot.data!.get('age').toString()),
// trailing: IconButton(
// onPressed: (){
// snapshot.data!.put('name' , 'Anas Arshad');
// snapshot.data!.put('age' , '27.4');
// setState(() {
//
// });
// },
// icon: Icon(Icons.edit),
// ),
// ),
// ],
// );
// }),
// ],
// ),
// floatingActionButton: FloatingActionButton(
// onPressed: ()async{
// var box = await Hive.openBox('asif');
// box.put('name', 'Anas');
// box.put('age', '27');
// print(box.get('name'));
// },
// child: Icon(Icons.add),
// ),