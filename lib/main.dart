import 'package:flutter/material.dart';
import 'package:triumph2/pages/berstatus.dart';
import 'package:triumph2/pages/pending.dart';
import 'package:triumph2/pages/profile.dart';
import 'package:triumph2/pages/landing.dart';
import 'package:triumph2/pages/login.dart';
import 'package:triumph2/pages/register.dart';
import 'package:triumph2/pages/forgotpass.dart';
import 'package:triumph2/pages/verifcode.dart';
import 'package:triumph2/pages/changepass.dart';
import 'package:triumph2/pages/home.dart';
import 'package:triumph2/pages/mail.dart';

import 'package:provider/provider.dart';
import 'package:triumph2/provider/theme.dart';
import 'package:triumph2/provider/mailprovider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => MailProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      initialRoute: '/',
      routes: {
        '/': (context) => Landing(),
        '/login': (context) => Login(),
        '/register': (context) => Register(),
        '/forgot': (context) => ForgotPass(),
        '/verify': (context) => VerifCode(),
        '/change': (context) => ChangePass(),
        '/home': (context) => Home(),
        '/create': (context) => CreateMail(),
        '/profile': (context) => Profile(),
        '/pending': (context) => Pending(),
        '/berstatus': (context) => Berstatus(),
      },
    );
  }
}
