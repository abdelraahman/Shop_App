import 'package:course_flutter/Cubit/ThemeCubit.dart';
import 'package:flutter/material.dart';


class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //themeCubit theme = BlocProvider.of<themeCubit>(context,listen: false);
    themeCubit theme = themeCubit.getObject(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${theme.isDark}',
        ),
        actions: [
          IconButton(onPressed: (){
            theme.changeTheme();
          }, icon:theme.isDark? Icon(Icons.brightness_2_outlined):Icon(Icons.brightness_2)),
        ],
      ),
    );
  }
}
