import 'package:flutter/material.dart';
import 'package:garden/screen/add_plants_page.dart';
import 'package:provider/provider.dart';

import '../provider/provider_class.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomePageState();
  }
}
class HomePageState extends State<HomePage>{
  final searchFilter = TextEditingController();
  final enabledBorder =  const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(20),),
    borderSide: BorderSide(color: Colors.black ),
  );

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ListProvider>(context);
    final word = provider.words;
    // TODO: implement build
    return Scaffold(
      body:  SafeArea(
        child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20,),
               const Align(
                 alignment: Alignment.topCenter,
                 child: Text("Garden", style:  TextStyle(
                   fontSize: 30,
                   color: Colors.black,
                   fontWeight: FontWeight.bold
                 ),
                 ),
               ),
                const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextFormField(
                    cursorColor: Colors.black45,
                    style: const TextStyle(
                        fontSize: 19,
                        color: Colors.black
                    ),
                    controller: searchFilter,
                      maxLines: 1,
                      minLines: 1,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: (){
                            searchFilter.clear();
                          },
                          icon: Icon(Icons.clear , color: Colors.black,),
                        ),
                        hintText: 'Search Plants',
                        enabledBorder: enabledBorder,
                        border: enabledBorder,
                        focusedBorder: enabledBorder,
                        labelStyle:const TextStyle(
                            fontSize: 17,
                            color: Colors.black54
                        ),
                      ),
                    onChanged: (String value){
                      setState(() {
                      });
                    },
                  ),
                ),
                Expanded(
                    child:SizedBox(
                      height: 300,
                      child: ListView.builder(
                            itemCount: word.length,
                            itemBuilder: (context, index) {
                             if(searchFilter.text.isEmpty) {
                               return ListTile(
                                 title: Text(word[index]),
                               );
                            }
                             else if(word[index].toString().toLowerCase().contains(searchFilter.text.toLowerCase().toString())){
                               return ListTile(
                                 title:  Text(word[index]),
                               );
                             }
                             else{
                               return Container();
                             }
                            },
                      ),
                    ),
                ),
              ],
            ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context){
              return AddPlants();
            }),
          );
        },
        backgroundColor: Colors.black38,
        label: const Text("Add Plants" , style: TextStyle(
            color: Colors.white,
          fontSize: 15
        ),
        ),
      ),
    );
  }
}