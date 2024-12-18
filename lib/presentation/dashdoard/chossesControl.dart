import 'package:asec_application/presentation/dashdoard/show_news.dart';
import 'package:asec_application/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../bloc/news/news_cubit.dart';
import 'make_news.dart';

class NewChooseControl extends StatelessWidget {
  const NewChooseControl({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
  listener: (context, state) {},
  builder: (context, state) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [


            const Image(image: AssetImage("assets/images/map.png")),

            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: (){
                    navigateTo(context, NewsControlPage());
                  },
                  child: Container(
                      width: MediaQuery.of(context).size.width*.4,
                      height: MediaQuery.of(context).size.height*.15,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: Colors.grey[200]
                      ),
                      child: const Center(child: Text("Create News",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20),))),
                ),

                SizedBox(width: MediaQuery.of(context).size.width*.05),

                GestureDetector(
                  onTap: (){
                    navigateTo(context, const ShowNewsControl());
                    NewsCubit.get(context).newsModel;
                  },
                  child: Container(
                      width: MediaQuery.of(context).size.width*.4,
                      height: MediaQuery.of(context).size.height*.15,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: Colors.grey[200]
                      ),
                      child: const Center(child: Text("Show News",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20),))),
                ),
              ],
            )

        ],
        ),
      ),
    );
  },
);
  }
}
