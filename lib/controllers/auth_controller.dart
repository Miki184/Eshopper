import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:eshop_app/consts/consts.dart';
import 'package:eshop_app/controllers/profile_controller.dart';



class AuthController extends GetxController {
  var isLoading = false.obs;

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  Future<UserCredential?> loginMethod({context}) async {
    UserCredential? userCredential;

    try {
      String hashedPassword = sha256.convert(utf8.encode(passwordController.text)).toString();

      userCredential = await auth.signInWithEmailAndPassword(
          email: emailController.text, password: hashedPassword);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  Future<UserCredential?> signupMethod({email, password, context}) async {
    UserCredential? userCredential;

    try {
      String hashedPassword = sha256.convert(utf8.encode(password)).toString();

      userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: hashedPassword);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  storeUserData({name, password, email}) async {
    DocumentReference store = firestore.collection(usersCollection).doc(currentUser!.uid); //u slucaju da nesto zabode u docs ide currentUser!.uid
    String hashedPassword = sha256.convert(utf8.encode(password)).toString();

    store.set({
      'name': name,
      'password': hashedPassword,
      'email': email,
      'imageUrl': '',
      'id': currentUser!.uid,
      "cart_count": "00",
      "wishlist_count": "00",
      "order_count": "00",
    });
  }

  signoutMethod(context) async {
    try {
      Get.find<ProfileController>().resetController();
      await auth.signOut();
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }
}
