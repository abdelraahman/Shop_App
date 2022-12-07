import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:course_flutter/Cache_Helper.dart';
import 'package:course_flutter/Cubit/ShopRegisterCubit.dart';
import 'package:course_flutter/Cubit/ShopRegisterStates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../end_points.dart';
import 'Shop_Layout.dart';
import 'login_screen.dart';

class ShopRegisterScreen extends StatefulWidget {
  @override
  State<ShopRegisterScreen> createState() => _ShopRegisterScreenState();
}

class _ShopRegisterScreenState extends State<ShopRegisterScreen> {
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();

  final  keyForm = GlobalKey<FormState>();

  bool iconVisibility = true;

  bool showPass = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:Scaffold(
        appBar: AppBar(),
        body: BlocProvider(
          create: (context) => ShopRegCubit(),
          child: BlocConsumer<ShopRegCubit,ShopRegState>(
            listener: (context, state) {
              if(state is ShopRegsuccessState){
                if(state.ShopLoginModelData.status){
                  print(state.ShopLoginModelData.message);
                  print(state.ShopLoginModelData.data.token);
                  cacheHelper.saveDataInSharedPref(key: 'token', value: state.ShopLoginModelData.data.token).then((value){
                    token = state.ShopLoginModelData.data.token;
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) =>  ShopLayoutScreen(),),
                            (route) => false);
                  });



                }else{
                  Fluttertoast.showToast(
                      msg: state.ShopLoginModelData.message,
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 5,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0
                  );
                  print(state.ShopLoginModelData.message);
                }
              }
            },
            builder: (context, state) => buildRegScreen(state),
          ),
        ),
      ),
    );
  }

  Widget buildRegScreen(state)=> Center(
    child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: keyForm,
          child: Column(
            crossAxisAlignment:CrossAxisAlignment.start ,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "REGISTER",
                style: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0,),
              Text(
                "Register now to browse our hot offers",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),

              ),
              SizedBox(height: 30.0,),
              TextFormField(
                keyboardType: TextInputType.name,
                controller: nameController,
                decoration: InputDecoration(
                  label: Text("User Name"),
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                validator: (String? name){
                  if(name != null && name.isEmpty){
                    return "Name Canot Be Empty";
                  }
                  return null;
                },

              ),
              SizedBox(height: 10.0,),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Email Address",
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                validator: (String? email){
                  if(email != null && email.isEmpty){
                    return " Email can't be empty";
                  }
                  return null;
                },

              ),
              SizedBox(height: 10.0,),
              TextFormField(
                keyboardType: TextInputType.visiblePassword,
                controller: passwordController,
                obscureText: iconVisibility?!showPass:showPass,
                decoration: InputDecoration(
                  label: Text("Password"),
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                    onPressed: (){
                      setState(() {
                        iconVisibility = !iconVisibility;
                      });
                    },
                    icon:iconVisibility? Icon(Icons.visibility_off):Icon(Icons.visibility),
                  ),
                  border: OutlineInputBorder(),
                ),
                validator: (String? pass){
                  if(pass != null && pass.isEmpty){
                    return "password is short";
                  }
                  return null;
                },

              ),
              SizedBox(height: 10.0,),
              TextFormField(
                keyboardType: TextInputType.phone,
                controller: phoneController,
                decoration: InputDecoration(
                  labelText: "Phone",
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(),
                ),
                validator: (String? phone){
                  if(phone != null && phone.isEmpty){
                    return " phone can't be empty";
                  }
                  return null;
                },

              ),
              SizedBox(height: 15.0,),
             ConditionalBuilder(
                      condition: state is! ShopRegLoadingState ,
                      fallback:(context) => Center(child: CircularProgressIndicator()),
                      builder: (context) => Container(
                        width: double.infinity,
                        color: Colors.deepOrange,
                        child: MaterialButton(
                            onPressed: (){
                              if(keyForm.currentState!.validate()){
                                ShopRegCubit.getObject(context).userReg(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  phone: phoneController.text,
                                  userName: nameController.text,
                                );
                                print('Register success');
                              }else{
                                print("can\'t Register now");
                              }
                            },
                            child:Text(
                              "Register",
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ) ),
                      ),
                    ),
              SizedBox(width: 10.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(' Have an account?'),
                  TextButton(onPressed: (){
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context)=>loginScreen()),
                            (route) => false);
                  }, child: Text("Login")),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
