import 'package:flutter/material.dart';
import 'package:manajemenkesehatan/helpers/user_info.dart';
import 'package:manajemenkesehatan/ui/login_page.dart';
import 'package:manajemenkesehatan/ui/pasien_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget page = const CircularProgressIndicator();
  @override
  void initState() {
    super.initState();
    isLogin();
  }

  void isLogin() async {
    var token = await UserInfo().getToken();
    if (token != null) {
      setState(() {
        page = const RekamMedisPasienPage();
      });
    } else {
      setState(() {
        page = const LoginPage();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Manajemen Stress',
      debugShowCheckedModeBanner: false,
      home: page,
    );
  }
}
