import 'package:flutter/material.dart';
import 'dart:io';

enum MailStatus {
  pending,
  approved,
  declined,
}

class MailItem {
  final String nama;
  final String isi;
  final String kategori;
  final DateTime dateTime;
  MailStatus status;
  String? alasan;
  String? imagePath;
  bool isDefaultImage;
  bool isExpanded;
  bool isStarred;

  MailItem({
    required this.nama,
    required this.isi,
    this.kategori = 'Personal',
    required this.dateTime,
    this.status = MailStatus.pending,
    this.alasan,
    this.imagePath,
    this.isDefaultImage = false,
    this.isExpanded = false,
    this.isStarred = false,
  });
}

class MailProvider with ChangeNotifier {
  List<MailItem> _mailss = [];
  List<MailItem> get mailss => _mailss;
  List<MailItem> get pendingMails =>
      _mailss.where((mail) => mail.status == MailStatus.pending).toList();
  List<MailItem> get approvedMails =>
      _mailss.where((mail) => mail.status == MailStatus.approved).toList();
  List<MailItem> get declinedMails =>
      _mailss.where((mail) => mail.status == MailStatus.declined).toList();
  List<MailItem> get starredMails =>
      _mailss.where((mail) => mail.isStarred).toList();

  MailProvider() {
    _mailss = [
      MailItem(
        nama: 'Surat jalan X',
        isi: 'Perjalanan karyawan X',
        kategori: 'Work',
        status: MailStatus.approved,
        isDefaultImage: true,
        isStarred: true,
        dateTime: DateTime.now(),
      ),
      MailItem(
        nama: 'Surat pengunduran diri Z',
        isi: 'Pengunduran diri karyawan Z',
        kategori: 'Work',
        status: MailStatus.declined,
        alasan: "perusahaan sedang butuh karyawan",
        isDefaultImage: true,
        isStarred: true,
        dateTime: DateTime.now(),
      ),
      MailItem(
        nama: 'Surat Selamat Ultah',
        isi: 'Selamat Ultah',
        kategori: 'Personal',
        status: MailStatus.approved,
        isDefaultImage: true,
        dateTime: DateTime.now(),
      ),
      MailItem(
        nama: 'Surat izin A',
        isi: 'Izin sakit karyawan A',
        kategori: 'Work',
        status: MailStatus.pending,
        isDefaultImage: true,
        isStarred: true,
        dateTime: DateTime.now(),
      ),
      MailItem(
        nama: 'Surat izin B',
        isi: 'Izin sakit karyawan B',
        kategori: 'Work',
        status: MailStatus.pending,
        isDefaultImage: true,
        isStarred: true,
        dateTime: DateTime.now(),
      ),
      MailItem(
        nama: 'Surat izin C',
        isi: 'Izin sakit karyawan C',
        kategori: 'Work',
        status: MailStatus.pending,
        isDefaultImage: true,
        dateTime: DateTime.now(),
      ),
    ];
  }

  Future<void> addMail(MailItem mail) async {
    await Future.delayed(const Duration(seconds: 1));
    _mailss.add(mail);
    notifyListeners();
  }

  Future<void> addMailWithImage(MailItem mail, File imageFile) async {
    await Future.delayed(const Duration(seconds: 1));
    String imagePath = imageFile.path;
    mail.imagePath = imagePath;
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
      if (newStatus == MailStatus.declined) {
        _mailss[mailIndex].alasan = alasan;
      }
      notifyListeners();
    }
  }

  void toggleMailExpansion(String nama) {
    final mailIndex = _mailss.indexWhere((mail) => mail.nama == nama);
    if (mailIndex != -1) {
      _mailss[mailIndex].isExpanded = !_mailss[mailIndex].isExpanded;
      notifyListeners();
    }
  }

  void toggleMailStar(String nama) {
    final mailIndex = _mailss.indexWhere((mail) => mail.nama == nama);
    if (mailIndex != -1) {
      _mailss[mailIndex].isStarred = !_mailss[mailIndex].isStarred;
      notifyListeners();
    }
  }
}
