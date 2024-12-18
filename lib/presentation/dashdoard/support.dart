import 'package:asec_application/Dashbord.dart';
import 'package:asec_application/bloc/Support/supoort_data_cubit.dart';
import 'package:asec_application/shared/components/components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/Get_Sponser/get_sponser_cubit.dart';
import 'Tablet/support_tablet.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SupoortDataCubit, SupoortDataState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("support Page",style: TextStyle(color: Colors.black54),),
            centerTitle: true,
            iconTheme: const IconThemeData(color: Colors.black54),
            elevation: 0,
            backgroundColor: Colors.white,
          ),
          body: LayoutBuilder(builder: (context, constrain) {
            if (constrain.maxWidth < 600) {
              return SafeArea(
                child: SizedBox(
                  width: double.infinity,
                  height: 900,
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount:SupoortDataCubit.get(context).model.length,
                      itemBuilder: (context, index) {
                        return Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20)
                                ),
                                child: Card(
                                  elevation: 6,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 12),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(Icons.person),
                                            const SizedBox(width: 5),
                                            Text(SupoortDataCubit.get(context).model[index].name!),
                                          ],
                                        ),
                                        sizePlace(context),
                                        Row(
                                          children: [
                                            const Icon(Icons.location_on),
                                            const SizedBox(width: 5),
                                            Text(SupoortDataCubit.get(context).model[index].type!),
                                          ],
                                        ),
                                        sizePlace(context),
                                        Row(
                                          children: [
                                            const Icon(Icons.email),
                                            const SizedBox(width: 5),
                                            Text(SupoortDataCubit.get(context).model[index].email!),
                                          ],
                                        ),
                                        sizePlace(context),
                                        Row(
                                          children: [
                                            const Icon(Icons.insert_page_break_rounded),

                                            const SizedBox(width: 5),

                                            Expanded(child: Text(SupoortDataCubit.get(context).model[index].reason!)),
                                          ],
                                        ),
                                        sizePlace(context),
                                        Row(
                                          children: [
                                            const Icon(Icons.phone_android),
                                            const SizedBox(width: 5),
                                            Text(SupoortDataCubit.get(context).model[index].phone!),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*.017,horizontal: MediaQuery.of(context).size.width*.08),
                              child: ElevatedButton(
                                  style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.red)),
                                  onPressed: (){

                                    FirebaseFirestore.instance.collection("Support").doc(SupoortDataCubit.get(context).model[index].id).delete();
                                    SupoortDataCubit.get(context).getSupportData();
                                    navigateTo(context, DashBorad());


                                  }, child: const Text("Delete")),
                            )
                          ],
                        );
                      }


                  ),
                ),
              );
            } else if (constrain.maxWidth < 900) {
              return const Center(child: SupportPageTablet());
            } else {
              return const Center(child: Text("Desktop"));
            }
          }),
        );
      },

    );
  }

  sizePlace(BuildContext ctx)
  {
   return Column(
      children: [
   SizedBox(height: MediaQuery.of(ctx).size.height * .01,),
  const Divider(thickness: 1),
      ],
   );
  }
}
