import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:sparrow/api/QuestionAPI.dart';
import 'package:sparrow/screens/BottomNav/BottomNav.dart';
import 'package:sparrow/utils/Config.dart';
import 'package:timeago/timeago.dart' as timeago;

class QuesionDetails extends StatefulWidget {
  const QuesionDetails({Key? key}) : super(key: key);

  @override
  State<QuesionDetails> createState() => _QuesionDetailsState();
}

class _QuesionDetailsState extends State<QuesionDetails> {
  var qsnId;
  // answer controller
  TextEditingController answerController = TextEditingController();

  bool _isLoading = false;
  void _startLoading() async {
    setState(() {
      _isLoading = true;
    });

    // Wait for 3 seconds
    // You can replace this with your own task like fetching data, proccessing images, etc
    await Future.delayed(Duration(seconds: 5));

    setState(() {
      _isLoading = false;
    });
  }

  Future openDialog() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text('Reply to this question'),
            content: TextField(
              controller: answerController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Add your answer',
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child:
                    _isLoading ? CupertinoActivityIndicator() : Text('Reply'),
                onPressed: () {
                  _isLoading ? false : _startLoading();
                  QuestionAPI().postAnswers(qsnId, answerController.text);
                },
              ),
            ],
          ));

  @override
  Widget build(BuildContext context) {
    Map args = ModalRoute.of(context)?.settings.arguments as Map;
    qsnId = args['id'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        elevation: 0,
        foregroundColor: Colors.black,
        title: Text('Answer page'),
      ),
      body: FutureBuilder(
        future: QuestionAPI().getQuestionByQsnId(qsnId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          final List qna = snapshot.data as List;
          return ListView.builder(
            itemCount: qna.length,
            itemBuilder: (context, index) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // question details page
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: Text(
                        '${args['fname']} asked about ${timeago.format(DateTime.parse(qna[index]['createdAt']))}',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                      child: Text(
                        '${qna[index]['questionName']}',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    // divider
                    Divider(
                      color: Colors.grey.shade500,
                      thickness: 1,
                    ),

                    for (int i = 0; i < qna[index]['answers'].length; i++)
                    
                      Container(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 20),
                                  child: Config.apiURL.contains("10.0.2.2")
                              ? CircleAvatar(
                                  backgroundImage: NetworkImage('${qna[index]['answers'][i]['answeredBy']['profile']}'
                                      .replaceAll('localhost', '10.0.2.2')),
                                  // height and width
                                )
                              : CircleAvatar(
                                  backgroundImage:
                                      NetworkImage("https://i.pravatar.cc/300"),
                                ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 20),
                                      child: Text(
                                        'Answered by ${qna[index]['answers'][i]['answeredBy']['fname']} ${qna[index]['answers'][i]['answeredBy']['lname']}',
                                        style: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 20),
                                      child: Text(
                                        timeago.format(
                                            DateTime.parse(
                                                qna[index]['answers'][i]
                                                    ['answeredOn'])),
                                        style: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 10),
                              child: Text(
                                '${qna[index]['answers'][i]['text']}',
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.6)),
                              ),
                            ),

                            // Image network
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: qna[index]['answers'][i]['answerImage'] != "default"
                                  ? Image.network(
                                      qna[index]['answers'][i]['answerImage'],
                                      height: 200,
                                      width: MediaQuery.of(context).size.width,
                                      fit: BoxFit.fill,
                                    )
                                  : Image.asset(
                                      'assets/images/ans_def.jpg',
                                      height: 200,
                                      width: MediaQuery.of(context).size.width,
                                    ),
                            ),
                            Divider(
                              color: Colors.grey.shade500,
                              thickness: 1,
                            ),
                          ],
                        ),
                      ),
                    // answer
                  ],
                  // floating action button
                ),
              );
            },
          );
        },
      ),
           // full length floating action button
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          openDialog();
        },
        elevation: 0,
        label: const Text('Add answers'),
        icon: const Icon(Icons.add_box_outlined),
        backgroundColor: Color.fromARGB(255, 56, 55, 55),
        foregroundColor: Colors.white,
      ),
    );
  }
}
