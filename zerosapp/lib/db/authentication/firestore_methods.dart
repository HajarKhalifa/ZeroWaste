import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zeros/db/authentication/storage_methods.dart';
import 'package:zeros/models/posts.dart';
import 'package:uuid/uuid.dart';


class FirestoreMethods {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  // for uploading the image
  //for send recycle request
  Future<String> uploadRequest({
    required Uint8List file,
    required String ServeceStatus,
    required String WasteType,
    required final uid,
    required final contactNumber,
    required final email,
    required String username,
    required String quantity,
    required String totalPoint,
    required String overview,
    required String Name,
    required String Email,
    required String Phone,
    required String Address,
    required bool Aactivation,
    required String requestCode,



  }) async {
    String res = "Some error occured";
    try {

      String imageURL = await StorageMethods().uploadImageToStorage(
        "requests",
        file,
        true,
      );

      String requestId = const Uuid().v1();
      UserRequest userPost = UserRequest(
        ServeceStatus: ServeceStatus,
        WasteType: WasteType,
        quantity: quantity,
        uid: uid,
        userName: username,
        contactnumber: contactNumber,
        email: email,
        requestCode: requestCode,

        requestId: requestId,
        datePublished: DateTime.now(),
        postURL: imageURL,

        totalPoint: totalPoint,
        Name: Name,
        overview: overview,
        Email: Email,
        Phone: Phone,
        Address: Address,
      );
      _firebaseFirestore.collection("requests").doc(requestId).set(userPost.toJson());
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> WasteCollection({
    required String Servecedate,
    required String Servecetime,
    required final uid,
    required final contactNumber,
    required final email,
    required String username,
    required String street,
    required String buildingNumber,
    required String ApartmentNumber,
    required String Name,
    required String Email,
    required String Phone,

  }) async {
    String res = "Some error occured";
    try {


      String requestId = const Uuid().v1();
      UserwasteCollection userPost = UserwasteCollection(
        Servecetime: Servecetime,
        Servecedate: Servecedate,
        street: street,
        uid: uid,
        userName: username,
        contactnumber: contactNumber,
        email: email,
        requestId: requestId,
        datePublished: DateTime.now(),
        postURL: null,

        buildingNumber: buildingNumber,
        Name: Name,
        ApartmentNumber: ApartmentNumber,
        Email: Email,
        Phone: Phone,
      );
      _firebaseFirestore.collection("wasteCollection").doc(requestId).set(userPost.toJson());
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }



  // for liking the post
 /* Future<void> likePost({
    required String postId,
    required String uid,
    required List like,
  }) async {
    try {
      if (like.contains(uid)) {
        await _firebaseFirestore.collection("posts").doc(postId).update(
          {
            "likes": FieldValue.arrayRemove([uid]),
          },
        );
      } else {
        await _firebaseFirestore.collection("posts").doc(postId).update(
          {
            "likes": FieldValue.arrayUnion([uid]),
          },
        );
      }
    } catch (e) {
      print(e);
    }
  }
*/
  // deleting the post
  /*Future<String> deletePost({required String postId}) async {
    String res = "Some error occured";
    try {
      await _firebaseFirestore.collection('posts').doc(postId).delete();
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }*/
  Future<String> deleteRequest({required String requestId}) async {
    String res = "Some error occured";
    try {
      await _firebaseFirestore.collection('requests').doc(requestId).delete();
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }


  // editin
  Future<String> updateUserData(
      {required String name,
      required String country,
      required String age,
      required String phoneNo,
      required String address,
      required String cnic,
      required String email,
      required String gender,
      required String lastName,
      required String profilePic,
      required String uid}) async {
    String res = "Some error occured";
    // this is the function that has to edit the username
    try {
      await _firebaseFirestore.collection('users').doc(uid).set({
        'fullName': name,
        "country": country,
        "age": age,
        "phoneNo": phoneNo,
        "address": address,
        "lastName": lastName,
        "email": email,
        "cnic": cnic,
        "profilePic": profilePic,
        "uid": uid,
      });
      res = "success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
