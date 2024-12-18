import 'package:asec_application/Dashbord.dart';
import 'package:asec_application/bloc/Support/supoort_data_cubit.dart';
import 'package:asec_application/shared/components/components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SupportPageTablet extends StatelessWidget {
  const SupportPageTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SupoortDataCubit, SupoortDataState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(

          body: SafeArea(
            child: SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
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
                          padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*.012,horizontal: MediaQuery.of(context).size.width*.04),
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
          ),
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
