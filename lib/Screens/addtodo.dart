import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mytodo/Screens/toast.dart';
import 'package:mytodo/Screens/todo.dart';

class Addtodo extends StatefulWidget {
  const Addtodo({super.key});

  @override
  State<Addtodo> createState() => _AddtodoState();
}

class _AddtodoState extends State<Addtodo> {
  final _titleController=TextEditingController();
    final _desController=TextEditingController();
  void addTodo()async{
    await FirebaseFirestore.instance.collection('users').add({
      "title":_titleController.text,
      "description":_desController.text,
       "timestamp": FieldValue.serverTimestamp(),
    }).then((value){
      TaostError().toast("Added");
      Navigator.push(context, MaterialPageRoute(builder: (_)=>const TodoPage()));
    }).onError((error,stackTrace){
      TaostError().toast(error.toString());
    });
  }
  @override
  void dispose() {
    _titleController.text;
    _desController.text;
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title:const Text("Add new Todo"),
        centerTitle: true,
      ),
      body:Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: "Add title",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8)
                
                )
              ),
            ),
           const SizedBox(height: 30),
            TextField(
              controller: _desController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: "Add descripton",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8)
                )
              ),
            ),
            const SizedBox(height: 30),
            InkWell(
              onTap: () {
                addTodo();
              },
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(16)
                ),
                child:const Center(
                  child: Text('Add task',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                ),
              ),
            )
          ],
        ),
      ) ,
    );
  }
}