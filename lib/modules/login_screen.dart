import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:course_flutter/Cache_Helper.dart';
import 'package:course_flutter/Cubit/ShopLoginCubit.dart';
import 'package:course_flutter/Cubit/ShopLoginStates.dart';
import 'package:course_flutter/end_points.dart';
import 'package:course_flutter/modules/Shop_Layout.dart';
import 'package:course_flutter/modules/on_boarding.dart';
import 'package:course_flutter/modules/shop_register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class loginScreen extends StatefulWidget {
   loginScreen({Key? key}) : super(key: key);

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final  keyForm = GlobalKey<FormState>();
  bool iconVisibility = true;
  bool showPass = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit,ShopLoginState>(
        listener: (context, state) {
          if(state is ShopLoginsuccessState){
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
        builder: (context, state) => Scaffold(
          appBar: AppBar(),
          body: Center(
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
                        "LOGIN",
                        style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10.0,),
                      Text(
                        "Login now to browse our hot offers",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),

                      ),
                      SizedBox(height: 30.0,),
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
                      SizedBox(height: 20.0,),
                      ConditionalBuilder(
                        condition: state is! ShopLoginLoadingState ,
                        fallback:(context) => Center(child: CircularProgressIndicator()),
                        builder: (context) => Container(
                          width: double.infinity,
                          color: Colors.deepOrange,
                          child: MaterialButton(
                              onPressed: (){
                                if(keyForm.currentState!.validate()){
                                  print('login success');
                                  ShopLoginCubit.getObject(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }else{
                                  print("can\'t login now");
                                }
                              },
                              child:Text(
                                "LOGIN",
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
                          Text('Do\'t have an account?'),
                          TextButton(onPressed: (){
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (context)=> ShopRegisterScreen()),
                                    (route) => false);
                          }, child: Text("Register Now")),

                        ],
                      ),
                      TextButton(
                          onPressed: (){
                          cacheHelper.clearDataFromSharedPref(key: 'onBoard').then((value) {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (context) => onBoardingScreen(),)
                                , (route) => false);
                          });
                          },
                          child: Center(
                            child: Text('Show On Board Screen',
                            style: TextStyle(
                              color: Colors.deepOrange,
                              fontSize: 15.0,
                            ),),
                          ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
