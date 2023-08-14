// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zeros/db/authentication/firebase_auth_methods.dart';



class UserRequest {
  final quantity;
  final ServeceStatus;
  final WasteType;
  final email;
  final contactnumber;
  final totalPoint;
  final overview;
  final Name;
  final Email;
  final Phone;
  final Address;
  final uid;
  final userName;
  final requestId;
  final datePublished;
  final postURL;
  bool Aactivation;
  String requestCode;


  // creating the constructor here...
  UserRequest({
    required this.contactnumber,
    required this.email,
    required this.uid,
    required this.userName,
    required this.requestId,
    required this.datePublished,
    required this.postURL,
    required this.overview,
    required this.ServeceStatus,
    required this.WasteType,
    required this.quantity,
    required this.totalPoint,
    required this. Name,
    required this. Email,
    required this. Phone,
    required this. Address,
    required this. requestCode,

    this.Aactivation = true,
  });
  // converting it to the map object
  Map<String, dynamic> toJson() => {
    "ServeceStatus": ServeceStatus,
    "WasteType": WasteType,
    "requestId": requestId,
    "Aactivation": Aactivation,
    "contactnumber": contactnumber,
    "useremail": email,
    "quantity": quantity,
    "userName": userName,
    "totalPoint": totalPoint,
    "Name": Name,
    "Email": Email,
    "Phone": Phone,
    "Address": Address,
    "overview": overview,
    "datePublished": datePublished,
    "postURL": postURL,
    "requestCode": requestCode,
    "uid": FirebaseAuth.instance.currentUser!.uid,
  };
  static UserRequest fromSnap(Map<String, dynamic> snapshot) {
    return UserRequest(
      uid: snapshot['uid'],
      ServeceStatus: snapshot['ServeceStatus'],
      Aactivation: snapshot['Aactivation'] ?? true,
      WasteType: snapshot['WasteType'],
      email: snapshot['email'],
      contactnumber: snapshot['contactnumber'],
      userName: snapshot['userName'],
      datePublished: snapshot['datePublished'],
      postURL: snapshot['postURL'],
      requestId: snapshot['requestId'],
      Address: snapshot['Address'],
      Phone: snapshot['Phone'],
      Name: snapshot['Name'],
      overview: snapshot['overview'],
      totalPoint: snapshot['totalPoint'],
      quantity: snapshot['quantity'],
      Email: snapshot['Email'],
      requestCode: snapshot['requestCode'],

    );
  }
}
class UserwasteCollection {
  final ApartmentNumber;
  final Servecedate;
  final Servecetime;
  final email;
  final contactnumber;
  final buildingNumber;
  final street;
  final Name;
  final Email;
  final Phone;
  final uid;
  final userName;
  final requestId;
  final datePublished;
  final postURL;


  // creating the constructor here...
  UserwasteCollection({
    required this.contactnumber,
    required this.email,
    required this.uid,
    required this.userName,
    required this.requestId,
    required this.datePublished,
    required this.postURL,
    required this.ApartmentNumber,
    required this.Servecedate,
    required this.Servecetime,
    required this.buildingNumber,
    required this.street,
    required this. Name,
    required this. Email,
    required this. Phone,
  });
  // converting it to the map object
  Map<String, dynamic> toJson() => {
    "Servecetime": Servecetime,
    "Servecedate": Servecedate,
    "requestId": requestId,
    "contactnumber": contactnumber,
    "useremail": email,
    "street": street,
    "userName": userName,
    "buildingNumber": buildingNumber,
    "Name": Name,
    "Email": Email,
    "Phone": Phone,
    "ApartmentNumber": ApartmentNumber,
    "datePublished": datePublished,
    "postURL": postURL,
    "uid": FirebaseAuth.instance.currentUser!.uid,
  };
  static UserwasteCollection fromSnap(Map<String, dynamic> snapshot) {
    return UserwasteCollection(
      uid: snapshot['uid'],
      Servecetime: snapshot['Servecetime'],
      Servecedate: snapshot['Servecedate'],
      email: snapshot['email'],
      contactnumber: snapshot['contactnumber'],
      userName: snapshot['userName'],
      datePublished: snapshot['datePublished'],
      postURL: snapshot['postURL'],
      requestId: snapshot['requestId'],
      Phone: snapshot['Phone'],
      Name: snapshot['Name'],
      buildingNumber: snapshot['buildingNumber'],
      ApartmentNumber: snapshot['ApartmentNumber'],
      street: snapshot['street'],
      Email: snapshot['Email'],
    );
  }
}
class MessageDataModel {
  MessageDataModel({
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.time,
  });

  final String senderId;
  final String receiverId;
  final String message;
  final Timestamp time;

  MessageDataModel.fromJson(Map<String, dynamic> json)
      : senderId = json['senderId'] ?? '',
        receiverId = json['receiverId'] ?? '',
        message = json['message'] ?? '',
        time = json['time'] as Timestamp? ?? Timestamp.now();

  Map<String, dynamic> toJson() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'message': message,
      'time': time,
    };
  }
}
class Staff {
  final String? docId;
  final String? photoURL;
  final String? department;
  final String? firstname;
  final String? lastname;
  final String? email;
  final String? address;
  final String? uid;
  final String? phone;
  final String? bio;
  final bool? isActive;
  final bool? Active;

  Staff({
    this.docId,
    this.photoURL,
    this.department,
    this.firstname,
    this.lastname,
    this.email,
    this.address,
    this.uid,
    this.phone,
    this.bio,
    this.isActive,
    this.Active,
  });

  Staff.fromJson(Map<String, dynamic> json)
      : firstname = json['firstname'] ?? '',
        lastname = json['lastname'] ?? '',
        address = json['address'] ?? '',
        docId = json['docId'] ?? '',
        department = json['department'] ?? '',
        photoURL = json['photoURL'] ?? '',
        phone = json['phone'] ,
        email = json['email'] ?? '',
        uid = json['uid'] ?? '',
        isActive = json['isActive'],
        Active = json['Active'] ,
        bio = json['bio'] ?? '';

  Map<String, dynamic> toMap() {
    return {
      'firstname': firstname,
      'lastname': lastname,
      'address': address,
      'docId': docId,
      'department': department,
      'photoURL': photoURL,
      'uid': uid,
      'phone': phone,
      'email': email,
      'bio': bio,
      'isActive': isActive,
      'Active': Active,
    };
  }
}




