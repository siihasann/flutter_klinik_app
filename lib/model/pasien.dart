class Pasien {
   int? id;
   String nama;
   String noRm;
   DateTime tanggalLahir;
   String nomorTelepon;
   String alamat;

  Pasien(
      {this.id,
      required this.nama,
      required this.noRm,
      required this.tanggalLahir,
      required this.nomorTelepon,
      required this.alamat});

  factory Pasien.fromJson(Map<String, dynamic> json)=> 
    Pasien(
      id: json['id'],
      nama: json['Nama Pegawai'],
      noRm: json['Nomor Rm'],
      tanggalLahir: DateTime.parse(json["Tanggal Lahir"]),
      nomorTelepon: json['Nomor Telepon'],
      alamat: json['Alamat'],
    );

     Map<String, dynamic> toJson() => {
        "nama": nama,
        "Tanggal Lahir": tanggalLahir,
        "Nomor Telepon": nomorTelepon,
        "Alamat": alamat,
      };
  }

