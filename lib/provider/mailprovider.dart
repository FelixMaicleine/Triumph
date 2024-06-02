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
  String? alasan;

  MailItem({
    required this.nama,
    required this.isi,
    this.kategori = 'Personal',
    this.status = MailStatus.pending,
    this.alasan,
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
        nama: 'Surat Selamat Ultah',
        isi: 'Selamat Ultah',
        kategori: 'Personal',
        status: MailStatus.approved,
      ),
      MailItem(
          nama: 'Surat pengunduran diri',
          isi: 'Surat pengunduran diri karyawan Z',
          kategori: 'Work',
          status: MailStatus.notApproved,
          alasan: "perusahaan sedang butuh karyawan"),
      MailItem(
        nama: 'Surat izin A',
        isi: 'Surat izin sakit karyawan A',
        kategori: 'Work',
        status: MailStatus.pending,
      ),
      MailItem(
        nama: 'Surat izin B',
        isi: 'Surat izin sakit karyawan B',
        kategori: 'Work',
        status: MailStatus.pending,
      ),
      MailItem(
        nama: 'Surat izin C',
        isi: 'Surat izin sakit karyawan C',
        kategori: 'Work',
        status: MailStatus.pending,
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

  void changeMailStatus(String nama, MailStatus newStatus, {String? alasan}) {
    final mailIndex = _mailss.indexWhere((mail) => mail.nama == nama);
    if (mailIndex != -1) {
      _mailss[mailIndex].status = newStatus;
      if (newStatus == MailStatus.notApproved) {
        _mailss[mailIndex].alasan = alasan;
      }
      notifyListeners();
    }
  }
}
