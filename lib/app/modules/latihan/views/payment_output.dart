import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_getx/app/modules/latihan/controllers/payment_controller.dart';

class PaymentOutput extends StatelessWidget {
  final Map<String, dynamic> dataFormulir;
  final PaymentController paymentController = Get.put(PaymentController());

  PaymentOutput({Key? key, required this.dataFormulir}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Output Payment'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: GetBuilder<PaymentController>(
          builder: (controller) {
            return Card(
              elevation: 4.0,
              margin: EdgeInsets.all(8.0),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Informasi Pribadi:',
                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    Divider(),
                    buildInfoCard('Nama', dataFormulir['namaLengkap']),
                    buildInfoCard(
                      'Tempat & Tanggal Lahir',
                      '${dataFormulir['tempatLahir']}, ${dataFormulir['selectedDate']}',
                    ),
                    buildInfoCard('Umur', '${dataFormulir['umur']} tahun'),
                    buildInfoCard('Jenis Kelamin', dataFormulir['jenisKelamin']),
                    buildInfoCard('Email', dataFormulir['email']),
                    buildInfoCard('Tipe Member', dataFormulir['member']),
                    buildInfoCard('Benefit', dataFormulir['deskripsi']),
                    SizedBox(height: 16.0),
                    Text(
                      'Pembayaran Details:',
                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    Divider(),
                    buildInfoCard('Expired-Date', dataFormulir['expired-date']),
                    buildInfoCard(
                      'Total Pembayaran',
                      'Rp ${dataFormulir['totalPembayaran']}',
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildInfoCard(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value),
        ],
      ),
    );
  }
}