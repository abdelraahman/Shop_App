import 'package:first/BMIScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class LoginScreen extends StatefulWidget {

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  final  keyForm = GlobalKey<FormState>();
  bool showPass = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar() ,
      body: Form(
        key: keyForm,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Login',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email Address',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                  validator: (String? value) {
                    if (value != null && value.isEmpty) {
                      return "Email can't be empty";
                    }

                    return null;
                  }
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                controller: passwordController,
                obscureText: showPass,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                      onPressed: (){
                        setState(() {
                          if(showPass?showPass=false:showPass=true);
                        });
                      },
                      icon:showPass?Icon(Icons.visibility):Icon(Icons.visibility_off)),
                ),
                  validator: (String? value) {
                    if (value != null && value.isEmpty) {
                      return "Password can't be empty";
                    }

                    return null;
                  }
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.blue,
                width: double.infinity,
                child: MaterialButton(
                  textColor: Colors.white,
                  onPressed: (){

                    if(keyForm.currentState!.validate()){
                      print(keyForm.currentState!.validate());
                      print(emailController.text);
                      print(passwordController.text);
                      Navigator.push(context,
                      MaterialPageRoute(builder: (context)=> bmiScreen())
                      );

                    }
                    print(keyForm.currentState!.validate());


                  },
                  child: Text('LOGIN'),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Do\'t have an account?'),
                TextButton(onPressed: (){}, child: Text("Register Now")),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
