import 'package:first/modules/add_tasks.dart';
import 'package:first/modules/archive_tasks.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

import '../constant.dart';
import '../modules/done_tasks.dart';

class layoutScreen extends StatefulWidget {
  const layoutScreen({Key? key}) : super(key: key);

  @override
  State<layoutScreen> createState() => _layoutScreenState();
}

class _layoutScreenState extends State<layoutScreen> {
  int currentIndex = 0;
  bool checkClick = false;
  IconData iconcheck = Icons.edit;
  var titleContrller = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();




  List<Widget> screens = [
    addTasksScreen(),
    doneTasksScreen(),
    archiveTasksScreen(),
  ];
  List<String> titles = [
    'Tasks',
    'Done Tasks',
    'Archive Tasks',
  ];
   var scaffoldKey = GlobalKey<ScaffoldState>();
  final  keyForm = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    createDatabase();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(
          titles[currentIndex],
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()
        {
          /*try{
            var name =  await getName();
            print(name);
            throw('hna fe error');
          }catch(error){
            print(error.toString());

          }*/
          /*getName().then((value) {
            print(value);
          }).catchError((onError){
            print(onError);
          });*/
          if(checkClick){
            if(keyForm.currentState!.validate()){
              insertInToDatabase(titleContrller.text,timeController.text,dateController.text).then(
                      (value) =>
              {
              getDataFromDatabase(database).then((value) {
              Navigator.pop(context);
                checkClick = false;
                setState(() {
                iconcheck = Icons.edit;
                tasks = value;
                });
              }),

              });

            }

          }else{
            scaffoldKey.currentState!.showBottomSheet((context) => Form(
              key: keyForm,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: titleContrller,
                      keyboardType: TextInputType.text,
                      validator: (String? value) {
                        if (value != null && value.isEmpty) {
                          return "title can't be empty";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        label: Text('Title'),
                        prefixIcon: Icon(Icons.title),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20.0,),
                    TextFormField(
                      controller: timeController,
                      keyboardType: TextInputType.text,
                      validator: (String? value) {
                        if (value != null && value.isEmpty) {
                          return "Time can't be empty";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        label: Text('Time'),
                        prefixIcon: Icon(Icons.lock_clock),
                        border: OutlineInputBorder(),
                      ),
                      onTap: (){
                        showTimePicker(context: context, initialTime: TimeOfDay.now()).then((value) {
                          timeController.text = value!.format(context).toString();
                        });
                      },
                    ),
                    SizedBox(height: 20.0,),
                    TextFormField(
                      controller: dateController,
                      keyboardType: TextInputType.text,
                      validator: (String? value) {
                        if (value != null && value.isEmpty) {
                          return "Date can't be empty";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        label: Text('Date'),
                        prefixIcon: Icon(Icons.date_range),
                        border: OutlineInputBorder(),
                      ),
                      onTap: (){
                        showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate:DateTime.parse('2024-12-30'),
                        ).then((value) => {
                          dateController.text = DateFormat.yMMMd().format(value!)
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            ).closed.then((value) {
              checkClick = false;
              setState(() {
                iconcheck = Icons.edit;
              });
            });
            checkClick = true;
            setState(() {
              iconcheck = Icons.add;
            });
          }

         // insertInToDatabase();

        },
        child:Icon(iconcheck),
      ),
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex ,
        onTap: (index){
          setState(() {
            currentIndex = index;
          });

        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.done),
            label: 'Done',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.archive_outlined),
            label: 'Archive',
          ),



        ],
      ),
    );
  }

  Future<String> getName() async
  {
    return 'Abdelrahman Ayman';
  }
  void createDatabase()async
  {
    database  = await openDatabase(
      'todoo.db',
       version: 2,
       onCreate: (database,version){
        print('Database created');
        database.execute('CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT,date TEXT,time TEXT, status TEXT)').then((value){
          print('table created');
        }).catchError((onError){
          print(onError.toString());
        });
       },
       onOpen: (database){
         getDataFromDatabase(database).then((value) {
           allTasks = value;
           allTasks.forEach((element) {
             if(element['status'] == 'Archive'){
               archiveTasks.add(element);
             }else if(element['status'] == 'done'){
               doneTasks.add(element);
             }else{
               tasks.add(element);
             }
           });
           print(tasks);
           print(archiveTasks);
           print(doneTasks);
         });
        print('database opened');
       },
    );
  }
  Future insertInToDatabase(title,time,date) async
  {
   return  await database.transaction((txn) async {
     txn.rawInsert('INSERT INTO tasks(title,date,time,status) VALUES("$title","$date","$time","new")').then((value){
       print("$value inserted successfully");

     }).catchError((onError){
       print(onError.toString());
     });
   } );

  }

  Future<List<Map>> getDataFromDatabase(database) async{
    return  await database.rawQuery('SELECT * from tasks');

  }
  Future<int> updateDataFromDatabase(status,id)async
  {
    return await database.rawUpdate(
        'UPDATE tasks SET status = ?, WHERE id = ?',
        ['$status',id]
    );

  }
}
