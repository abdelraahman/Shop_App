import 'package:flutter/material.dart';

import '../constant.dart';

class addTasksScreen extends StatefulWidget {

  @override
  State<addTasksScreen> createState() => _addTasksScreenState();
}

class _addTasksScreenState extends State<addTasksScreen> {
 late int itemDeleted ;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 35.0,
                child: Text(
                  '${tasks[index]["time"]}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: 20.0,),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${tasks[index]['title']}',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${tasks[index]['date']}',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                  onPressed: (){
                    print(database);
                    updateDataFromDatabase('done',tasks[index]['id']).then((value) {
                      print("updated successfully");
                      getDataFromDatabase(database);

                    }).catchError((error){
                      print("hnaaaaak error ${error.toString()}");

                    });

                  },
                  icon: Icon(Icons.done),color: Colors.green),
              IconButton(
                  onPressed: (){
                    print(database);
                    updateDataFromDatabase('done',tasks[index]['id']).then((value) {
                      print("updated successfully");
                      getDataFromDatabase(database);
                    }).catchError((error){
                      print("hnaaaaak error ${error.toString()}");

                    });

                  },
                  icon: Icon(Icons.archive_outlined),color: Colors.blue,),
              IconButton(
                onPressed: (){
                  deleteDataFromDatabase(tasks[index]['id']);
                  setState(() {
                    getDataFromDatabase(database).then((value) {
                      allTasks = value;
                      tasks.remove(tasks[index]);
                      print("tasks gdeda b3d delete $tasks");
                      print(archiveTasks);
                      print(doneTasks);
                    });
                  });
                },
                icon: Icon(Icons.delete),color: Colors.red,),
            ],
          ),
        ),
        separatorBuilder: (context, index) => SizedBox(height: 10.0,),
        itemCount: tasks.length,
    );
  }

  Future<int> updateDataFromDatabase(status,id)async
  {
    return await database.rawUpdate(
        'UPDATE tasks SET status = ? where id = ?',
        ['$status',id],
    );
  }

  Future<List<Map>> getDataFromDatabase(database) async{
    return  await database.rawQuery('SELECT * from tasks');

  }

  void deleteDataFromDatabase(id)
  {
     database.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
       getDataFromDatabase(database);
       print("Deleted sucessfully");
     });
  }
}
