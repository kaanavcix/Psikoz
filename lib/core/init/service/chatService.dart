// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:psikoz_me/Message/view/model/ChatModel.dart';
import 'package:psikoz_me/Message/view/model/profile.dart';
import 'package:psikoz_me/core/init/service/authController.dart';
import 'package:rxdart/rxdart.dart';

class ChatController extends GetxController {
  @override
  void onInit() {
    super.onInit();

    getProfiles();
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  var authservice = Get.find<AuthService>();

  Future<List<Profile>> getProfiles() async {
    var ref = firestore.collection("Person").orderBy("username");

    var profileRef = await ref.get();

    return profileRef.docs.map((e) => Profile.fromMap(e)).toList();
  }

  Stream<List<ChatModel>> getConversation() {
    var ref = firestore
        .collection("Chat")
        .where("members", arrayContains: authservice.auth.currentUser!.uid);

    var refDocument = getProfiles().asStream();
    var chatStream = ref.snapshots();

    return CombineLatestStream.combine2(chatStream, refDocument,
        (QuerySnapshot conversationSnapshot, List<Profile> profiles) {
      return conversationSnapshot.docs.map((dynamic snapshop) {
        List<String> members = List.from(snapshop.data()["members"]);

        var otherUser = profiles.firstWhere(
          (profile) =>
              profile.docId ==
              members.firstWhere(
                (member) => member != authservice.auth.currentUser!.uid,
              ),
        );
        return ChatModel.fromMap(snapshop, otherUser);
      }).toList();
    });
  }

  Future<ChatModel> getChatData(String conversationId, String memberId) async {
    var profileSnapshot =
        await firestore.collection("Person").doc(memberId).get();

    var profiles = Profile.fromMap(profileSnapshot);

    return ChatModel(
        docId: conversationId,
        name: profiles.username,
        profileImage: profiles.profileImage,
        displayMessage: "");
  }

  startConversation(Profile profile) async {
    var ref = firestore.collection("Chat");

    // ignore: unused_local_variable
    var documentref = await ref.add({
      "displayMessage": "",
      "members": [authservice.auth.currentUser!.uid, profile.docId],
    });

    return ChatModel(
      docId: ref.id,
      name: profile.username,
      profileImage: profile.profileImage,
      displayMessage: "",
    );
  }

  Future<void>? startConversations(Profile profile) {
    return startConversation(profile);
    
   
  }

  Future filterProfiles(String filter) async {
    var ref = firestore
        .collection("Person")
        .where("username", isGreaterThanOrEqualTo: filter);

    var docuref = ref.get();

    return docuref
        .then((value) => value.docs.map((e) => Profile.fromMap(e)).toList());
  }

  Future<ChatModel> getChat(String conversationId, String memberId) async {
    var profileSnapshot =
        await firestore.collection('Person').doc(memberId).get();
    var profile = Profile.fromMap(profileSnapshot);
    return ChatModel(
        docId: conversationId,
        name: profile.username,
        profileImage: profile.profileImage,
        displayMessage: "");
  }
}
