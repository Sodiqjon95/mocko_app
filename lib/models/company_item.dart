import 'package:json_annotation/json_annotation.dart';

part 'company_item.g.dart';

@JsonSerializable()
class CompanyItem {
  @JsonKey(defaultValue: "", name: "car_model")
  String carModel;
  @JsonKey(defaultValue: 0, name: "average_price")
  int averagePrice;
  @JsonKey(defaultValue: "", name: "logo")
  String logo;
  @JsonKey(defaultValue: 0, name: "established_year")
  int establishedYear;
  @JsonKey(defaultValue: "", name: "description")
  String description;
  @JsonKey(defaultValue: [], name: "car_pics")
  List<String> pics;

  CompanyItem({
    required this.description,
    required this.averagePrice,
    required this.carModel,
    required this.logo,
    required this.establishedYear,
    required this.pics,
  });

  factory CompanyItem.fromJson(Map<String, dynamic> json) {
    return _$CompanyItemFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CompanyItemToJson(this);
}
