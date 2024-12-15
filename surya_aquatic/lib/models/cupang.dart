class Cupang {
  final String nama;
  final String jenis;
  final String gambar;
  final String deskripsi;
  final String harga;
  bool isfavorite;

  Cupang({
    required this.nama,
    required this.jenis,
    required this.gambar,
    required this.deskripsi,
    required this.harga,
    this.isfavorite = false,
  });
}
