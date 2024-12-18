import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreService {

  ////////////////////////////////////////////////////////////////////////////////////////////////////////////

  final CollectionReference users =
  FirebaseFirestore.instance.collection('user');

////////////////////////////////////////////////////////////////////////////////////////////////////////////

  final CollectionReference product =
  FirebaseFirestore.instance.collection('product');

  ////////////////////////////////////////////////////////////////////////////////////////////////////////////


  // model ==>>> data
  // uid ==>>> name of doc
  // collectionReference ===>> name of collection


  // set ==> to json (to map)
  Future<void> setDoc( {required Map<String, dynamic> model, required String uId,required CollectionReference collectionReference})
      async {
    return await collectionReference.doc(uId).set(model);
  }


  ////////////////////////////////////////////////////////////////////////////////////////////////////////////
  // add ==> to json (to map)
  Future<DocumentReference> addDoc(
      {required Map<String, dynamic> model,required CollectionReference collectionReference}) async {
    return await collectionReference.add(model);
  }

  ////////////////////////////////////////////////////////////////////////////////////////////////////////////
  // delete ==> none json (from & to )
  Future<void> deleteDoc({required String id,required CollectionReference collectionReference}) async {
    return await collectionReference.doc(id).delete();
  }

  ////////////////////////////////////////////////////////////////////////////////////////////////////////////
  // set ==> to json (to map)
  Future<void> editDoc(
      {required String id, required Map<String, dynamic> model,required CollectionReference collectionReference}) async {
    return await collectionReference.doc(id).update(model);
  }

  ////////////////////////////////////////////////////////////////////////////////////////////////////////////
  // get ==> from json
  Future<DocumentSnapshot> getDoc({required String uId,required CollectionReference collectionReference}) async {
    return await collectionReference.doc(uId).get();
  }

  ////////////////////////////////////////////////////////////////////////////////////////////////////////////

  Stream<DocumentSnapshot> getDocSnapshot(
      {required String uId,
        required CollectionReference collectionReference}) async* {
    yield* collectionReference.doc(uId).snapshots();
  }

  ////////////////////////////////////////////////////////////////////////////////////////////////////////////


  Stream<QuerySnapshot<Object?>> getCollectionSnapshot({required CollectionReference collectionReference}) async* {
    yield* collectionReference.snapshots();
  }

  ////////////////////////////////////////////////////////////////////////////////////////////////////////////

  Future <QuerySnapshot> getCollection({required CollectionReference collectionReference}) async {
    return await collectionReference.get();
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////
