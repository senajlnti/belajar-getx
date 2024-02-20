import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/payment_controller.dart';

class PaymentView extends StatelessWidget {
  final PaymentController paymentController = PaymentController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Membership'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: 500,
                  height: 720,
                  decoration: BoxDecoration(
                    
                    borderRadius: BorderRadius.circular(
                        15), // Atur radius sesuai keinginan
                    border: Border.all(
                      color: Colors.grey, // Warna outline
                      width: 2.0, // Lebar outline
                    ),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Nama Lengkap',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  10), // Atur radius sesuai keinginan
                            ),
                          ),
                          onChanged: (value) =>
                              paymentController.namaLengkap.value = value,
                        ),
                        SizedBox(height: 16.0),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Tempat Lahir',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onChanged: (value) =>
                              paymentController.tempatLahir.value = value,
                        ),
                        SizedBox(height: 16.0),
                        InkWell(
                          onTap: () => paymentController.selectDate(context),
                          child: InputDecorator(
                            decoration: InputDecoration(
                              labelText: 'Tanggal Lahir',
                              hintText: 'Pilih Tanggal',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Obx(() =>
                                    Text(paymentController.selectedDate.value)),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Text('Jenis Kelamin'),
                        Row(
                          children: [
                            Obx(() => Radio(
                                  value: 'Laki-laki',
                                  groupValue:
                                      paymentController.jenisKelamin.value,
                                  onChanged: (value) => paymentController
                                      .jenisKelamin.value = value!,
                                )),
                            Text('Laki-laki'),
                            Obx(() => Radio(
                                  value: 'Perempuan',
                                  groupValue:
                                      paymentController.jenisKelamin.value,
                                  onChanged: (value) => paymentController
                                      .jenisKelamin.value = value!,
                                )),
                            Text('Perempuan'),
                          ],
                        ),
                        SizedBox(height: 16.0),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onChanged: (value) =>
                              paymentController.email.value = value,
                        ),
                        SizedBox(height: 16.0),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Negara',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onChanged: (value) =>
                              paymentController.negara.value = value,
                        ),
                        SizedBox(height: 16.0),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Nomor Kartu',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onChanged: (value) =>
                              paymentController.cardnumber.value = value,
                        ),
                        SizedBox(height: 16.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Tipe Member :',
                              style: TextStyle(fontSize: 16.0),
                            ),
                            SizedBox(height: 8.0),
                           Wrap(
                            children: paymentController.getTipeMemberList().map((member) {
                              bool isSelected = paymentController.member.contains(member);

                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                child: ElevatedButton(
                                  onPressed: () => paymentController.toggleMemberList(member),
                                  
                                  child: Text(
                                    member,
                                    style: TextStyle(
                                      color: isSelected ? Colors.white : Colors.black,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                            SizedBox(height: 16.0),
                          ],
                        ),
                        SizedBox(height: 16.0),
                        Obx(() => Text(
                            'Harga : ${paymentController.totalPembayaran.value}')),
                        Obx(() => Text(
                            'Benefit : ${paymentController.getDeskripsiMembership()}')),
                        SizedBox(height: 16.0),
                        ElevatedButton(
                          onPressed: () =>
                              paymentController.submitForm(context),
                          child: Text('Submit'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}