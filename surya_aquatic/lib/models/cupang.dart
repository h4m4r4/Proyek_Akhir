class Cupang {
  final String nama;
  final String jenis;
  final String gambar;
  final String deskripsi;
  bool isfavorite;

  Cupang({
    required this.nama,
    required this.jenis,
    required this.gambar,
    required this.deskripsi,
    this.isfavorite = false,
  });
}
