

class NavBoatDetailsRequest {
  NavBoatDetailsRequest(
      {this.id,
      this.bbox1Name,
      this.bbox2Name,
      this.bbox1Value,
      this.bbox2Value,
      this.boatName,
      this.bbox,
      this.eb,
      this.url, String? bbox0Value, String? bbox0Name, required });

  final int? id;
  final String? bbox1Name;
  final String? bbox2Name;
  final String? bbox1Value;
  final String? bbox2Value;
  final String? boatName;
  final int? bbox;
  final double? eb;
  final String? url;
  factory NavBoatDetailsRequest.fromJson(Map<String, dynamic> json) =>
     NavBoatDetailsRequest(
      id: json["id"] ?? 0,  // Provide a default value if null
      bbox1Name: json["b_box_1_name"] ?? '',
      bbox1Value: json["b_box_1_value"] ?? '',
      bbox2Name: json["b_box_2_name"] ?? '',
      boatName: json["name"] ?? '',
      bbox: json["b_box"] ?? 0,
      eb: (json["eb"] != null) ? json["eb"].toDouble() : 0.0,
      bbox2Value: json["b_box_2_value"] ?? '',
      url: json["url"] ?? '',
    );

  Map<String, dynamic> toJson() => {
        "id": id,
        "b_box_1_name": bbox1Name,
        "b_box_1_value": bbox1Value,
        "b_box_2_name": bbox2Name,
        "name": boatName,
        "b_box": bbox,
        "eb": eb,
        "b_box_2_value": bbox2Value,
        "url": url,
      };
}
