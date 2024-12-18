import 'package:asec_application/bloc/publicNotification/publicnotification_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'Tablet/show_notification_tablet.dart';


class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notification",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20,color: Colors.black54),),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black54),
        elevation: 0,
      ),
      body:LayoutBuilder(
          builder: (context, constrain){
            if (constrain.maxWidth < 600){
              return BlocConsumer<PublicNotificationCubit, PublicNotificationState>(
                listener: (context, state) {},
                builder: (context, state) {

                  return  RefreshIndicator(
                    onRefresh: () {
                      return PublicNotificationCubit.get(context).getFcm();
                    },
                    child: SafeArea(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        child: Container(
                          decoration: BoxDecoration(

                          ),
                          width: MediaQuery.of(context).size.width,
                          height:MediaQuery.of(context).size.height,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: PublicNotificationCubit.get(context).fcmModelList.length,
                                itemBuilder: (context, index)
                                {

                                  return Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                    child: Container(
                                      decoration: BoxDecoration(

                                        borderRadius: BorderRadius.circular(24),

                                      ),
                                      child: Card(
                                        elevation: 4,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(24)
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                          child: Column(
                                            children: [
                                              //for date
                                              Row(
                                                children: [
                                                  Icon(Icons.event_available,color: Colors.red[200],size: 20,),
                                                  SizedBox(width: MediaQuery.of(context).size.width*.018),
                                                  Text(PublicNotificationCubit.get(context).fcmModelList[index].date!,style:  TextStyle(fontSize: 13.sp , fontWeight: FontWeight.w600 ),)
                                                  //Text('test',style: TextStyle(fontSize: 14.sp),)
                                                ],
                                              ),
                                              //for text
                                              Row(
                                                children: [
                                                  Icon(Icons.notification_add,color: Colors.red[200],size: 20,),
                                                  SizedBox(width: MediaQuery.of(context).size.width*.018),
                                                  Flexible(child: Text(PublicNotificationCubit.get(context).fcmModelList[index].text!,style:  TextStyle(fontSize: 13.sp ),))

                                                ],
                                              ),

                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            else if (constrain.maxWidth < 900) {
              return const Center(child: NotificationPageTablet());
            }

            else {
              return const Center(child: Text("Desktop"));
            }
          }
      )

    );
  }
}
