import 'package:course_flutter/Cubit/SearchCubit.dart';
import 'package:course_flutter/Cubit/SearchStates.dart';
import 'package:course_flutter/models/SearchModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) => SearchCubit(),
        child: BlocConsumer<SearchCubit,SearchState>(
          listener: (context, state) {

          },
          builder: (context, state) {
            int? len = SearchCubit.getObject(context).searchModel?.data?.data.length;
            return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  child: TextFormField(
                    controller: searchController,
                    onFieldSubmitted: (value) {
                      SearchCubit.getObject(context).Search(value);
                    },
                    decoration: InputDecoration(
                      label: Text('Search'),
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(height: 20.0,),
                if(state is SearchLoadingState)
                  LinearProgressIndicator(),
                if (state is SearchSuccessState)
                Expanded(
                    child:ListView.separated(
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) =>  buildFavItem((SearchCubit.getObject(context).searchModel)!,index,context),
                      separatorBuilder: (context, index) => Container(
                          color: Colors.grey,
                          child: SizedBox(height: 2.0,)),
                      itemCount: len!,
                    )
                ),
              ],
          ),
            );},
          ),
        ),
      );


  }
  Widget buildFavItem(SearchModel searchModel, index,context)=> Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      // color: Colors.white,
      child: Container(
        height: 120.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              //height: 100.0,
              child: Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                      width: 120.0,
                      height: 120.0,
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        '${searchModel.data?.data[index].image}',
                      )
                  ),
                  if(searchModel.data?.data[index].discount != 0)
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text("Discount",
                        style: TextStyle(
                          backgroundColor: Colors.red,
                          color: Colors.white,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(width: 20.0,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${searchModel.data?.data[index].name}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,

                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        '${searchModel.data?.data[index].price}\$',
                        style: TextStyle(
                          color: Colors.deepOrange,
                          fontWeight: FontWeight.bold,
                        ),

                      ),
                      SizedBox(width: 5.0,),
                      if(searchModel.data?.data[index].discount!= 0)
                        Text(
                          '${searchModel.data?.data[index].price}\$',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.lineThrough,
                          ),

                        ),
                      Spacer(),

                    ],
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    ),
  );
}
