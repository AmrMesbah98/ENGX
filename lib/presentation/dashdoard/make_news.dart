import 'package:asec_application/bloc/news/news_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsControlPage extends StatefulWidget {
   NewsControlPage({super.key});

  @override
  State<NewsControlPage> createState() => _NewsControlPageState();
}

class _NewsControlPageState extends State<NewsControlPage> {
  TextEditingController titleController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  TextEditingController dateController = TextEditingController();


  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    dateController.dispose();
    super.dispose();
  }


  clear()
  {
    titleController.clear();
    descriptionController.clear();
    dateController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 15),
            child: Column(

              children: [

                SizedBox(height: MediaQuery.of(context).size.height*.1),

                Image(
                  width: MediaQuery.of(context).size.width*.5,
                  height: MediaQuery.of(context).size.height*.25,
                    fit: BoxFit.fill,
                    image: AssetImage("assets/images/ASEC.png")
                ),



                TextFormField(

                  decoration: const InputDecoration(
                    hintText: "title",

                    isDense: true,
                    border: OutlineInputBorder(),
                    errorBorder: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder()
                  ),
                  cursorColor: Colors.black,
                  controller: titleController,
                  validator: (val){
                    if(val!.isEmpty)
                      {
                        return "Please Enter title";
                      }
                  },
                ),
                SizedBox(height: MediaQuery.of(context).size.height*.05),
                TextFormField(
                  cursorColor: Colors.black,

                  decoration: const InputDecoration(
                      hintText: "Description",


                      isDense: true,
                      border: OutlineInputBorder(),
                      errorBorder: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder()
                  ),
                  controller: descriptionController,
                  validator: (val){
                    if(val!.isEmpty)
                    {
                      return "Please Enter Description";
                    }
                  },
                ),
                SizedBox(height: MediaQuery.of(context).size.height*.05),
                TextFormField(
                  cursorColor: Colors.black,
                  decoration: const InputDecoration(
                      hintText: "Date",

                      isDense: true,
                      border: OutlineInputBorder(),
                      errorBorder: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder()
                  ),
                  controller: dateController,
                  validator: (val){
                    if(val!.isEmpty)
                    {
                      return "Please Enter Date";
                    }
                  },
                ),
                SizedBox(height: MediaQuery.of(context).size.height*.05),
                BlocConsumer<NewsCubit, NewsState>(
  listener: (context, state) {  },


  builder: (context, state) {
    return GestureDetector(
      onTap: (){
        NewsCubit.get(context).setNews(
            title: titleController.text,
            description: descriptionController.text,
            date: dateController.text
        ).then((value) {
          clear();
        });
      },
      child: Container(
                    width: MediaQuery.of(context).size.width*.8,
                    height:  MediaQuery.of(context).size.height*.08,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(24)
                    ),
                    child: const Center(
                      child: Text("Submit",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
                    ),
                  ),
    );
  },
)

              ],
            ),
          ),
        ),
      ),
    );
  }
}
