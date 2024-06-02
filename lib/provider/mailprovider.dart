import 'package:flutter/material.dart';

enum MailStatus {
  pending,
  approved,
  notApproved,
}

class MailItem {
  final String nama;
  final String isi;
  final String kategori;
  MailStatus status;

  MailItem({
    required this.nama,
    required this.isi,
    this.kategori = 'Personal',
    this.status = MailStatus.pending,
  });
}

class MailProvider with ChangeNotifier {
  List<MailItem> _mailss = [];

  List<MailItem> get mailss => _mailss;

  List<MailItem> get pendingMails =>
      _mailss.where((mail) => mail.status == MailStatus.pending).toList();

  List<MailItem> get approvedMails =>
      _mailss.where((mail) => mail.status == MailStatus.approved).toList();

  List<MailItem> get notApprovedMails =>
      _mailss.where((mail) => mail.status == MailStatus.notApproved).toList();

  MailProvider() {
    _mailss = [
      MailItem(
        nama: 'Surat izin',
        isi: 'Surat izin sakit karyawan A',
        kategori: 'Work',
        status: MailStatus.pending,
      ),
      MailItem(
        nama: 'Surat pengunduran diri',
        isi: 'Surat pengunduran diri karyawan B',
        kategori: 'Work',
        status: MailStatus.notApproved,
      ),
      MailItem(
        nama: 'Surat Selamat Ultah',
        isi: 'Selamat Ultah',
        kategori: 'Personal',
        status: MailStatus.approved,
      ),
    ];
  }

  void addMail(MailItem mail) {
    _mailss.add(mail);
    notifyListeners();
  }

  void deleteMail(String nama) {
    _mailss.removeWhere((mail) => mail.nama == nama);
    notifyListeners();
  }

  void changeMailStatus(String nama, MailStatus newStatus) {
    final mailIndex = _mailss.indexWhere((mail) => mail.nama == nama);
    if (mailIndex != -1) {
      _mailss[mailIndex].status = newStatus;
      notifyListeners();
    }
  }
}
