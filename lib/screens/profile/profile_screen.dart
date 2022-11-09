import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shake/shake.dart';
import 'package:sparrow/Repository/OtheruserRepo.dart';
import 'package:sparrow/Response/OtherUserResp.dart';
import 'package:sparrow/helpers/DarkMode/dark_provider.dart';
import 'package:sparrow/helpers/shared_pref.dart';
import 'package:sparrow/models/otheruser_model.dart';
import '../../utils/Config.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var username;
  var fname;
  var profile;
  List followers = [];
  var id;

  late ShakeDetector detector;

  @override
  void initState() {
    sharedPref().getUserDetails().then((value) {
      setState(() {
        id = value['id'];
      });
    });

    detector = ShakeDetector.autoStart(
      onPhoneShake: () {
        setState(() {
          _showAlertDialog(context);
        });
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    detector.stopListening();
    super.dispose();
  }

  void _showAlertDialog(BuildContext context) {
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
              sharedPref()
                  .removeAuthToken()
                  .then((value) => Navigator.pushNamed(context, '/login'));
            },
            child: const Text('Yes'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          elevation: 0,
          foregroundColor: Colors.black,
          title: Text('Settings and Privacy',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              actions: [
                IconButton(
                  icon: Icon(Icons.logout),
                  onPressed: () {
                    sharedPref()
                  .removeAuthToken()
                  .then((value) => Navigator.pushNamed(context, '/login'));
                  },
                )
              
              ],
        ),
        body: Container(
          child: FutureBuilder<OtherUserResp?>(
            future: OtheruserRepo().getOtherUserRepo(id),
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
                                Config.apiURL.contains("10.0.2.2")
                                    ? CircleAvatar(
                                        backgroundImage: NetworkImage(profile!
                                            .replaceAll(
                                                'localhost', '10.0.2.2',)),
                                        // height and width
                                        minRadius: 40,
                                      )
                                    : CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            "https://i.pravatar.cc/300"),
                                            minRadius: 40,
                                      ),
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
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Badge(
                                          toAnimate: false,
                                          shape: BadgeShape.square,
                                          badgeColor: Color.fromARGB(
                                              255, 102, 213, 134),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          badgeContent: Text(
                                              "@${otherUser[index].username}",
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                                // margin: const EdgeInsets.all(15.0),
                                padding: const EdgeInsets.only(
                                    left: 35.0,
                                    right: 35.0,
                                    top: 10.0,
                                    bottom: 10.0),
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    colors: [
                                      Color.fromARGB(255, 152, 104, 236),
                                      Color(0xff2196f3),
                                    ],
                                  ),

                                  // background color
                                  color: Color.fromARGB(255, 88, 110, 248),
                                  // text color
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      '${otherUser[index].followers!.length} Followers   |  ${otherUser[index].followers!.length} Followings',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const Divider(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                    ),

                                    // Bronze badge
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            Image.asset(
                                              'assets/images/badge.png',
                                              width: 45,
                                              height: 45,
                                            ),
                                            Column(
                                              children: const [
                                                Text(
                                                  'Bronze',
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Text(
                                                  'Exp. 35',
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        // verticle divider
                                        VerticalDivider(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '👋 1 Questions',
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Text(
                                              '✍️ 1 Answers',
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                )
                                // hr line

                                ),

                            SizedBox(
                              height: 10,
                            ),

                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              // background color
                              
                              child: SettingsGroup(
                                
                                items: [
                                  SettingsItem(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, '/edit_profile');
                                    },
                                    icons: CupertinoIcons.settings,
                                    iconStyle: IconStyle(),
                                    title: 'Customize your profile',
                                    subtitle: "Edit your profile settings ",
                                    
                                  ),
                                  SettingsItem(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, '/change_password');
                                    },
                                    icons: CupertinoIcons.lock,
                                    iconStyle: IconStyle(),
                                    title: 'Privacy and safety',
                                    subtitle: "Password and security settings",
                                  ),
                                  SettingsItem(
                                    onTap: () {
                                      Navigator.pushNamed(context, '/editQsn');
                                    },
                                    icons: Icons.question_answer,
                                    iconStyle: IconStyle(
                                      iconsColor: Colors.white,
                                      withBackground: true,
                                      backgroundColor: Colors.red,
                                    ),
                                    title: 'Your Asked Questions',
                                    subtitle: "Edit and delete your questions",
                                  ),
                                   SettingsItem(
                                    onTap: () {
                                      Navigator.pushNamed(context, '/sensor');
                                    },
                                    icons: Icons.lightbulb_outline,
                                    iconStyle: IconStyle(
                                      iconsColor: Colors.white,
                                      withBackground: true,
                                      backgroundColor: Colors.green,
                                    ),
                                    title: 'Sensor Settings',
                                    subtitle: "Enable or disable your sensors",
                                  ),
                                  SettingsItem(
                                    onTap: () {},
                                    icons: Icons.dark_mode_rounded,
                                    iconStyle: IconStyle(
                                      iconsColor: Colors.white,
                                      withBackground: true,
                                      backgroundColor: Colors.red,
                                    ),
                                    title: 'Dark mode',
                                    subtitle: "Automatic",
                                    trailing: Switch.adaptive(
                                      value: themeProvider.isDarkMode ,
                                      onChanged: (value) {
                                        final provider = Provider.of<ThemeProvider>(
                                          context,
                                          listen: false,
                                        );
                                        provider.toggleTheme(value);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            OutlinedButton(
                              // outline border
                              style: OutlinedButton.styleFrom(
                                primary: Color.fromARGB(255, 235, 25, 25),
                                // border color
                                minimumSize: const Size.fromHeight(45), // NEW
                              ),
                              onPressed: () {
                                _showAlertDialog(context);
                              },
                              child: const Text('Logout'),
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
      );
  }
}
