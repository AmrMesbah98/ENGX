import 'package:asec_application/Dashbord.dart';
import 'package:asec_application/bloc/order/order_cubit.dart';
import 'package:asec_application/shared/components/components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderCubit, OrderState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "Order Page",
              style: TextStyle(color: Colors.black54),
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black54),
            elevation: 0,
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                height: 900,
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: OrderCubit.get(context).makeOrder.length,
                    itemBuilder: (context, index) {
                      return Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(20)),
                              child: Card(
                                elevation: 6,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(Icons.person,
                                              color: Colors.grey),
                                          Text(OrderCubit.get(context)
                                              .makeOrder[index]
                                              .name!),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Icon(Icons.email,
                                              color: Colors.grey),
                                          Text(OrderCubit.get(context)
                                              .makeOrder[index]
                                              .email!),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.location_on,
                                            color: Colors.grey,
                                          ),
                                          Text(OrderCubit.get(context)
                                              .makeOrder[index]
                                              .phone!),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Icon(Icons.phone_android,
                                              color: Colors.grey),
                                          Text(OrderCubit.get(context)
                                              .makeOrder[index]
                                              .address!),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Icon(Icons.camera,
                                              color: Colors.grey),
                                          Text(OrderCubit.get(context)
                                              .makeOrder[index]
                                              .type!),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                              Icons.insert_page_break_sharp,
                                              color: Colors.grey),
                                          Expanded(
                                              child: Text(
                                                  OrderCubit.get(context)
                                                      .makeOrder[index]
                                                      .order!)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 23),
                            child: ElevatedButton(
                                style: const ButtonStyle(
                                    backgroundColor:
                                        MaterialStatePropertyAll(Colors.red)),
                                onPressed: () {
                                  FirebaseFirestore.instance
                                      .collection("OrderUser")
                                      .doc(OrderCubit.get(context)
                                          .makeOrder[index]
                                          .id!)
                                      .delete();
                                  OrderCubit.get(context).getOrder();
                                  navigateTo(context, DashBorad());
                                },
                                child: const Text("Delete")),
                          ),
                        ],
                      );
                    }),
              ),
            ),
          ),
        );
      },
    );
  }
}
