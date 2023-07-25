import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lms_app_tugbes/screens/task_assessment.dart';
import 'package:lms_app_tugbes/services/query_collection.dart';
import 'package:lms_app_tugbes/shared/theme.dart';
import 'package:lms_app_tugbes/widgets/widget_custom_button.dart';

class AnswerList extends StatelessWidget {
  final String taskCode;
  AnswerList({
    super.key,
    required this.taskCode,
  });
  final TextEditingController gradeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: SizedBox(height: 60),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const ButtonBack(title: 'Penilaian'),
            Container(
              margin: EdgeInsets.symmetric(horizontal: margin),
              height: MediaQuery.of(context).size.height * .8,
              child: StreamBuilder(
                stream: getAnswerData(taskCode: taskCode),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        String nis = snapshot.data![index]['nis'];
                        String fileName = snapshot.data![index]['nama_file'];
                        return GestureDetector(
                          onTap: () {
                            Get.to(TaskAssessment(
                              fileName: fileName,
                              nis: nis,
                              taskCode: taskCode,
                            ));
                          },
                          child: Container(
                            margin: const EdgeInsets.only(top: 10),
                            padding: const EdgeInsets.all(16),
                            width: MediaQuery.of(context).size.width * .8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: whiteColor,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 50,
                                  offset: const Offset(0, 0),
                                  color: secondaryColor.withOpacity(.13),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      nis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!,
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        SvgPicture.asset('assets/pdf.svg',
                                            width: 24),
                                        const SizedBox(width: 8),
                                        SizedBox(
                                          width: 200,
                                          child: Text(
                                            fileName,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return const Text('tidak ada jawaban');
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
