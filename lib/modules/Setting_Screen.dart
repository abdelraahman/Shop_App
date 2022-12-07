import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:course_flutter/Cache_Helper.dart';
import 'package:course_flutter/Cubit/ShopLayoutCubit.dart';
import 'package:course_flutter/Cubit/ShopLayoutStates.dart';
import 'package:course_flutter/modules/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/ShopLoginModel.dart';

class SettingScreen extends StatelessWidget {
  //const SettingScreen({Key? key}) : super(key: key);
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  final  keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit,ShopLayoutStates>(
        builder: (context, state) {
          emailController.text = (ShopLayoutCubit.getObject(context).userData?.data?.email)!;
          nameController.text = (ShopLayoutCubit.getObject(context).userData?.data?.name)!;
          phoneController.text = (ShopLayoutCubit.getObject(context).userData?.data?.phone)!;
          return buildProfile(ShopLayoutCubit.getObject(context).userData,context);},
        listener: (context, state) {},
    );
  }
  Widget buildProfile(ShopLoginModelData? userData,context){
    return Form(
      key: keyForm,
      child: ConditionalBuilder(
        condition: ShopLayoutCubit.getObject(context).userData != null,
        builder: (context) => Padding(
          padding: const EdgeInsets.all(10.0),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Text('PROFILE',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),),
                SizedBox(height: 20.0,),
                Row(
                  children: [
                    Icon(Icons.email),
                    SizedBox(
                      width: 20.0,
                    ),
                    Text('${userData?.data?.email}'),
                  ],
                ),
              /*  TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: "${userData?.data?.email}",
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                  ),
                  validator: (String? email){
                    if(email != null && email.isEmpty){
                      return " Email can't be empty";
                    }
                    return null;
                  },

                ),*/
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    Icon(Icons.person),
                    SizedBox(
                      width: 20.0,
                    ),
                    Text('${userData?.data?.name}'),
                  ],
                ),
                SizedBox(height: 20.0,),
                Row(
                  children: [
                    Icon(Icons.phone),
                    SizedBox(
                      width: 20.0,
                    ),
                    Text('${userData?.data?.phone}'),
                  ],
                ),
                SizedBox(height: 30.0,),
                Container(
                  width: double.infinity,
                  child: MaterialButton(
                      onPressed: (){
                        cacheHelper.clearDataFromSharedPref(key: 'token').then((value) {
                          Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(builder: (context) => loginScreen(),),
                                  (route) => false);
                        });
                      },
                    child: Text('Logout',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),),
                    color: Colors.deepOrange,
                  ),
                ),
              ],
            ),
          ),
        ),
        fallback:(context) =>  Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
