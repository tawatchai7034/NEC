class qtyMoveResp {
  String? barcode;
  String? defaultOption;
  String? partNo;
  String? partDesc;
  String? lotNo;
  String? locationFrom;
  String? locationTo;
  double? qtyAvailable;
  double? qtyMove;
  String? errorMessage;

  qtyMoveResp(
      {this.barcode,
      this.defaultOption,
      this.partNo,
      this.partDesc,
      this.lotNo,
      this.locationFrom,
      this.locationTo,
      this.qtyAvailable,
      this.qtyMove,
      this.errorMessage});

  qtyMoveResp.fromJson(Map<String, dynamic> json) {
    barcode = json['Barcode'];
    defaultOption = json['DefaultOption'];
    partNo = json['PartNo'];
    partDesc = json['PartDesc'];
    lotNo = json['LotNo'];
    locationFrom = json['LocationFrom'];
    locationTo = json['LocationTo'];
    qtyAvailable = json['QtyAvailable'];
    qtyMove = json['QtyMove'];
    errorMessage = json['ErrorMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Barcode'] = this.barcode;
    data['DefaultOption'] = this.defaultOption;
    data['PartNo'] = this.partNo;
    data['PartDesc'] = this.partDesc;
    data['LotNo'] = this.lotNo;
    data['LocationFrom'] = this.locationFrom;
    data['LocationTo'] = this.locationTo;
    data['QtyAvailable'] = this.qtyAvailable;
    data['QtyMove'] = this.qtyMove;
    data['ErrorMessage'] = this.errorMessage;
    return data;
  }
}