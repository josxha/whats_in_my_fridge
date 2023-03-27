import 'enums.dart';

class ApiResponse {
  final ApiError error;
  final List<Product> products;

  ApiResponse(this.error, this.products);

  @override
  String toString() => "ApiResponse{\n"
      "    error: $error\n"
      "    products: $products\n"
      "}";
}

class Product {
  final String? asin, name, detailName, vendor, mainCategory, subCategory;
  final Set<Contents> contents;
  final Set<Packaging> packaging;
  final String? descr, nameEn, detailNameEn;
  final String origin;
  final double validated;

  Product({this.asin, this.name, this.detailName, this.vendor, this.mainCategory,
    this.subCategory, required this.contents, required this.packaging,
    this.descr, this.nameEn, this.detailNameEn,
    required this.origin, required this.validated});

  @override
  String toString() => "Product{\n"
      "    asin: $asin,\n"
      "    name: $name,\n"
      "    detailName: $detailName,\n"
      "    vendor: $vendor,\n"
      "    mainCategory: $mainCategory,\n"
      "    subCategory: $subCategory,\n"
      "    contents: $contents,\n"
      "    packaging: $packaging,\n"
      "    descr: $descr,\n"
      "    nameEn: $nameEn,\n"
      "    detailNameEn: $detailNameEn,\n"
      "    origin: $origin,\n"
      "    validated: $validated,\n"
      "}";
}
