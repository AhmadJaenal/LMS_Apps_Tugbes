import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lms_app_tugbes/animation/fade_animation.dart';
import 'package:lms_app_tugbes/screens/answer_list.dart';
import 'package:lms_app_tugbes/screens/answer_page.dart';
import 'package:lms_app_tugbes/screens/task_assessment.dart';
import 'package:lms_app_tugbes/services/query_collection.dart';
import 'package:lms_app_tugbes/shared/theme.dart';
import 'package:lms_app_tugbes/widgets/card_class.dart';
import 'package:lms_app_tugbes/widgets/widget_custom_button.dart';
import 'package:lms_app_tugbes/widgets/widget_pop_up.dart';
import 'package:lms_app_tugbes/widgets/widget_task.dart';

import '../services/refresh.dart';
import 'list_module.dart';

class Dashboard extends StatefulWidget {
  final String email;
  final String collection;
  final bool isTeacher;
  const Dashboard(
      {super.key,
      required this.email,
      required this.collection,
      this.isTeacher = false});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  TextEditingController nameClassController = TextEditingController();
  TextEditingController lessonNameController = TextEditingController();
  TextEditingController codeClassController = TextEditingController();
  final _formState = GlobalKey<FormState>();

  @override
  void dispose() {
    nameClassController.dispose();
    lessonNameController.dispose();
    codeClassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    connectToDB('kelas');
    // getUser(email: widget.email, collection: widget.collection);
    final mediaQueryOfWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: SizedBox(height: 30),
        ),
        backgroundColor: whiteColor,
        body: Stack(
          children: [
            Align(
              alignment: const Alignment(1, 4),
              child: SvgPicture.asset(
                'assets/pattern.svg',
                fit: BoxFit.cover,
              ),
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: margin),
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Welcome back sir',
                                style: Theme.of(context).textTheme.bodySmall),
                            FutureBuilder(
                              future: getUser(
                                  email: widget.email,
                                  collection: widget.collection),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return SizedBox(
                                    width: 200,
                                    child: Text(snapshot.data!['nama'],
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge),
                                  );
                                } else {
                                  return const SizedBox();
                                }
                              },
                            ),
                          ],
                        ),
                        Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: blueColor,
                          ),
                          child: Icon(Icons.person_outline_rounded,
                              color: whiteColor, size: 14, weight: 3),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  widget.isTeacher
                      ? popUpCreateClass(context)
                      : popUpJoinClass(context),
                  const SizedBox(height: 24),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: margin),
                    child: FadeAnimation(
                      offsetX: -100,
                      childWidget: Text('Your Class',
                          style: Theme.of(context).textTheme.titleLarge),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: FadeAnimation(
                      offsetX: 100,
                      childWidget: Container(
                          width: mediaQueryOfWidth,
                          height: 120,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 50,
                                offset: const Offset(0, 0),
                                color: secondaryColor.withOpacity(.13),
                              ),
                            ],
                          ),
                          child: StreamBuilder<QuerySnapshot<Object?>>(
                            stream: getClassStream(
                                email: widget.email,
                                collection: widget.collection),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                Refresh.updateData(true);
                                QuerySnapshot<Object?> classSnapshot =
                                    snapshot.data!;
                                return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: classSnapshot.docs.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: index == 0
                                          ? const EdgeInsets.only(left: 24)
                                          : index ==
                                                  classSnapshot.docs.length - 1
                                              ? const EdgeInsets.only(
                                                  right: 24, left: 8)
                                              : const EdgeInsets.only(left: 8),
                                      child: CardClass(
                                        className: classSnapshot.docs[index]
                                            ['nama_kelas'],
                                        lessonName: classSnapshot.docs[index]
                                            ['mata_pelajaran'],
                                        theNumberOfStudent: 21,
                                        onTap: () {
                                          String classCode = classSnapshot
                                              .docs[index]['code_kelas'];
                                          Get.to(
                                            ListModule(
                                              classCode: classCode,
                                              isTeacher: widget.isTeacher,
                                              titleClass:
                                                  classSnapshot.docs[index]
                                                      ['mata_pelajaran'],
                                              learningCode: classSnapshot
                                                  .docs[index]['code_materi'],
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  },
                                );
                              } else if (snapshot.hasError) {
                                print("error : ${snapshot.error}");
                                return const Center(
                                    child: Text('Not found class'));
                              } else {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                            },
                          )),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: margin),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        FadeAnimation(
                          offsetX: -50,
                          childWidget: Text('Task',
                              style: Theme.of(context).textTheme.titleLarge),
                        ),
                        FadeAnimation(
                          offsetX: 50,
                          childWidget: Text(
                            'View all',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: primaryColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Refresh.classIsNotEmpty?
                  SizedBox(
                    width: double.infinity,
                    height: 400,
                    child: StreamBuilder<QuerySnapshot<Object?>>(
                      stream: getClassStream(
                        email: widget.email,
                        collection: widget.collection,
                      ),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          QuerySnapshot<Object?> classSnapshot = snapshot.data!;
                          List<String> results = [""];
                          int lengthClass = classSnapshot.docs.length - 1;
                          for (int i = 0; i <= lengthClass; i++) {
                            results.add(classSnapshot.docs[i]['code_kelas']);
                          }
                          return StreamBuilder(
                            stream: getTaskStream(classCodes: results),
                            builder: (context, snapshot1) {
                              if (snapshot1.hasData) {
                                QuerySnapshot<Object?> taskSnapshot =
                                    snapshot1.data!;

                                return ListView.builder(
                                  itemCount: taskSnapshot.docs.length,
                                  itemBuilder: (context, index) {
                                    String dsc =
                                        taskSnapshot.docs[index]['dsc'];
                                    String deadline = taskSnapshot.docs[index]
                                        ['batas_pengumpulan'];
                                    String fileName =
                                        taskSnapshot.docs[index]['nama_file'];
                                    String taskCode =
                                        taskSnapshot.docs[index]['code_tugas'];
                                    return CardTask(
                                      fileName: fileName,
                                      dsc: dsc,
                                      timeLine: deadline,
                                      ontap: () {
                                        widget.isTeacher
                                            ? Get.to(AnswerList(
                                                taskCode: taskCode,
                                              ))
                                            : Get.to(
                                                AnswerPage(
                                                  taskCode: taskCode,
                                                  email: widget.email,
                                                  dsc: dsc,
                                                  deadline: deadline,
                                                ),
                                              );
                                      },
                                    );
                                  },
                                );
                              } else {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            },
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ),
                  // : Text("sdsd"),
                  const SizedBox(height: 90),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding popUpJoinClass(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: margin),
      child: FadeAnimation(
        offsetX: -100,
        childWidget: CustomButtonClass(
          onTap: () {
            return showDialog(
              context: context,
              builder: (BuildContext context) {
                return Form(
                  autovalidateMode: AutovalidateMode.always,
                  key: _formState,
                  child: CustomPopUp(
                    isTeacher: false,
                    classNameC: codeClassController,
                    lessonNameC: codeClassController,
                    hintText: 'Add link class',
                    titleButton: 'Join',
                    titlePopUp: 'Add Class',
                    onTap: () {
                      if (_formState.currentState!.validate()) {
                        searchDocument(
                                nameCollection: 'kelas',
                                data: 'code_kelas',
                                searchQuery: codeClassController.text)
                            .listen((snapshot) {
                          if (snapshot.docs.isNotEmpty) {
                            updateClass(
                              codeClass: codeClassController.text,
                              collection: 'siswa',
                              email: widget.email,
                            );
                            ScaffoldMessenger.of(Get.context!).showSnackBar(
                              customSnackbar("Berhasil bergabung kelas"),
                            );
                            codeClassController.text = '';
                          } else {
                            codeClassController.text = '';
                            ScaffoldMessenger.of(Get.context!).showSnackBar(
                              customSnackbar("Gagal bergabung kelas"),
                            );
                          }
                        });
                        Get.back();
                      }
                    },
                  ),
                );
              },
            );
          },
          titleButton: 'Join Class',
        ),
      ),
    );
  }

  Padding popUpCreateClass(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: margin),
      child: CustomButtonClass(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Form(
                key: _formState,
                child: CustomPopUp(
                  isTeacher: true,
                  classNameC: nameClassController,
                  lessonNameC: lessonNameController,
                  hintText: 'Add name class',
                  titleButton: 'Create',
                  titlePopUp: 'Create Class',
                  onTap: () {
                    if (_formState.currentState!.validate()) {
                      String codeClass = generateCode(10);
                      String learningCode = generateCode(5);
                      createClassRoom(
                        collection: 'kelas',
                        className: nameClassController.text,
                        codeClass: codeClass,
                        lessonName: lessonNameController.text,
                        learningCode: learningCode,
                      );
                      Get.back();
                      updateClass(
                        codeClass: codeClass,
                        collection: 'guru',
                        email: widget.email,
                      );
                      createMateri(
                        learningCode: learningCode,
                      );
                      nameClassController.text = "";
                      lessonNameController.text = "";
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CustomPopUpNotif(
                            title: 'Success Create Class',
                            desc:
                                'Classroom has been successfully created share this code to invite others to join',
                            icon: 'icon_success.svg',
                            ontap: () {},
                            code: codeClass,
                            isTeacher: true,
                          );
                        },
                      );
                    }
                  },
                ),
              );
            },
          );
        },
        titleButton: 'Create Class',
      ),
    );
  }
}
