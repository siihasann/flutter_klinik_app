import 'package:flutter/material.dart';
import '../model/pegawai.dart';
import '../service/pegawai_service.dart';
import 'pegawai_detail.dart';

class PegawaiUpdateForm extends StatefulWidget {
  final Pegawai pegawai;

  const PegawaiUpdateForm({Key? key, required this.pegawai}) : super(key: key);
  _PegawaiUpdateFormState createState() => _PegawaiUpdateFormState();
}

class _PegawaiUpdateFormState extends State<PegawaiUpdateForm> {
  final _formKey = GlobalKey<FormState>();
  final _namaPegawaiCtrl = TextEditingController();
  final _nipCtrl = TextEditingController();
  final _tanggalLahirCtrl = TextEditingController();
  final _nomorTeleponCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  Future<Pegawai> getData() async {
    Pegawai data = await PegawaiService().getById(widget.pegawai.id.toString());
    setState(() {
      if (data.nip != null) {
        _nipCtrl.text = data.nip;
      }
      if (data.nama != null) {
        _namaPegawaiCtrl.text = data.nama;
      }
       if (data.tanggalLahir != null) {
        final formattedDate =
            "${data.tanggalLahir.year}-${data.tanggalLahir.month.toString().padLeft(2, '0')}-${data.tanggalLahir.day.toString().padLeft(2, '0')}";
        _tanggalLahirCtrl.text = formattedDate;
      }
      if (data.nomorTelepon != null) {
        _nomorTeleponCtrl.text = data.nomorTelepon;
      }
      if (data.email != null) {
        _emailCtrl.text = data.email;
      }
      if (data.password != null) {
        _passwordCtrl.text = data.password;
      }
    });
    return data;
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ubah Pegawai")),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _fieldNamaPegawai(),
              _fieldNip(),
              _fieldTanggalLahir(),
              _fieldNomorTelepon(),
              _fieldEmail(),
              _fieldPassword(), 
              SizedBox(height: 20), 
              _tombolSimpan()],
          ),
        ),
      ),
    );
  }

  _fieldNamaPegawai() {
    return TextField(
      decoration: const InputDecoration(labelText: "Nama Pegawai"),
      controller: _namaPegawaiCtrl,
    );
  }
  _fieldNip() {
    return TextField(
      decoration: const InputDecoration(labelText: "NIP"),
      controller: _nipCtrl,
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
  _fieldEmail() {
    return TextField(
      decoration: const InputDecoration(labelText: "Email"),
      controller: _emailCtrl,
    );
  }
  _fieldPassword() {
    return TextField(
      decoration: const InputDecoration(labelText: "Password"),
      controller: _emailCtrl,
    );
  }

  _tombolSimpan() {
    return ElevatedButton(
      onPressed: () async {
        Pegawai pegawai = new Pegawai(
          nip: _nipCtrl.text,
          nama: _namaPegawaiCtrl.text,
          tanggalLahir: DateTime.parse(_tanggalLahirCtrl.text),
          nomorTelepon: _nomorTeleponCtrl.text,
          email: _emailCtrl.text,
          password: _passwordCtrl.text,
          );
        await PegawaiService().simpan(pegawai).then((value) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => PegawaiDetail(pegawai: value),
            ),
          );
        });
      },
      child: const Text("Simpan"),
    );
  }
}
