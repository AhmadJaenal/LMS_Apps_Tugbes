import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_app_tugbes/services/query_collection.dart';
import 'package:lms_app_tugbes/shared/theme.dart';
import 'package:lms_app_tugbes/widgets/widget_custom_button.dart';

class Nilai extends StatelessWidget {
  final String taskCode;
  const Nilai({super.key, required this.taskCode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: SizedBox(height: 60),
      ),
      body: Column(
        children: [
          const ButtonBack(title: 'Daftar Nilai'),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * .8,
            child: StreamBuilder(
              stream: getGrade(taskCode: taskCode),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<dynamic> resultGrade =
                      snapshot.data!.docs.first.get('jawaban');
                  return ListView.builder(
                    itemCount: resultGrade.length,
                    itemBuilder: (context, index) {
                      String nis = resultGrade[index]['nis'];
                      String nilai = resultGrade[index]['grade'];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                left: margin, right: margin, top: 8),
                            padding: const EdgeInsets.all(16),
                            width: 200,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(nis),
                                const SizedBox(width: 10),
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: secondaryColor.withOpacity(.3),
                                  ),
                                  child: Text(
                                    nilai,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          color: primaryColor,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  return Center(child: Text('Data Tidak Tersedia'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
