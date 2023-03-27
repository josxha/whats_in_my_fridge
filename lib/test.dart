import 'package:opengtindb/opengtindb.dart';

main() async {
  final barcodeApi = BarcodeApi.guest();
  final api = await barcodeApi.requestBarcode("4011932228284");
  final api2 = await barcodeApi.requestBarcode("4011932228284");
  print(api);
  print(api2);
}
