class ListItem {
  final String barcode;
  String? name;
  final DateTime added;

  ListItem(this.barcode) : added = DateTime.now();

  Map<String, dynamic> toJson() => {
    "barcode": barcode,
    "added": added.toIso8601String(),
    "name": name,
  };

  ListItem.fromJson(Map<String, dynamic> json)
      : barcode = json["barcode"],
        added = DateTime.parse(json["added"]),
        name = json["name"];
}
