
import 'package:flutter/material.dart';
import 'package:hello_quize/helper/auth_service.dart';
import 'package:hello_quize/pages/create_quiz_page.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  static const String routeName='/login';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool showPass=true;

  final _formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffe7f1fd),
        body: Center(
          child:
          ListView(
            shrinkWrap: true,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 10,),
                    Text('Hello Quize',style: TextStyle(fontSize: 22,color: Colors.blue),),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text('Email'),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 20),
                          child: TextFormField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              enabledBorder:OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      color: Colors.white
                                  )
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      color: Colors.deepPurple
                                  )
                              ),
                              contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 2,
                                  )
                              ),
                              hintText: 'name@example.com'
                              // Additional decoration options...
                            ),
                            validator: (value){
                              if(value==null||value.isEmpty){
                                return 'Email is required';
                              }
                            },
                          )
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text('Password'),
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 20),
                            child: TextFormField(
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  suffixIcon: IconButton(onPressed: (){
                                    setState(() {
                                      showPass=!showPass;
                                      print(showPass);
                                    });
                                  }, icon: showPass?Icon(Icons.visibility_outlined):
                                  Icon(Icons.visibility_off_outlined)),
                                  enabledBorder:OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                          color: Colors.white
                                      )
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                          color: Colors.deepPurple
                                      )
                                  ),
                                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                        width: 2,
                                      )
                                  ),
                                  hintText: '**************'
                                // Additional decoration options...
                              ),
                              validator: (value){
                                if(value==null||value.isEmpty){
                                  return 'Password is required';
                                }
                              },
                              obscureText: showPass,

                            )
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child:  Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue,
                        ),
                        child: TextButton(
                          onPressed: () {
                            if(_formKey.currentState!.validate()){

                              // AuthSevice.loginUser('admin@gmail.com', '123456').then((value){
                              //   print('THIS VAL IS $value');
                              // });

                             // Navigator.pushNamed(context, CreateQuizPage.routeName);
                            }
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                          child: Text('Login',style: TextStyle(fontSize: 15,color: Colors.white),),
                        ),
                      )
                    ),
                    SizedBox(height: 20,),




                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
