
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagramclone/services/auth_service.dart';

import '../models/member_model.dart';

class DataService {
  
  static final _firestore = FirebaseFirestore.instance;
  static String folderUser = "Users";
  
  // save user
  static Future storeMember(Member member) async {
    member.uid = AuthService.currentUserId();
    return _firestore.collection(folderUser).doc(member.uid).set(member.toJson());
  }

  static Future<Member> loadMember() async {
    String uid = AuthService.currentUserId();
    var value = await _firestore.collection(folderUser).doc(uid).get();
    Member member = Member.fromJson(value.data()!);
    return member;
  }

  static Future updateMember(Member member) async {
    String uid = AuthService.currentUserId();
    return _firestore.collection(folderUser).doc(uid).update(member.toJson());
  }
  
}