import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:lms_app_tugbes/widgets/widget_pop_up.dart';
import 'package:permission_handler/permission_handler.dart';

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
    'code_tugas': [],
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

void addTask({String? codeTask, fileName, deadline, classCode, dsc}) async {
  connectToDB('tugas').add({
    'dsc': dsc,
    'code_tugas': codeTask,
    'nama_file': fileName,
    'batas_pengumpulan': deadline,
    'code_kelas': classCode,
    'jawaban': {},
  });
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference collectionRef = firestore.collection('kelas');
  QuerySnapshot querySnapshot =
      await collectionRef.where('code_kelas', isEqualTo: classCode).get();
  try {
    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot docSnapshot = querySnapshot.docs.first;
      String docId = docSnapshot.id;

      List<String?> taskCode = [codeTask];
      collectionRef.doc(docId).update({
        'code_tugas': taskCode,
      });
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        customSnackbar(message: "Berhasil ditambahkan", isError: false),
      );
    } else {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        customSnackbar(message: "Gagal ditambahkan"),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      customSnackbar(message: e.toString()),
    );
  }
}

Future<void> uploadFile({String? nameFile, folder, required File file}) async {
  Reference storageRef =
      FirebaseStorage.instance.ref().child('$folder/$nameFile');
  try {
    await storageRef.putFile(file);
  } catch (e) {
    print(e);
  }
}

Future<void> downloadFile({String? fileUrl, folder}) async {
  try {
    final storageRef = FirebaseStorage.instance.ref();
    final downloadUrl =
        await storageRef.child("$folder/$fileUrl").getDownloadURL();
    final taskId = await FileDownloader.downloadFile(
      url: downloadUrl,
      name: fileUrl,
    );
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      customSnackbar(message: "Download success", isError: false),
    );
    var status = await Permission.storage.status;
    if (!status.isDenied || !status.isGranted) {
      await Permission.storage.request();
    }
  } catch (e) {
    print("Error: ${e.toString()}");
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      customSnackbar(message: e.toString()),
    );
  }
}

void updateMateri(
    {String? learningCode, title, dsc, chapter, nameFile, url = ''}) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference collectionRef = firestore.collection('materi');
  QuerySnapshot querySnapshot =
      await collectionRef.where('code_materi', isEqualTo: learningCode).get();
  try {
    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot docSnapshot = querySnapshot.docs.first;
      String docId = docSnapshot.id;

      List<Map<String, dynamic>> module = [
        {
          'module': chapter,
          'dsc': dsc,
          'title': title,
          'name_file': nameFile,
          'url': url
        }
      ];
      collectionRef.doc(docId).update({
        'list_materi': FieldValue.arrayUnion(module),
      });
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        customSnackbar(message: "Berhasil ditambahkan", isError: false),
      );
    } else {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        customSnackbar(message: "Gagal ditambahkan"),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      customSnackbar(message: e.toString()),
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
  try {
    QuerySnapshot querySnapshot =
        await connectToDB(collection).where('email', isEqualTo: email).get();
    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs[0];
    } else {
      return null; // Mengembalikan nilai null jika data tidak ditemukan
    }
  } catch (e) {
    throw e;
  }
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

Stream<QuerySnapshot<Object?>> getTaskStream({List<String>? classCodes}) {
  try {
    return connectToDB('tugas')
        .where('code_kelas', whereIn: classCodes)
        .snapshots();
  } catch (e) {
    throw e;
  }
}

void submitAnAnswer({String? taskCode, nis, nameFile}) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference collectionRef = firestore.collection('tugas');
  QuerySnapshot querySnapshot =
      await collectionRef.where('code_tugas', isEqualTo: taskCode).get();
  try {
    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot docSnapshot = querySnapshot.docs.first;
      String docId = docSnapshot.id;

      List<Map<String, dynamic>> answerList = [
        {'nis': nis, 'nama_file': nameFile, 'grade': 0}
      ];
      collectionRef.doc(docId).update({
        'jawaban': FieldValue.arrayUnion(answerList),
      });
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        customSnackbar(message: "Berhasil ditambahkan", isError: false),
      );
    } else {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        customSnackbar(message: "Gagal ditambahkan"),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      customSnackbar(message: e.toString()),
    );
  }
}

Stream<List<Map<String, dynamic>>> getAnswerData({String? taskCode}) {
  return connectToDB('tugas')
      .where('code_tugas', isEqualTo: taskCode)
      .snapshots()
      .map((querySnapshot) {
    List<Map<String, dynamic>> results = [];
    if (querySnapshot.docs.isNotEmpty) {
      final listJawaban = querySnapshot.docs.first;
      results = List<Map<String, dynamic>>.from(listJawaban.get('jawaban'));
    }
    return results;
  });
}

void assessment({String? grade, nis, taskCode, fileName}) {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference collectionRef = firestore.collection('tugas');

  collectionRef
      .where('code_tugas', isEqualTo: taskCode)
      .get()
      .then((querySnapshot) {
    if (querySnapshot.docs.isNotEmpty) {
      String docId = querySnapshot.docs.first.id;

      Map<String, dynamic> updataData = {
        'nis': nis,
        'grade': grade,
        'nama_file': fileName,
      };

      List<dynamic> existingJawaban = querySnapshot.docs.first.get('jawaban');

      bool isDataUpdated = false;

      for (int i = 0; i < existingJawaban.length; i++) {
        if (existingJawaban[i]['nis'] == nis) {
          existingJawaban[i]['grade'] = grade;
          existingJawaban[i]['nama_file'] = fileName;
          isDataUpdated = true;
          break;
        }
      }

      if (!isDataUpdated) {
        existingJawaban.add(updataData);
      }

      collectionRef.doc(docId).update({
        'jawaban': existingJawaban,
      }).then((value) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          customSnackbar(
              message: "Data jawaban berhasil diupdate/menambahkan",
              isError: false),
        );
      }).catchError((error) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          customSnackbar(
            message:
                "Terjadi kesalahan saat mengupdate/menambahkan data jawaban",
          ),
        );
      });
    } else {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        customSnackbar(message: "Data tugas tidak ditemukan"),
      );
    }
  }).catchError((error) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      customSnackbar(message: "Terjadi kesalahan saat mengambil data tugas"),
    );
  });
}

Stream<QuerySnapshot<Object?>> getGrade({String? taskCode}) {
  try {
    return connectToDB('tugas')
        .where('code_tugas', isEqualTo: taskCode)
        .snapshots();
  } catch (e) {
    throw e;
  }
}

String generateCode(int length) {
  final random = Random();
  const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
  final codeUnits =
      List.generate(length, (index) => chars[random.nextInt(chars.length)]);

  return codeUnits.join('');
}
