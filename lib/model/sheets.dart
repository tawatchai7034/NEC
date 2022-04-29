class SheetModel{
  final String PartNo;
  final String LocF;
  final String LocT;
  final int Qty;

  const SheetModel({
    required this.PartNo,
    required this.LocF,
    required this.LocT,
    required this.Qty,
  });

  SheetModel copy({
    String? PartNo,
    String? LocF,
    String? LocT,
    int? Qty,
  }) =>
      SheetModel(
        PartNo: PartNo ?? this.PartNo,
        LocF: LocF ?? this.LocF,
        LocT: LocT ?? this.LocT,
        Qty: Qty ?? this.Qty,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SheetModel &&
          runtimeType == other.runtimeType &&
          PartNo == other.PartNo &&
          LocF == other.LocF &&
          LocT == other.LocT &&
          Qty == other.Qty;

  @override
  int get hashCode => PartNo.hashCode ^ LocF.hashCode^LocT.hashCode ^ Qty.hashCode;
}