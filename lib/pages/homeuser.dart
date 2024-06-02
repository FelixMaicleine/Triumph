// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, library_private_types_in_public_api, prefer_final_fields, prefer_const_literals_to_create_immutables, use_super_parameters

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:triumph2/provider/theme.dart';
import 'package:triumph2/provider/mailprovider.dart';

class HomeUser extends StatefulWidget {
  @override
  _HomeUser createState() => _HomeUser();
}

class _HomeUser extends State<HomeUser> {
  late List<MailItem> _filteredmailss;
  late String _selectedFilter;
  late String _searchQuery;

  @override
  void initState() {
    super.initState();
    _selectedFilter = 'All';
    _searchQuery = '';
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final ThemeData themeData = themeProvider.getCurrentTheme();
    final Color textColor = themeData.textTheme.bodyLarge!.color!;
    final Color bottomNavBarColor =
        themeProvider.enableDarkMode ? Colors.grey.shade900 : Colors.white;
    final Color bottomNavBarIconColor =
        themeProvider.enableDarkMode ? Colors.white : Colors.black;
    final Color chipBackgroundColor = themeProvider.enableDarkMode
        ? Colors.grey.shade700
        : Colors.grey.shade300;
    final Color chipSelectedColor = themeProvider.enableDarkMode
        ? Colors.red.shade800
        : Colors.red.shade400;
    final Color chipLabelColor =
        themeProvider.enableDarkMode ? Colors.white : Colors.black;

    final mailProvider = Provider.of<MailProvider>(context);
    _filteredmailss = _getFilteredMails(mailProvider.mailss);

    final pendingMails = _filteredmailss
        .where((mail) => mail.status == MailStatus.pending)
        .toList();
    final approvedMails = _filteredmailss
        .where((mail) => mail.status == MailStatus.approved)
        .toList();
    final notApprovedMails = _filteredmailss
        .where((mail) => mail.status == MailStatus.notApproved)
        .toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            themeProvider.enableDarkMode ? Colors.grey.shade900 : Colors.white,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(
              Icons.menu,
              color: textColor,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        title: Image.asset(
          'assets/logo.png',
          width: 250,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              themeProvider.enableDarkMode = !themeProvider.enableDarkMode;
            },
            icon: Icon(
              themeProvider.enableDarkMode
                  ? Icons.wb_sunny
                  : Icons.nightlight_round,
              color:
                  themeProvider.enableDarkMode ? Colors.yellow : Colors.black,
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: Container(
            color: themeProvider.enableDarkMode
                ? Colors.grey.shade900
                : Colors.white,
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: <Widget>[
                      DrawerHeader(
                        decoration: BoxDecoration(
                          color: themeProvider.enableDarkMode
                              ? Colors.grey.shade800
                              : Colors.red,
                        ),
                        padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 40.0,
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.person,
                                size: 50.0,
                                color: Colors.red,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'John Doe',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.person,
                          color: textColor,
                        ),
                        title: Text(
                          'Profile',
                          style: TextStyle(color: textColor),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, '/profile');
                        },
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.mail,
                          color: textColor,
                        ),
                        title: Text(
                          'Surat Masuk',
                          style: TextStyle(color: textColor),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, '/berstatus');
                        },
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.send,
                          color: textColor,
                        ),
                        title: Text(
                          'Surat Keluar',
                          style: TextStyle(color: textColor),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, '/pendinguser');
                        },
                      ),
                    ],
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.logout,
                    color: textColor,
                  ),
                  title: Text(
                    'Logout',
                    style: TextStyle(color: textColor),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/');
                  },
                ),
              ],
            )),
      ),
      body: Container(
        height: 5000,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: themeProvider.enableDarkMode
                ? [Colors.grey.shade800, Colors.red.shade800]
                : [Colors.red.shade200, Colors.red.shade400],
          ),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 110.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Surat Masuk',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: approvedMails.length + notApprovedMails.length,
                      itemBuilder: (context, index) {
                        if (index < approvedMails.length) {
                          return _buildMailCard(approvedMails[index], textColor,
                              themeProvider, mailProvider);
                        } else {
                          final notApprovedIndex = index - approvedMails.length;
                          return _buildMailCard(
                              notApprovedMails[notApprovedIndex],
                              textColor,
                              themeProvider,
                              mailProvider);
                        }
                      },
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Surat Keluar',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: pendingMails.length,
                      itemBuilder: (context, index) {
                        final mails = pendingMails[index];
                        return _buildMailCard(
                            mails, textColor, themeProvider, mailProvider);
                      },
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search, color: textColor),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: textColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: textColor),
                      ),
                    ),
                    style: TextStyle(color: textColor),
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                  ),
                  SizedBox(height: 15),
                  Wrap(
                    spacing: 8.0,
                    children: [
                      _buildFilterChip('All', chipLabelColor,
                          chipBackgroundColor, chipSelectedColor),
                      _buildFilterChip('Personal', chipLabelColor,
                          chipBackgroundColor, chipSelectedColor),
                      _buildFilterChip('Work', chipLabelColor,
                          chipBackgroundColor, chipSelectedColor),
                      _buildFilterChip('Others', chipLabelColor,
                          chipBackgroundColor, chipSelectedColor),
                    ],
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: bottomNavBarColor,
        selectedItemColor: Colors.red,
        unselectedItemColor: bottomNavBarIconColor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail),
            label: 'Buat Surat',
          ),
        ],
        onTap: (int index) {
          if (index == 1) {
            Navigator.pushNamed(context, '/create');
          }
        },
      ),
    );
  }

  List<MailItem> _getFilteredMails(List<MailItem> mailss) {
    return mailss.where((mails) {
      final matchesFilter =
          _selectedFilter == 'All' || mails.kategori == _selectedFilter;
      final matchesSearch =
          mails.nama.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesFilter && matchesSearch;
    }).toList();
  }

  Widget _buildMailCard(MailItem mail, Color textColor,
      ThemeProvider themeProvider, MailProvider mailProvider) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      color: themeProvider.enableDarkMode ? Colors.grey.shade700 : Colors.white,
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  mail.nama,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.circle,
                      color: mail.status == MailStatus.pending
                          ? Colors.grey
                          : mail.status == MailStatus.approved
                              ? Colors.green
                              : Colors.red,
                      size: 12,
                    ),
                    SizedBox(width: 5),
                    Text(
                      mail.status == MailStatus.pending
                          ? 'Pending'
                          : mail.status == MailStatus.approved
                              ? 'Approved'
                              : 'Not Approved',
                      style: TextStyle(color: textColor),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 5),
            Text(
              'Isi: ${mail.isi}',
              style: TextStyle(color: textColor),
            ),
            Text(
              'Kategori: ${mail.kategori}',
              style: TextStyle(color: textColor),
            ),
            if (mail.status == MailStatus.notApproved && mail.alasan != null)
              Text(
                'Alasan : ${mail.alasan}',
                style: TextStyle(color: Colors.red),
              ),
            if (mail.status == MailStatus.notApproved && mail.alasan == null)
              Text(
                'Surat tidak disetujui tanpa alasan.',
                style: TextStyle(color: Colors.red),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    _showDeleteConfirmationDialog(
                        context, mail.nama, mailProvider);
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  FilterChip _buildFilterChip(String label, Color chipLabelColor,
      Color chipBackgroundColor, Color chipSelectedColor) {
    return FilterChip(
      label: Text(label),
      labelStyle: TextStyle(color: chipLabelColor),
      backgroundColor: chipBackgroundColor,
      selectedColor: chipSelectedColor,
      selected: _selectedFilter == label,
      onSelected: (isSelected) {
        setState(() {
          _selectedFilter = label;
        });
      },
    );
  }

  void _showDeleteConfirmationDialog(
      BuildContext context, String nama, MailProvider mailProvider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi'),
          content: Text('Apakah Anda yakin ingin menghapus surat ini?'),
          actions: <Widget>[
            TextButton(
              child: Text('Tidak'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Ya'),
              onPressed: () {
                mailProvider.deleteMail(nama);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
