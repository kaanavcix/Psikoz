// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:psikoz_me/Message/view/message_Detail.dart';
import 'package:psikoz_me/Message/view/model/chatModel.dart';
import 'package:psikoz_me/Message/view/model/profile.dart';
import 'package:psikoz_me/Search/view/model/searchMode.dart';
import 'package:psikoz_me/core/init/service/AuthService.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';

class ChatService extends GetxService {
  var commentId;
  @override
  void onInit() {
    super.onInit();

    getProfiles();
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  var authservice = Get.find<AuthService>();
  RxList<ChatModel> chat = RxList<ChatModel>([]);
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
        return ChatModel.fromMap(snapshop, otherUser, commentId);
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

  Future<ChatModel> startConversation(Profile profile, var Id) async {
    var ref = firestore.collection("Chat");

    // ignore: unused_local_variable
    var documentref = await ref.doc(Id).set({
      "displayMessage": "",
      "members": [authservice.auth.currentUser!.uid, profile.docId],
    });

    return ChatModel(
      docId: Id,
      name: profile.username,
      profileImage: profile.profileImage,
      displayMessage: "",
    );
  }

  Future<void>? startConversations(Profile profile) async {
    var commentId = const Uuid().v1();

    ChatModel ref = await startConversation(profile, commentId);

    var data = Get.to(() =>
        CheatDetail(userId: authservice.auth.currentUser!.uid, chatModel: ref));

    return data;
  }

  filterProfiles(String filter) async {
    var ref = firestore
        .collection("Person")
        .orderBy("username", descending: true)
        .where("username", isLessThanOrEqualTo: filter);

    return ref
        .get()
        .then((value) => value.docs.map((e) => Profile.fromMap(e)).toList());
  }

  ilterProfiles(dynamic Id) async {
    var ref = await firestore.collection("Person").where("uid", isEqualTo: Id);

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
