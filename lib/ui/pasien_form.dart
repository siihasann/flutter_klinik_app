import 'package:flutter/material.dart';
import '../model/pasien.dart';
import '../service/pasien_service.dart';
import 'pasien_detail.dart';

class PasienForm extends StatefulWidget {
  const PasienForm({Key? key}) : super(key: key);
  _PasienFormState createState() => _PasienFormState();
}

class _PasienFormState extends State<PasienForm> {
  final _formKey = GlobalKey<FormState>();
  final _namaPasienCtrl = TextEditingController();
  final _noRmCtrl = TextEditingController();
  final _tanggalLahirCtrl = TextEditingController();
  final _nomorTeleponCtrl = TextEditingController();
  final _alamatCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tambah Pasien")),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _fieldNamaPasien(),
              _fieldNoRM(),
              _fieldTanggalLahir(),
              _fieldNomorTelepon(),
              _fieldAlamat(),
              const SizedBox(height: 20), 
              _tombolSimpan()
              ],
          ),
        ),
      ),
    );
  }

  _fieldNamaPasien() {
    return TextField(
      decoration: const InputDecoration(labelText: "Nama Pasien"),
      controller: _namaPasienCtrl,
    );
  }
  _fieldNoRM() {
    return TextField(
      decoration: const InputDecoration(labelText: "No Rekam Medis"),
      controller: _noRmCtrl,
    );
  }
  _fieldTanggalLahir() {
    return TextField(
      decoration: const InputDecoration(labelText: "Tanggal Lahir"),
      controller: _tanggalLahirCtrl,
      onTap: () {
        showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        ).then((selectedDate) {
          if (selectedDate != null) {
            setState(() {
              final formattedDate =
                  "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";
              _tanggalLahirCtrl.text = formattedDate;
            });
          }
        });
      },
      readOnly: true,
    );
  }
  _fieldNomorTelepon() {
    return TextField(
      decoration: const InputDecoration(labelText: "Nomor Telepon"),
      controller: _nomorTeleponCtrl,
    );
  }
  _fieldAlamat() {
    return TextField(
      decoration: const InputDecoration(labelText: "Alamat"),
      controller: _alamatCtrl,
    );
  }

  _tombolSimpan() {
    return ElevatedButton(
      onPressed: () async {
        Pasien pasien = new Pasien(
          noRm: _noRmCtrl.text,
          nama: _namaPasienCtrl.text,
          tanggalLahir: DateTime.parse(_tanggalLahirCtrl.text),
          nomorTelepon: _nomorTeleponCtrl.text,
          alamat: _alamatCtrl.text,
          );
        await PasienService().simpan(pasien).then((value) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => PasienDetail(pasien: value),
            ),
          );
        });
      },
      child: const Text("Simpan"),
    );
  }
}
