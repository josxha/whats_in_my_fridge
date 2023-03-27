import 'enums.dart';
import 'models.dart';
import 'package:http/http.dart';

class BarcodeApi {
  static const String _defaultQueryId = "400000000";
  final String _queryId;
  final Map<String, Future<ApiResponse>> cache = {};

  BarcodeApi(this._queryId);
  BarcodeApi.guest() : _queryId = _defaultQueryId;

  // https://opengtindb.org/?ean=4011932228284&cmd=query&queryid=400000000
  Future<ApiResponse> requestBarcode(String ean) async {
    if (!cache.containsKey(ean)) {
      cache[ean] = Future<ApiResponse>(() async {
        print("web request : $ean");
        final uri = Uri.parse("https://opengtindb.org/"
            "?ean=$ean"
            "&cmd=query"
            "&queryid=$_queryId");
        final response = await get(uri);
        try {
          return _parseResponse(response.body);
        } catch (error, stacktrace) {
          print(error);
          print(stacktrace);
          rethrow;
        }
      });
    }
    return cache[ean]!;
  }

  static ApiResponse _parseResponse(String raw) {
    final sections = raw.split("\n---");
    final error = _parseError(sections[0]);
    final products = <Product>[];
    if (sections.length > 2) {
      for (final section in sections.sublist(1, sections.length-1)) {
        products.add(_parseProduct(section));
      }
    }
    return ApiResponse(error, products);
  }

  static Map<String, String> _parseSectionToMap(String section) {
    final map = <String, String>{};
    for (final row in section.trim().split("\n")) {
      final parts = row.split("=");
      map[parts[0]] = parts[1];
    }
    return map;
  }

  static Product _parseProduct(String raw) {
    final map = _parseSectionToMap(raw);
    return Product(
      contents: _parseContent(map["contents"]!),
      packaging: _parsePackaging(map["pack"]!),
      origin: map["origin"]!,
      validated: double.parse(map["validated"]!.split(" ")[0]),
      asin: map["asin"],
      descr: map["descr"],
      detailName: map["detailname"],
      detailNameEn: map["detailname"],
      mainCategory: map["maincat"],
      name: map["name"],
      nameEn: map["name_en"],
      subCategory: map["subcat"],
      vendor: map["vendor"],
    );
  }

  static ApiError _parseError(String section) {
    final map = _parseSectionToMap(section);
    final code = int.parse(map["error"]!);
    return ApiError.values[code];
  }

  static Set<Contents> _parseContent(String raw) {
    final set = <Contents>{};
    // TODO
    return set;
  }

  static Set<Packaging> _parsePackaging(String raw) {
    final set = <Packaging>{};
    // TODO
    return set;
  }
}
