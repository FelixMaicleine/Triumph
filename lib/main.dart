import 'package:flutter/material.dart';
import 'package:triumph2/pages/approvedadmin.dart';
import 'package:triumph2/pages/declinedadmin.dart';
import 'package:triumph2/pages/draft.dart';
import 'package:triumph2/pages/editprofileadmin.dart';
import 'package:triumph2/pages/favadmin.dart';
import 'package:triumph2/pages/favuser.dart';
import 'package:triumph2/pages/inboxuser.dart';
import 'package:triumph2/pages/editprofileuser.dart';
import 'package:triumph2/pages/homea.dart';
import 'package:triumph2/pages/homeu.dart';
import 'package:triumph2/pages/mailsadmin.dart';
import 'package:triumph2/pages/loginadmin.dart';
import 'package:triumph2/pages/pendingadmin.dart';
import 'package:triumph2/pages/outboxuser.dart';
import 'package:triumph2/pages/peran.dart';
import 'package:triumph2/pages/profileadmin.dart';
import 'package:triumph2/pages/profileuser.dart';
import 'package:triumph2/pages/landing.dart';
import 'package:triumph2/pages/loginuser.dart';
import 'package:triumph2/pages/register.dart';
import 'package:triumph2/pages/forgotpass.dart';
import 'package:triumph2/pages/trash.dart';
import 'package:triumph2/pages/verifcode.dart';
import 'package:triumph2/pages/changepass.dart';
import 'package:triumph2/pages/mailsuser.dart';
import 'package:triumph2/pages/createmail.dart';

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
        '/forgot': (context) => ForgotPass(),
        '/verify': (context) => VerifCode(),
        '/change': (context) => ChangePass(),
        '/register': (context) => Register(),
        '/homeuser': (context) => HomeU(),
        '/homeadmin': (context) => HomeA(),
        '/mailsuser': (context) => MailsUser(),
        '/mailsadmin': (context) => MailsAdmin(),
        '/create': (context) => CreateMail(),
        '/profileuser': (context) => ProfileUser(),
        '/profileadmin': (context) => ProfileAdmin(),
        '/editprofileuser': (context) => EditProfileUser(),
        '/editprofileadmin': (context) => EditProfileAdmin(),
        '/pendingadmin': (context) => PendingAdmin(),
        '/approvedadmin': (context) => ApprovedAdmin(),
        '/notapprovedadmin': (context) => DeclinedAdmin(),
        '/berstatususer': (context) => InboxUser(),
        '/pendinguser': (context) => OutboxUser(),
        '/favadmin': (context) => FavAdmin(),
        '/favuser': (context) => FavUser(),
        '/trash': (context) => Trash(),
        '/draft': (context) => Draft(),
      },
    );
  }
}

// tes 
