import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:sparrow/Repository/OtheruserRepo.dart';
import 'package:sparrow/Repository/QuestionRepo.dart';
import 'package:sparrow/Response/QuestionResponse.dart';
import 'package:sparrow/api/QuestionAPI.dart';
import 'package:sparrow/api/chat_api.dart';
import 'package:sparrow/models/otheruser_model.dart';
import 'package:sparrow/screens/home_screen/home_screen.dart';
import 'package:sparrow/screens/profile/profile_screen.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sparrow/utils/Config.dart';

import '../Response/OtherUserResp.dart';
import '../models/question_model.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);
  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  HtmlEditorController controller = HtmlEditorController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Test'),
        ),
        body: Container(
          child: FutureBuilder<OtherUserResp?>(
            future:OtheruserRepo().getOtherUserRepo("62dc08f9215fba30f52f3aa8"),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  List<OtherUserModal> otherUser = snapshot.data!.data!;
                  return ListView.builder(
                    itemCount: otherUser.length,
                    itemBuilder: (context, index) {
                      var profile = otherUser[index].profile;
                      return Container(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: Column(
                                    // alignment: Alignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          "${otherUser[index].fname} ${otherUser[index].lname}",
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            // add button to the left side of the screen
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return Center(child: Text("No profile data"));
                }
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        )
        // body: FutureBuilder<QuestionResponse?>(
        //         future: QuestionRepo().getQuestions(),
        //         builder: (context, snapshot) {
        //           if (snapshot.connectionState == ConnectionState.done) {
        //             if (snapshot.hasData) {
        //               // Text
        //               List<Questions> lstQuestion = snapshot.data!.data!;
        //               return ListView.builder(
        //                 itemCount: snapshot.data!.data!.length,
        //                 itemBuilder: (context, index) {
        //                   return Container(
        //                     child: Column(
        //                      children: [
        //                       Text(lstQuestion[index].questionName!)
        //                      ],
        //                     ),
        //                   );
        //                 },
        //               );
        //             } else {
        //               return Center(
        //                 child: Text("No Data"),
        //               );
        //             }
        //           } else if (snapshot.connectionState ==
        //               ConnectionState.waiting) {
        //             return Center(
        //               child: CupertinoActivityIndicator(
        //                 radius: 20,
        //               ),
        //             );
        //           } else {
        //             return const Text("Error");
        //           }
        //         },
        //       ),

        // body: FutureBuilder(
        //       future: QuestionAPI().getQuestionByQsnId("62dc34e529ff2a62f95edd94"),
        //       builder: (context, snapshot) {
        //         if (!snapshot.hasData) {
        //           return CircularProgressIndicator();
        //         }
        //         print(snapshot.data);
        //         final List conversations = snapshot.data as List;
        //         return ListView.builder(
        //           itemCount: conversations.length,
        //           itemBuilder: (context, index) {
        //             return ListTile(
        //               title: Text(conversations[index]['questionName']),
        //             );
        //           },
        //         );
        //       },
        //     ),

        // FutureBuilder(
        //   future: TestApi().getPosts(),
        //   builder: (context, snapshot) {
        //     if (!snapshot.hasData) {
        //       return CircularProgressIndicator();
        //     }
        //     final List posts = snapshot.data as List;
        //     return ListView.builder(
        //       itemCount: posts.length,
        //       itemBuilder: (context, index) {
        //         return ListTile(
        //           title: Text(posts[index]['title']),
        //         );
        //       },
        //     );
        //   },
        // )

        //   body:HtmlEditor(
        //     controller: controller, //required
        //     htmlEditorOptions: HtmlEditorOptions(
        //       hint: "Your text here...",
        //       //initalText: "text content initial, if any",
        //     ),
        //     otherOptions: OtherOptions(
        //       height: 400,
        //     ),
        // )
        );
  }
}

// class TestApi {
//   Future getPosts() async {
    
//     final posts = Hive.box('test').get('posts', defaultValue: []);
//     if (posts.isNotEmpty) return posts;

//     final res = await Dio().get('https://jsonplaceholder.typicode.com/posts');
//     final resJson = res.data;

//     Hive.box('test').put('posts', resJson);

//     return resJson;
//   }
// }
