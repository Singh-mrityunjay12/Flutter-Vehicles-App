
class DetailsModel {
  DetailsModel({
    required this.documentId,
    required this.vehicalNumber,
    required this.brandName,
    required this.engineType,
    required this.fuelType,
  });
  String documentId='';
  String vehicalNumber;
  String brandName;
  String engineType;
  String fuelType;

  factory DetailsModel.fromMap(String documentId, Map<String, dynamic> toMap,) {
    return DetailsModel(
      documentId: documentId,
      vehicalNumber: toMap['vehicalNumber'],
      brandName: toMap['brandName'],
      engineType: toMap['engineType'],
      fuelType: toMap['fuelType'],
    );
  }

  Map<String, dynamic> tojson() {
    return {
      'vehicalNumber': vehicalNumber,
      'brandName': brandName,
      'engineType': engineType,
      'fuelType': fuelType,
    };
  }
}
