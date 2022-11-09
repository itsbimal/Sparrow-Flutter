import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sparrow/utils/config.dart';

class ChatAPI {
  Future getConversation() async {
    var dio = Dio();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var currentUser = prefs.getString("id");
    var conversationURL =
        Config.apiURL + '${Config.getConversation}/$currentUser';

    // list of conversation
    List conversationList = [];

    try {
      var response = await dio.get(conversationURL);
      for (int i = 0; i < response.data.length; i++) {
        var members = response.data[i]['members'];
        // choosing other member of the conversation
        var otherUser = members.firstWhere((element) => element != currentUser);
        var userURL = Config.apiURL + '${Config.getConUser}/$otherUser';
        Response userResponse = await dio.get(userURL);
        conversationList.add(userResponse.data);
      }
      return conversationList;
    } catch (e) {
      rethrow;
    }
  }

  Future getMessages(String conversationId) async {
    print("getting messages");
    var dio = Dio();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var currentUser = prefs.getString("id");
    var messagesURL = Config.apiURL + '${Config.getMessages}/$conversationId';
    try {
      var response = await dio.get(messagesURL);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
