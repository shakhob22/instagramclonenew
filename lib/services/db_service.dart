
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagramclone/services/auth_service.dart';
import 'package:instagramclone/services/utils_service.dart';

import '../models/member_model.dart';

class DataService {
  
  static final _firestore = FirebaseFirestore.instance;
  static String folderUser = "Users";
  
  // save user
  static Future storeMember(Member member) async {
    member.uid = AuthService.currentUserId();

    Map<String, String> params = await Utils.deviceParams();

    member.device_id = params["device_id"]!;
    member.device_type = params["device_type"]!;
    member.device_token = params["device_token"]!;

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

  static Future<List<Member>> searchMembers(List keywords) async {
    print(keywords);
    List<Member> members = [];
    String uid = AuthService.currentUserId();


    for (var item in keywords) {
      var querySnapshot = await _firestore.collection(folderUser).where("email", isEqualTo: item).get();

      querySnapshot.docs.forEach((element) {
        Member newMember = Member.fromJson(element.data());
        if (newMember.uid != uid) {
          print(newMember.fullName);
          members.add(newMember);
        }
      });
    }

    return members;
  }

  static Future<List<Member>> loadAllMembers() async {

    List<Member> members = [];

    var docs = await _firestore.collection(folderUser).get();
    for (var doc in docs.docs) {
      Member member = Member.fromJson(doc.data());
      members.add(member);
    }

    return members;

  }
  
}

