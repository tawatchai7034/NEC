import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nec/Screens/addTransfer.dart';
import 'package:nec/Screens/changeLoc.dart';
import 'package:nec/model/User.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var userName = TextEditingController();
  var password = TextEditingController();
  bool rememberPass = false;

  List<UserModel> virtualUser = [
    UserModel(name: 'a', password: 'a',partNo: true),
    UserModel(name: 'b', password: 'b',partNo: false),
    UserModel(name: 'c', password: 'c',partNo: true),
    UserModel(name: 'd', password: 'd',partNo: false),
    UserModel(name: 'e', password: 'e',partNo: true),
  ];

  late String databaseName = "Database01";
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Database01"), value: "Database01"),
      DropdownMenuItem(child: Text("Database02"), value: "Database02"),
      DropdownMenuItem(child: Text("Database03"), value: "Database03"),
      DropdownMenuItem(child: Text("Database04"), value: "Database04"),
    ];
    return menuItems;
  }

  void _showIdNotFound() {
    showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text('User or Password not found.'),
            content: Padding(
              padding: const EdgeInsets.fromLTRB(8, 16, 8, 24),
              child:
                  Text('Please login again.', style: TextStyle(fontSize: 18)),
            ),
            actions: <Widget>[
              // TextButton(
              //     onPressed: () {
              //       Navigator.of(context).pop();
              //     },
              //     child: Text('Close')),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Ok'),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 0, 24),
            child: Container(
              alignment: Alignment.topLeft,
              child:
                  Text('Login IFS Application', style: TextStyle(fontSize: 18)),
            )),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(width: widthScreen * 0.2, child: Text('Login')),
            Container(
                margin: const EdgeInsets.all(8.0),
                width: widthScreen * 0.6,
                height: 48,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    textInputAction: TextInputAction.next,
                    controller: userName,
                    // onSubmitted: (userName) {
                    //   if (virtualLocF.contains(loc)) {
                    //     print("Location from: $loc");
                    //   } else {
                    //     _showNotFoundLocation();
                    //   }
                    // },
                    decoration: new InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                  ),
                ))
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(width: widthScreen * 0.2, child: Text('Password')),
            Container(
                margin: const EdgeInsets.all(8.0),
                width: widthScreen * 0.6,
                height: 48,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    textInputAction: TextInputAction.next,
                    obscureText: true,
                    obscuringCharacter: '●',
                    maxLength: 16,
                    style: TextStyle(fontSize: 20),
                    controller: password,
                    // onSubmitted: (userName) {
                    //   if (virtualLocF.contains(loc)) {
                    //     print("Location from: $loc");
                    //   } else {
                    //     _showNotFoundLocation();
                    //   }
                    // },
                    decoration: new InputDecoration(
                      counterText: '',
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                  ),
                ))
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(width: widthScreen * 0.2, child: Text('Database')),
            Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(8.0),
                width: widthScreen * 0.6,
                height: 48,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.red)),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                      dropdownColor: Colors.white,
                      value: databaseName,
                      onChanged: (String? newValue) {
                        setState(() {
                          databaseName = newValue!;
                        });
                      },
                      items: dropdownItems),
                ))
          ],
        ),
        ListTile(
            title: Text('Remember Password'),
            leading: rememberPass == false
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        rememberPass = true;
                      });
                    },
                    icon: Icon(Icons.check_box_outline_blank))
                : IconButton(
                    onPressed: () {
                      setState(() {
                        rememberPass = false;
                      });
                    },
                    icon: Icon(Icons.check_box_outlined, color: Colors.green))),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                UserModel idCheck = virtualUser.singleWhere(
                    (user) => ((user.name == userName.text) &&
                        (user.password == password.text)),
                    orElse: () => UserModel(
                        name: '404 not found', password: '404 not found',partNo: false));

                if (idCheck.name == '404 not found') {
                  _showIdNotFound();
                } else {
                  print(
                      "User Name: ${idCheck.name}\tPassword: ${idCheck.password}\tDatabase: ${databaseName}\tRemember Password: ${rememberPass}");
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ChangeLocation(user: idCheck)));
                }

              },
              child: Container(
                  margin: const EdgeInsets.all(16.0),
                  width: widthScreen * 0.2,
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.green)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Login', textAlign: TextAlign.center),
                  )),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  userName.clear();
                  password.clear();
                  databaseName = "Database01";
                  rememberPass = false;
                });
              },
              child: Container(
                  margin: const EdgeInsets.all(16.0),
                  width: widthScreen * 0.2,
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.green)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Close', textAlign: TextAlign.center),
                  )),
            ),
          ],
        ),
      ]),
    ));
  }
}
