class MenuPermissionResponse {
  bool countPerInventoryPart = false;
  bool countPerCountReport = false;
  bool reportPicking = false;
  bool confirmDelivery = false;
  bool stockInquiry = false;

  MenuPermissionResponse(
      {required this.countPerInventoryPart,
      required this.countPerCountReport,
      required this.reportPicking,
      required this.confirmDelivery,
      required this.stockInquiry});

  MenuPermissionResponse.fromJson(Map<String, dynamic> json) {
    countPerInventoryPart = json['CountPerInventoryPart'];
    countPerCountReport = json['CountPerCountReport'];
    reportPicking = json['ReportPicking'];
    confirmDelivery = json['ConfirmDelivery'];
    stockInquiry = json['StockInquiry'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CountPerInventoryPart'] = this.countPerInventoryPart;
    data['CountPerCountReport'] = this.countPerCountReport;
    data['ReportPicking'] = this.reportPicking;
    data['ConfirmDelivery'] = this.confirmDelivery;
    data['StockInquiry'] = this.stockInquiry;
    return data;
  }
}
