import 'package:asec_application/firebase_services/firestore_service.dart';
import 'package:asec_application/model/order_Model.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../model/orderModel.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit(this.fireStoreService) : super(OrderInitial());

  static OrderCubit get(context) => BlocProvider.of(context);

  final CollectionReference orderCollection =
      FirebaseFirestore.instance.collection('OrderUser');

  List<OrderModel> makeOrder = [];

  FireStoreService fireStoreService;

  Future getOrder() async {
    try{


      emit(OrderLoading());
      await fireStoreService
          .getCollection(collectionReference: orderCollection)
          .then((value) {
        makeOrder = [];

        for (var doc in value.docs) {
          makeOrder.add(OrderModel.fromJson(
              doc as QueryDocumentSnapshot<Map<String, dynamic>>));
        }
      });

      emit(OrderSuccess());
    }
        catch(e){

      print(e);

      emit(OrderError());
        }
  }
}
