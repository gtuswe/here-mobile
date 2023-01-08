import 'package:flutter/material.dart';
import 'package:here/model/user.dart';
import 'package:here/service/authentication.dart';
import 'package:here/view/profile/edit_profile_page.dart';
import 'package:kartal/kartal.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../authenticate/login/login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late User user;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
      future: AuthenticationService().getUser(),
      builder: (context, snapshot) {
        // Wait list data
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }
        // Log errors
        if (snapshot.hasError) {
          debugPrint("Can't get Profile Information: ${snapshot.error}");
        }
        // Check list data
        if (!snapshot.hasData) {
          return Center(
              child: TextButton(
                  onPressed: () {
                    _logout(context);
                  },
                  child: const Text("Profile information not found.")));
        }

        // Build list
        user = snapshot.data!;
        print("profilde");
        print(user.student_no);
        return Padding(
          padding: const EdgeInsets.only(top: 50, right: 15, left: 15),
          child: Column(
            children: [
              Expanded(
                flex: 6,
                child: Card(
                  color: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: ListTile(
                      leading: SizedBox(
                        width: 60,
                        height: 60,
                        child: CircleAvatar(
                          backgroundColor: context.appTheme.bottomAppBarColor,
                          child:
                              Text("${user.name?[0].toCapitalized() ?? ""}${user.surname?[0].toCapitalized() ?? ""}"),
                        ),
                      ),
                      title: Text(
                        "${user.name ?? ""} ${user.surname ?? ""}",
                        style: context.textTheme.bodyLarge!.copyWith(color: Colors.white),
                      ),
                      subtitle: Text(
                        user.mail ?? "",
                        style: context.textTheme.bodySmall!.copyWith(color: Colors.grey),
                      ),
                      trailing: IconButton(
                          onPressed: () {
                            context.navigateToPage(EditProfilePage(
                              user: user,
                              parentAction: rebuildPage,
                            ));
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.grey,
                          )),
                    ),
                  ),
                ),
              ),
              const Expanded(flex: 1, child: SizedBox()),
              Expanded(
                  flex: 8,
                  child: Card(
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(
                            Icons.school_outlined,
                            color: Color.fromARGB(255, 103, 80, 164),
                          ),
                          title: const Text("Student number"),
                          subtitle: Text(user.student_no ?? ""),
                        ),
                        TextButton(
                            onPressed: () async {
                              await _logout(context);
                            },
                            child: const ListTile(
                              leading: Icon(Icons.logout),
                              trailing: Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 16,
                              ),
                              title: Text("Log out"),
                              subtitle: Text("Manage your account"),
                            )),
                      ],
                    ),
                  )),
              Expanded(
                  flex: 2,
                  child: SizedBox(
                    width: context.width,
                    child: const Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "More",
                      ),
                    ),
                  )),
              Expanded(
                  flex: 10,
                  child: Card(
                    child: Column(
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: const ListTile(
                            leading: Icon(Icons.people),
                            trailing: Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 16,
                            ),
                            title: Text("Invite friends"),
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const ListTile(
                            leading: Icon(Icons.stars),
                            trailing: Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 16,
                            ),
                            title: Text("Rate us"),
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const ListTile(
                            leading: Icon(Icons.info),
                            trailing: Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 16,
                            ),
                            title: Text("About us"),
                          ),
                        )
                      ],
                    ),
                  )),
            ],
          ),
        );
      },
    );
  }

  Future<void> _logout(BuildContext context) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove("accessToken");
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const LoginPage(),
        ));
  }

  rebuildPage() {
    setState(() {
      print("REBUILD");
    });
  }
}
