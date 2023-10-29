import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../custom_widgets/user_image.dart';



final _firebase=FirebaseAuth.instance;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {

  var _isLogin=true;
  var _email='';
  var _pass='';
  var _username='';
  final _formKey=GlobalKey<FormState>();
  File? _selectedImage;
  var _isAuthenticating=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Container(
              //   margin: EdgeInsets.all(30),
              //   width: 200,
              //   child: Image.asset('images/bear.png'),
              // ),
              Card(
                margin: EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if(!_isLogin)UserImagePicker(onPicked: (image){
                            _selectedImage=image;
                          },),
                          if(!_isLogin)TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Username',
                            ),
                            enableSuggestions: false,
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            validator: (val){
                              if(val==null||val.trim().isEmpty||val.trim().length<4){
                                return 'Please enter valid username';
                              }
                              else return null;
                            },
                            onSaved: (value){
                              _username=value!;
                            },
                          ),
                          SizedBox(height: 6,),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Email Address',
                            ),
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            validator: (val){
                              if(val==null||val.trim().isEmpty||!val.contains('@')){
                                return 'Please enter a valid email address.';
                              }
                              else return null;
                            },
                            onSaved: (value){
                              _email=value!;
                            },
                          ),
                          SizedBox(height: 6,),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Password',
                            ),
                            obscureText: true,
                            validator: (val){
                              if(val==null||val.trim().length<6){
                                return 'Password must be atleast 6 charecter long.';
                              }
                              else return null;
                            },
                            onSaved: (value){
                              _pass=value!;
                            },
                          ),
                          SizedBox(height: 20,),
                          if(_isAuthenticating)CircularProgressIndicator(),
                          if(!_isAuthenticating)ElevatedButton(
                              onPressed: _submit,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context).colorScheme.primary
                              ),
                              child: Text(_isLogin?'Login':'Signup',style: TextStyle(color: Colors.white),)),
                          if(!_isAuthenticating)TextButton(onPressed: (){
                            setState(() {
                              _isLogin=!_isLogin;
                            });
                          }, child: Text(_isLogin?'Create an account':'Already have an account.'))
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    if(_formKey.currentState!.validate()){
      _formKey.currentState!.save();

      try {
        setState(() {
          _isAuthenticating=true;
        });
        if (_isLogin) {
          final userCredential = await _firebase.signInWithEmailAndPassword(
              email: _email, password: _pass);

        }
        else if(_selectedImage!=null){
          final userCredential =await _firebase.createUserWithEmailAndPassword(
              email: _email, password: _pass);
         final storageRef= FirebaseStorage.instance.ref().child('user_images').child('${userCredential.user!.uid}.jpg');
         await storageRef.putFile(_selectedImage!);
         final imageUrl= await storageRef.getDownloadURL();
         print(imageUrl);

         await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
           'username':_username,
           'email': _email,
           'image_url': imageUrl
         });

        }
      }
         on FirebaseAuthException catch(error){
         print('FIREBASE ERROR ${error}');
         ScaffoldMessenger.of(context).clearSnackBars();
         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Authentication Failed')));
         setState(() {
           _isAuthenticating=false;
         });
       }
      }
    }
  }

