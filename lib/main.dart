import 'package:flutter/material.dart';
import 'package:triumph2/pages/berstatus.dart';
import 'package:triumph2/pages/homeadmin.dart';
import 'package:triumph2/pages/loginadmin.dart';
import 'package:triumph2/pages/pendingadmin.dart';
import 'package:triumph2/pages/pendinguser.dart';
import 'package:triumph2/pages/peran.dart';
import 'package:triumph2/pages/profile.dart';
import 'package:triumph2/pages/landing.dart';
import 'package:triumph2/pages/loginuser.dart';
import 'package:triumph2/pages/register.dart';
import 'package:triumph2/pages/forgotpass.dart';
import 'package:triumph2/pages/verifcode.dart';
import 'package:triumph2/pages/changepass.dart';
import 'package:triumph2/pages/homeuser.dart';
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
        '/peran': (context) => Peran(),
        '/loginuser': (context) => LoginUser(),
        '/loginadmin': (context) => LoginAdmin(),
        '/register': (context) => Register(),
        '/forgot': (context) => ForgotPass(),
        '/verify': (context) => VerifCode(),
        '/change': (context) => ChangePass(),
        '/homeuser': (context) => HomeUser(),
        '/homeadmin': (context) => HomeAdmin(),
        '/create': (context) => CreateMail(),
        '/profile': (context) => Profile(),
        '/pendinguser': (context) => PendingUser(),
        '/pendingadmin': (context) => PendingAdmin(),
        '/berstatus': (context) => Berstatus(),
      },
    );
  }
}
