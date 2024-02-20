import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PaymentController extends GetxController {
  var namaLengkap = ''.obs;
  var tempatLahir = ''.obs;
  var tanggalLahir = ''.obs;
  var jenisKelamin = ''.obs;
  var email = ''.obs;
  var negara = ''.obs;
  var cardnumber = ''.obs;
  var paymentExpired = ''.obs;
  final List<String> memberList = ['Reguler', 'Gold', 'Platinum', 'Vip'];
  var member = <String>[].obs;
  var isFormSubmitted = false.obs;
  var selectedDate = ''.obs;
  var totalPembayaran = 0.0.obs;
  var selectedMember = ''.obs;
  var deskripsi = ''.obs;

  List<String> getTipeMemberList() => memberList;

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      final formattedDate = DateFormat('yyyy-MM-dd').format(picked);
      selectedDate.value = formattedDate; // simpan tanggal dipilih
    }
  }

  Future<void> selectPaymentExpired() async {
    DateTime currentDate = DateTime.now();
    final formattedDate =
        DateFormat('yyyy-MM-dd').format(currentDate.add(Duration(days: 7)));
    paymentExpired.value =
        formattedDate; // simpan tanggal dipilih ditambah 7 hari
  }

  // Tambahkan fungsi untuk menghitung tanggal kadaluwarsa secara otomatis
  void calculateAutoPaymentExpired() {
    DateTime currentDate = DateTime.now();
    final formattedDate =
        DateFormat('yyyy-MM-dd').format(currentDate.add(Duration(days: 7)));
    paymentExpired.value =
        formattedDate; // simpan tanggal kadaluwarsa secara otomatis
  }

  void toggleMemberList(String memberValue) {
    if (member.contains(memberValue)) {
      member.clear();
    } else {
      member.clear();
      member.add(memberValue);
    }
    selectedMember.value = memberValue;
    totalPembayaran.value = TotalPembayaran();
    deskripsi.value = getDeskripsiMembership();
  }

  double TotalPembayaran() {
    if (selectedMember.value == 'Reguler') {
      return 50000;
    } else if (selectedMember.value == 'Gold') {
      return 150000;
    } else if (selectedMember.value == 'Platinum') {
      return 250000;
    } else if (selectedMember.value == 'Vip') {
      return 500000;
    } else {
      return 0;
    }
  }

  String getDeskripsiMembership() {
    switch (selectedMember.value) {
      case 'Reguler':
        return 'mendapatkan 1 bulan membership.';
      case 'Gold':
        return 'mendapatkan 1 bulan membership dan mendapatkan cemilan gratis.';
      case 'Platinum':
        return 'mendapatkan 2 bulan membership, cemilan, dan free wifi.';
      case 'Vip':
        return 'mendapatkan 3 bulan membership, cemilan, free wifi, dan tiket konser.';
      default:
        return '';
    }
  }

  void submitForm(BuildContext context) async {
    isFormSubmitted.value = true;

    // Validasi formulir
    if (!validateForm()) {
      // Jika validasi gagal, keluar dari fungsi
      return;
    }

    // Menghitung tanggal kadaluwarsa secara otomatis
    calculateAutoPaymentExpired();

    // Menampilkan indikator loading
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);

    // Menghitung umur berdasarkan tanggal lahir
    DateTime birthDate = DateFormat('yyyy-MM-dd').parse(selectedDate.value);
    DateTime now = DateTime.now();
    int age = now.year -
        birthDate.year -
        (now.month > birthDate.month ||
                (now.month == birthDate.month && now.day >= birthDate.day)
            ? 0
            : 1);

    // Menyiapkan data formulir untuk dikirim
    var dataFormulir = {
      'namaLengkap': namaLengkap.value,
      'tempatLahir': tempatLahir.value,
      'selectedDate': selectedDate.value,
      'umur': age.toString(), // Menambahkan umur ke dalam data formulir
      'jenisKelamin': jenisKelamin.value,
      'email': email.value,
      'member': member.join(', '),
      'expired-date': paymentExpired.value,
      'totalPembayaran': totalPembayaran.value.toString(),
      'deskripsi': getDeskripsiMembership(),
    };

    

    // Tutup indikator loading
    Get.back();

    // Pindah ke halaman PaymentOutput dengan menyertakan dataFormulir
    Get.toNamed('/payment_output', arguments: dataFormulir);
  }

// Fungsi untuk validasi formulir
  bool validateForm() {
    if (namaLengkap.value.isEmpty ||
        tempatLahir.value.isEmpty ||
        selectedDate.value.isEmpty ||
        jenisKelamin.value.isEmpty ||
        email.value.isEmpty ||
        member.isEmpty) {
      // Menampilkan pesan error jika ada field yang kosong
      Get.snackbar(
        'Peringatan',
        'Field harus di isi semua!',
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 2),
        icon: Icon(Icons.warning),
        backgroundColor: Colors.red,
      );
      return false;
    }

    // Implementasi validasi lainnya sesuai kebutuhan

    return true;
  }
}