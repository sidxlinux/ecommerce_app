
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{

  static const NUMBER ='number'; //to void any types
  static const ID = 'id';

  String _number;
  String _id;

  //getter

  String get number => _number;
  String get id => _id;

  UserModel.formSnapshot(DocumentSnapshot snapshot){
    _number = snapshot.data()[NUMBER];
    _id = snapshot.data()[ID];
  }
}