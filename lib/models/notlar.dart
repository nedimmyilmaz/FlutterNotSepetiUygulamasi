class Not {
  int notID, kategoriID, oncelik;
  String notBaslik, notIcerik, tarih;

  Not(this.kategoriID, this.oncelik, this.notBaslik, this.notIcerik,
      this.tarih);

  Not.withID(this.notID, this.kategoriID, this.oncelik, this.notBaslik,
      this.notIcerik, this.tarih);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["notID"] = notID;
    map["kategoriID"] = kategoriID;
    map["oncelik"] = oncelik;
    map["notBaslik"] = notBaslik;
    map["notIcerik"] = notIcerik;
    map["tarih"] = tarih;
  }

  Not.fromMap(Map<String, dynamic> map) {
    this.notID = map["notID"];
    this.kategoriID = map["kategoriID"];
    this.oncelik = map["oncelik"];
    this.notBaslik = map["notBaslik"];
    this.notIcerik = map["notIcerik"];
    this.tarih = map["tarih"];
  }

  @override
  String toString() {
    return 'Not{notID: $notID, kategoriID: $kategoriID, oncelik: $oncelik, notBaslik: $notBaslik, notIcerik: $notIcerik, tarih: $tarih}';
  }
}
