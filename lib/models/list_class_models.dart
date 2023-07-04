class KelasModel {
  String nip;
  String nama;
  String kodeKelas;

  KelasModel({required this.nip, required this.nama, required this.kodeKelas});

  factory KelasModel.fromJson(Map<String, dynamic> json) {
    return KelasModel(
      nip: json['nip'],
      nama: json['nama'],
      kodeKelas: json['kodeKelas'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nip': nip,
      'nama': nama,
      'kodeKelas': kodeKelas,
    };
  }
}
