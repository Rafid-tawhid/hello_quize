import 'package:flutter/material.dart';
import 'package:hello_quize/pages/techer_dashboard_page.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);
  static const String routeName='/welcome';

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 20,),
            Align(
                alignment: Alignment.center,
                child: Text('Welcome',style: TextStyle(fontSize: 22),)),
            SizedBox(height: 10,),
            SizedBox(height: 10,),
            Divider(
              thickness: .1,
              color: Colors.grey,
            ),
            Column(
              children: [
                Card(child: ListTile(title: Text('Student'),leading: Icon(Icons.person),subtitle: Text('Participate in fun classroom activities'),)),
                SizedBox(height: 10,),
                Card(child: ListTile(
                  title: Text('Teacher'),
                  leading: Icon(Icons.person),
                  subtitle: Text('Instruct, engage and assess students'),
                  onTap: (){
                    Navigator.pushNamed(context,TeacherDashboardPage.routeName);
                  },
                )),
                SizedBox(height: 10,),
                Card(child: ListTile(title: Text('Administrator'),leading: Icon(Icons.person),subtitle: Text('Instructional coach, Curriculam/School lead'),)),
                SizedBox(height: 10,),
              ],
            ),

          ],
        ),
      ),
    );



  }

  void _showBottomSheet(BuildContext context) async{


    await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder( // <-- SEE HERE
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (BuildContext context) {

        return Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 20,),
              Align(
                  alignment: Alignment.center,
                  child: Text('Welcome',style: TextStyle(fontSize: 22),)),
              SizedBox(height: 10,),
              SizedBox(height: 10,),
              Divider(
                thickness: .1,
                color: Colors.grey,
              ),
              Column(
                children: [
                  ListTile(title: Text('Student'),leading: Icon(Icons.person),subtitle: Text('Participate in fun classroom activities'),),
                  SizedBox(height: 10,),
                  ListTile(title: Text('Teacher'),leading: Icon(Icons.person),subtitle: Text('Instruct, engage and assess students'),),
                  SizedBox(height: 10,),
                  ListTile(title: Text('Administrator'),leading: Icon(Icons.person),subtitle: Text('Instructional coach, Curriculam/School lead'),),
                  SizedBox(height: 10,),
                ],
              )
            ],
          ),
        );
      },
    );

  }
}
