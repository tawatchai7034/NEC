import 'package:nec/model/transfer.dart';

class TransferList {
  List<TransferModal> trans = [];
  String text = '';

  addTransfer(TransferModal transfer) {
    this.trans.add(transfer);
  }

  ptrTransferList() {
    for (int i = 0; i < trans.length; i++) {
      print("\n************* NO: $i *************");
      print("\nLocF: ${trans[i].locF}");
      print("\nLocT: ${trans[i].locT}");
      print("\nlot: ${trans[i].lot}");
      print("\nvender: ${trans[i].vender}");
      print("\npartNo: ${trans[i].partNo}");
      print("\ndesc: ${trans[i].desc}");
      print("\nqty: ${trans[i].qty}");
      print("\ncount: ${trans[i].count}");
      print("\namountQty: ${trans[i].amountQty}");
    }
  }

  List<TransferModal> getTransferList() {
    return this.trans;
  }
  setText(String message){
   this.text = message;
  }

  String getText(){
    return this.text;
  }
}
