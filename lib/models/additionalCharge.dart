import 'package:meta/meta.dart';
import 'dart:convert';

class AdditionalCharge {
  int additionalChargeId;
  int contractId;
  String chargeName;
  String chargeType;
  int quantity;
  double unitPrice;
  double totalPrice;
  DateTime createdAt;
  DateTime updatedAt;

  AdditionalCharge({
    required this.additionalChargeId,
    required this.contractId,
    required this.chargeName,
    required this.chargeType,
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AdditionalCharge.fromJson(Map<String, dynamic> json) =>
      AdditionalCharge(
        additionalChargeId: json["AdditionalChargeId"],
        contractId: json["ContractId"],
        chargeName: json["ChargeName"],
        chargeType: json["ChargeType"],
        quantity: int.parse(json["Quantity"].toString()),
        unitPrice: double.parse(json["UnitPrice"].toString()),
        totalPrice: double.parse(json["TotalPrice"].toString()),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "AdditionalChargeId": additionalChargeId,
        "ContractId": contractId,
        "ChargeName": chargeName,
        "ChargeType": chargeType,
        "Quantity": quantity,
        "UnitPrice": unitPrice,
        "TotalPrice": totalPrice,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
