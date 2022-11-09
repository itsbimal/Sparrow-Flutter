import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sparrow/Repository/QuestionRepo.dart';
import 'package:sparrow/Response/QuestionResponse.dart';
import 'package:sparrow/api/QuestionAPI.dart';
import 'package:sparrow/helpers/CherryToast.dart';
import 'package:sparrow/models/question_model.dart';
import 'package:timeago/timeago.dart' as timeago;

class EditQuesion extends StatefulWidget {
  const EditQuesion({Key? key}) : super(key: key);

  @override
  State<EditQuesion> createState() => _EditQuesionState();
}

class _EditQuesionState extends State<EditQuesion> {
  var loginedUser;

  // controller for question text field
  var updatedQsn = '';

  _getId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    loginedUser = prefs.getString('id');
  }

  @override
  void initState() {
    _getId();
    super.initState();
  }

  void _showActionSheet(BuildContext context, String question, String id) {
    print(id);
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('Edit your question',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
              openDialog(question, id);
            },
            child: const Text('Edit you question'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: ElevatedButton(
              key: Key('deleteQuestion'),
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                minimumSize: const Size.fromHeight(45), // NEW
              ),
              onPressed: () {
                _showAlertDialog(context, id);
              },
              child: const Text(
                'Delete',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Close'),
          )
        ],
      ),
    );
  }

  void _showAlertDialog(BuildContext context, String id) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Alert'),
        content: const Text('Are you sure you want to logout?'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('No'),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              QuestionAPI().deleteQuestion(id).then((value) => {
                    // pop
                    Navigator.pop(context),
                    ToastService().showSuccess("Question Deleted", context)
                  });
            },
            child: const Text('Yes'),
          )
        ],
      ),
    );
  }

  Future openDialog(question, id) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text('Edit your question'),
            content: TextFormField(
              initialValue: question,
              // controller: _questionController,
              onChanged: (value) {
                updatedQsn = value;
              },
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'your new updated question',
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
                child: Text('Submit'),
                onPressed: () {
                  QuestionAPI().editQuestion(id, updatedQsn).then((value) => {
                        // pop
                        Navigator.of(context).pop(),
                        ToastService().showSuccess(
                            "Question Updated Successfully", context)
                      });
                },
              ),
            ],
          ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        foregroundColor: Colors.black,
        title: Text("Showing all your questions"),
      ),
      body: Center(
          child: FutureBuilder<QuestionResponse?>(
              future: QuestionRepo().eachQuestions(loginedUser),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    // Text
                    List<Questions> lstQuestion = snapshot.data!.data!;
                    return ListView.builder(
                      itemCount: snapshot.data!.data!.length,
                      itemBuilder: (context, index) {
                        String question = lstQuestion[index].questionName!;
                        String qsnId = lstQuestion[index].id!;
                        return ListTile(
                            
                            leading: CachedNetworkImage(
                              imageUrl: lstQuestion[index].questionImage!,
                              height: 100,
                              width: 80,
                              fit: BoxFit.cover,
                            ),
                            title: Text(lstQuestion[index].questionName!),
                            subtitle: Text(
                                'posted about ${timeago.format(DateTime.parse(lstQuestion[index].createdAt!))}'),
                            trailing: IconButton(
                              key: Key('editQuestion'),
                              onPressed: () {
                                _showActionSheet(context, question, qsnId);
                              },
                              icon: Icon(Icons.edit_rounded),
                            ));
                      },
                    );
                  } else {
                    return const Center(
                      child: Text("No Data"),
                    );
                  }
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CupertinoActivityIndicator(
                      radius: 20,
                    ),
                  );
                } else {
                  return const Text("Error");
                }
              })),
    );
  }
}
