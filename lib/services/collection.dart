import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:lms_app_tugbes/widgets/widget_pop_up.dart';

CollectionReference<Object?> connectToDB(String collection) {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference result = firestore.collection(collection);
  return result;
}

void createClassRoom(
    {String? collection, className, codeClass, lessonName, learningCode}) {
  connectToDB('kelas').add({
    'nama_kelas': className,
    'code_kelas': codeClass,
    'mata_pelajaran': lessonName,
    'code_materi': learningCode,
  });
}

void addTeacher({String? name, codeClass, nip, email}) {
  connectToDB('guru').add({
    'nama': name,
    'nip': nip,
    'code_kelas': [codeClass],
    'email': email,
  });
}

void addStudent({String? nis, nama, email, codeClass}) {
  connectToDB('siswa').add({
    'nis': nis,
    'nama': nama,
    'email': email,
    'code_kelas': [codeClass],
  });
}

void createMateri({String? learningCode}) {
  connectToDB('materi').add({
    'code_materi': learningCode,
    'list_materi': [],
  });
}

Future<void> uploadFile({String? nameFile, required File file}) async {
  Reference storageRef =
      FirebaseStorage.instance.ref().child('files/$nameFile');
  try {
    await storageRef.putFile(file);
  } catch (e) {
    print(e);
  }
}

Future<void> downloadFile({String? fileUrl}) async {
  try {
    final storageRef = FirebaseStorage.instance.ref();
    final file = await storageRef.child("files/$fileUrl").getDownloadURL();
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      customSnackbar("Download success"),
    );
  } catch (e) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      customSnackbar("Failed success"),
    );
  }
}

void updateMateri({String? learningCode, title, dsc, chapter, nameFile}) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference collectionRef = firestore.collection('materi');
  QuerySnapshot querySnapshot =
      await collectionRef.where('code_materi', isEqualTo: learningCode).get();
  try {
    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot docSnapshot = querySnapshot.docs.first;
      String docId = docSnapshot.id;

      List<Map<String, dynamic>> module = [
        {'module': chapter, 'dsc': dsc, 'title': title, 'name_file': nameFile}
      ];
      collectionRef.doc(docId).update({
        'list_materi': FieldValue.arrayUnion(module),
      });
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        customSnackbar("Berhasil ditambahkan"),
      );
    } else {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        customSnackbar("Gagal ditambahkan"),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      customSnackbar(e.toString()),
    );
  }
}

void updateClass({String? collection, codeClass, email}) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference collectionRef = firestore.collection(collection!);
  QuerySnapshot querySnapshot =
      await collectionRef.where('email', isEqualTo: email).get();

  if (querySnapshot.docs.isNotEmpty) {
    DocumentSnapshot docSnapshot = querySnapshot.docs.first;
    String docId = docSnapshot.id;

    collectionRef.doc(docId).update({
      'code_kelas': FieldValue.arrayUnion([codeClass]),
    });
  }
}

Stream<QuerySnapshot<Object?>> searchDocument(
    {String? nameCollection, data, searchQuery}) {
  Stream<QuerySnapshot<Object?>> result = connectToDB('$nameCollection')
      .where('$data', isEqualTo: searchQuery)
      .snapshots();
  return result;
}

Future<DocumentSnapshot?> getUser({String? email, collection}) async {
  QuerySnapshot querySnapshot =
      await connectToDB(collection).where('email', isEqualTo: email).get();
  return querySnapshot.docs[0];
}

Stream<List<Map<String, dynamic>>> getModule({String? learningCode}) {
  return connectToDB('materi')
      .where('code_materi', isEqualTo: learningCode)
      .snapshots()
      .map((querySnapshot) {
    List<Map<String, dynamic>> materi = [];
    if (querySnapshot.docs.isNotEmpty) {
      final listMateri = querySnapshot.docs.first;
      materi = List<Map<String, dynamic>>.from(listMateri.get('list_materi'));
    }
    return materi;
  });
}

Stream<QuerySnapshot<Object?>> getClassStream({String? email, collection}) {
  return connectToDB(collection)
      .where('email', isEqualTo: email)
      .snapshots()
      .asyncMap((teacherData) async {
    if (teacherData.docs.isNotEmpty) {
      final teacherDocSnapshot = teacherData.docs.first;
      final codeKelas = (teacherDocSnapshot.get('code_kelas') as List<dynamic>)
          .cast<String>();

      if (codeKelas.isNotEmpty) {
        QuerySnapshot<Object?> classSnapshot = await connectToDB('kelas')
            .where('code_kelas', whereIn: codeKelas)
            .get();

        return classSnapshot;
      }
    }
    throw Exception('Data not found');
  });
}
