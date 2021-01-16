class Kategori {
  int kategoriID;
  String kategoriAdi;

  Kategori(this.kategoriAdi);

  Kategori.withID(this.kategoriID, this.kategoriAdi);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["kategoriID"] = kategoriID;
    map["kategoriAdi"] = kategoriAdi;

    return map;
  }

  Kategori.fomMap(Map<String, dynamic> map) {
    this.kategoriID = map["kategoriID"];
    this.kategoriAdi = map["kategoriAdi"];
  }

  @override
  String toString() {
    return 'Kategori{kategoriID: $kategoriID, kategoriAdi: $kategoriAdi}';
  }
}
