import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'firebase_options.dart';
// import 'firebase/firebase_options.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _gmailController=TextEditingController();
    final _passwordController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      resizeToAvoidBottomInset: false,
      appBar:AppBar(
         backgroundColor: Colors.blue,
         title:const Text('Singin page'),
         centerTitle: true,
         
      ),
      body:FutureBuilder(
        future: Firebase.initializeApp(
  ),
       builder: (context,snapshot){
        if(snapshot.connectionState==ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator(),);
        }
        else if(snapshot.hasError){
          return Center(child: Text(snapshot.error.toString()),);
        }
      else  if(snapshot.connectionState==ConnectionState.done){
        return  Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
          
            children: [
            const  SizedBox(height: 200,),
              TextFormField(
                controller: _gmailController,
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                enableSuggestions: false,
                decoration: InputDecoration(
                  hintText: 'Ener gmail',
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(16),    
                  )
                ),
              ),
            const  SizedBox(height: 30),
              TextFormField(
                controller: _passwordController,
                autocorrect: false,
                obscureText: true,
                enableSuggestions: false,
                decoration: InputDecoration(
                  hintText: 'Ener password',
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(16),    
                  )
                ),
              ),
             const SizedBox(height: 30,),
            InkWell(
              onTap: () async{
                  final userCredential=
                await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: _gmailController.text, password: _passwordController.text
                  );
                print(userCredential);
              },
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(16)
                ),
                child:const Center(
                  child: Text('Singin'),
                ),
              ),
            )
            ],
          ),
        ),
      );
        }
      else{
       return  const Center(child: Text('Loading...'),);
        }
      })
      
    );
  }
}