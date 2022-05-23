import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nec/Screens/addTransfer.dart';
import 'package:nec/Screens/changeLoc.dart';
import 'package:nec/api/proxy/loginApiProxy.dart';
import 'package:nec/model/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var userName = TextEditingController();
  var passWord = TextEditingController();
  bool rememberPass = false;
  String username = "1";
  String password = "12345";
  String messageWarning = "Username or Password is incorrect";

  List<UserModel> virtualUser = [
    UserModel(name: 'a', password: 'a', partNo: true),
    UserModel(name: 'b', password: 'b', partNo: false),
    UserModel(name: 'c', password: 'c', partNo: true),
    UserModel(name: 'd', password: 'd', partNo: false),
    UserModel(name: 'e', password: 'e', partNo: true),
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
        _TitleApp(),
        _LoginField(widthScreen),
        _PasswordField(widthScreen),
        _DatabaseField(widthScreen),
        _RememberField(),
        _FooterField(widthScreen)
      ]),
    ));
  }

  Widget _TitleApp() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 0, 24),
        child: Container(
          alignment: Alignment.topLeft,
          child: Text('Login IFS Application', style: TextStyle(fontSize: 18)),
        ));
  }

  Widget _LoginField(double widthScreen) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(width: widthScreen * 0.2, child: Text('Login')),
        Container(
            margin: const EdgeInsets.all(8.0),
            width: widthScreen * 0.6,
            height: 48,
            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
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
    );
  }

  Widget _PasswordField(double widthScreen) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(width: widthScreen * 0.2, child: Text('Password')),
        Container(
            margin: const EdgeInsets.all(8.0),
            width: widthScreen * 0.6,
            height: 48,
            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                textInputAction: TextInputAction.next,
                obscureText: true,
                obscuringCharacter: '●',
                maxLength: 16,
                style: TextStyle(fontSize: 20),
                controller: passWord,
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
    );
  }

  Widget _DatabaseField(double widthScreen) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(width: widthScreen * 0.2, child: Text('Database')),
        Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(8.0),
            width: widthScreen * 0.6,
            height: 48,
            decoration: BoxDecoration(border: Border.all(color: Colors.red)),
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
    );
  }

  Widget _RememberField() {
    return ListTile(
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
                icon: Icon(Icons.check_box_outlined, color: Colors.green)));
  }

  Widget _FooterField(double widthScreen) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            doLogin();
            // UserModel idCheck = virtualUser.singleWhere(
            //     (user) => ((user.name == userName.text) &&
            //         (user.password == passWord.text)),
            //     orElse: () => UserModel(
            //         name: '404 not found',
            //         password: '404 not found',
            //         partNo: false));

            // if (idCheck.name == '404 not found') {
            //   _showIdNotFound();
            // } else {
            //   print(
            //       "User Name: ${idCheck.name}\tPassword: ${idCheck.password}\tDatabase: ${databaseName}\tRemember Password: ${rememberPass}");
            //   Navigator.of(context).push(MaterialPageRoute(
            //       builder: (context) => ChangeLocation(user: idCheck)));
            // }
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
              passWord.clear();
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
    );
  }

  doLogin() async {
    // print("doLogin()");
    if (userName.text.isNotEmpty) {
      username = userName.text;
      password = passWord.text;
      String dbConfig = databaseName;
      SharedPreferences pref = await SharedPreferences.getInstance();
      LoginApiProxy proxy = LoginApiProxy();
      proxy.dbHost = pref.getString(dbConfig + '_DBHOST') ?? '172.28.19.51';
      proxy.dbPort = pref.getInt(dbConfig + '_DBPORT') ?? 1521;
      proxy.dbUser = username;
      proxy.dbPass = password;

      var result = await proxy.login(username, password);
      print("doLogin()");
      
      if (result.errorMessage == null) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ChangeLocation(user: result)));

        userName.clear();
        passWord.clear();
      } else {
        messageWarning = result.errorMessage!;
        warnningDialog();
      }
    } else {
      warnningDialog();
    }
  }

  warnningDialog() {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        contentPadding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
        title: const Text('Information'),
        content: Text(messageWarning),
        actions: <Widget>[
          const Divider(
            indent: 10.0,
            endIndent: 10.0,
            thickness: 0.8,
          ),
          Container(
            height: 50.0,
            //color: Colors.amber,
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, 'OK');
                    userName.clear();
                    passWord.clear();
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}