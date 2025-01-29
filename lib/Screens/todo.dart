import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mytodo/Screens/addtodo.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final _ref=FirebaseFirestore.instance.collection("users");
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title:const Text('All Notes'),
        centerTitle: true
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: _ref.orderBy('timestamp', descending: true).snapshots(),
            builder:(context,snapshot){
               if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            
            if (snapshot.hasError) {
              return 
               Center(child: Text('Error: ${snapshot.error}'));
            }
            
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text('No items found.'));
            }
            final List<DocumentSnapshot> items = snapshot.data!.docs;
              return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context,index){
    //            final doc = items[index]; // Each document
    // final timestamp = doc['timestamp'] as Timestamp; // Access the Firestore timestamp
    // final date = DateTime.fromMillisecondsSinceEpoch(timestamp.millisecondsSinceEpoch); // Convert to DateTime
    // final formattedDate = "${date.day}/${date.month}/${date.year}, ${date.hour}:${date.minute}"; 
          //           final timestamp = items['timestamp'] as Timestamp;
          // final formattedDate = DateFormat('yyyy-MM-dd HH:mm').format(timestamp.toDate());
                return Card(
                  child: ListTile(
                    title:Text(items[index]['title'],style:const TextStyle(fontSize: 20,fontWeight: FontWeight.w600),) ,
                     subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text(items[index]['description'] ?? 'No description'),
                     //  Text(formattedDate, style:const TextStyle(fontSize: 12, color: Colors.grey)), // Timestamp
                      ],
                     ),
                     trailing:Row(
                     mainAxisSize: MainAxisSize.min,
                      children: [
                    IconButton(
                 icon:const Icon(Icons.edit, color: Colors.blue),
                 onPressed: () {
                final doc = items[index]; // Get the document to edit
              showDialog(
                   context: context,
                    builder: (context) {
                    final titleController = TextEditingController(text: doc['title']);
                   final descriptionController = TextEditingController(text: doc['description']);

        return AlertDialog(
          title:const Text('Edit Item'),
          content: Column(
           // mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration:const InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: descriptionController,
                decoration:const InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), // Close dialog
              child:const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                final docId = doc.id; // Get document ID
                await _ref.doc(docId).update({
                  'title': titleController.text,
                  'description': descriptionController.text,
                });
                Navigator.pop(context); // Close dialog
                ScaffoldMessenger.of(context).showSnackBar(
                 const SnackBar(content: Text('Item updated successfully')),
                );
              },
              child:const Text('Save'),
            ),
          ],
        );
      },
    );
  },
),

                  const  SizedBox(width: 8) ,
                    Container(
                      height: 35,
                      width: 40,
                      decoration: BoxDecoration(
                       color: Colors.red,
                       borderRadius: BorderRadius.circular(8)
                      ),
                      child:
                      Center(
                        child: IconButton(
                          icon:const Icon(Icons.delete, color: Colors.white),
                          onPressed: () async {
                            final docId = items[index].id; // Get the document ID
                            await _ref.doc(docId).delete(); // Delete the document from Firestore
                              if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                             const   SnackBar(content: Text('Item deleted successfully')),
                              );
                            }
                          },
                        ),
                      ),

                      ) ,
                   
                  
                      ],
                     )
                  ),
                );
                        
              });
                     
            } ),
          )

        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (_)=>const Addtodo()));
      },
      backgroundColor: Colors.blue,
      child:const Icon(Icons.add),
      ),
    );
  }
}

