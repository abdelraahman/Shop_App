import 'package:flutter/material.dart';

class bmiResult extends StatelessWidget {
  //const bmiResult({Key? key}) : super(key: key);
  final bool gender;
  final int age;
  final int result;
  String kind = '';
  bmiResult({
    required this.age,
    required this.gender,
    required this.result
});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Result'),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Gender : ${gender? 'MALE' : 'FEMALE'}',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Age : $age',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Result : $result ',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: Colors.lightBlue,

        ),
      ),
    );
  }
}
