import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lms_app_tugbes/services/query_collection.dart';
import 'package:lms_app_tugbes/widgets/card_class.dart';

import '../animation/fade_animation.dart';
import '../shared/theme.dart';

class ListClassPage extends StatelessWidget {
  final String email;
  final String collection;
  const ListClassPage(
      {super.key, required this.email, required this.collection});

  @override
  Widget build(BuildContext context) {
    final mediaQueryOfHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: SizedBox(
          height: 60,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Center(
              child: Text(
                'Your Class',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),
          const SizedBox(height: 40),
          FadeAnimation(
            offsetY: 100,
            childWidget: Container(
              width: double.infinity,
              height: mediaQueryOfHeight * .7,
              margin: EdgeInsets.symmetric(horizontal: margin),
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
                stream: getClassStream(email: email, collection: collection),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    QuerySnapshot<Object?> classSnapshot = snapshot.data!;
                    return ListView.builder(
                      itemCount: classSnapshot.docs.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: CardClass(
                            className: classSnapshot.docs[index]['nama_kelas'],
                            lessonName: classSnapshot.docs[index]
                                ['mata_pelajaran'],
                            theNumberOfStudent: 21,
                            onTap: () {},
                          ),
                        );
                      },
                    );
                  }
                  if (snapshot.hasError) {
                    return const Center(child: Text('Not found class'));
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
