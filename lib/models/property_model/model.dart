
import 'dart:developer';

import 'package:airbnb/core/constants/pocketbase_constants.dart';
import 'package:airbnb/models/user_model/model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pocketbase/pocketbase.dart';
part 'model.g.dart';
@JsonEnum()
enum City  { damascus, tartus, aleppo, homs }
@JsonSerializable()
class PropertyModel {
  final String address;
  @JsonKey(name: "availability_status")
  final bool availabilityStatus;
  final City city;
  final String description;
  final Expand? expand;
  final String id;
  final List<String> images;
  @JsonKey(name: "number_of_bathrooms")
  final int numberOfBathrooms;
  @JsonKey(name: "number_of_rooms")
  final int numberOfRooms;
  final String owner;
  @JsonKey(name: "price_daily")
  final int priceDaily;
  @JsonKey(name: "price_monthly")
  final int priceMonthly;
  final int size;
  @JsonKey(name: "has_wifi")
  final bool hasWifi;

  PropertyModel({
    required this.address,
    required this.availabilityStatus,
    required this.city,
    required this.description,
    this.expand,
    required this.id,
    required this.images,
    required this.numberOfBathrooms,
    required this.numberOfRooms,
    required this.owner,
    required this.priceDaily,
    required this.priceMonthly,
    required this.size,
    required this.hasWifi

  });

  PropertyModel copyWith({
    String? address,
    bool? availabilityStatus,
    City? city,
    String? collectionId,
    String? collectionName,
    DateTime? created,
    String? description,
    Expand? expand,
    String? id,
    List<String>? images,
    int? numberOfBathrooms,
    int? numberOfRooms,
    String? owner,
    int? priceDaily,
    int? priceMonthly,
    int? size,
    DateTime? updated,
    bool? hasWifi
  }) =>
      PropertyModel(
        address: address ?? this.address,
        availabilityStatus: availabilityStatus ?? this.availabilityStatus,
        city: city ?? this.city,
        description: description ?? this.description,
        expand: expand ?? this.expand,
        id: id ?? this.id,
        images: images ?? this.images,
        numberOfBathrooms: numberOfBathrooms ?? this.numberOfBathrooms,
        numberOfRooms: numberOfRooms ?? this.numberOfRooms,
        owner: owner ?? this.owner,
        priceDaily: priceDaily ?? this.priceDaily,
        priceMonthly: priceMonthly ?? this.priceMonthly,
        size: size ?? this.size,
        hasWifi: hasWifi ?? this.hasWifi

      );


  factory PropertyModel.fromRecord(RecordModel record) => PropertyModel.fromJson(record.toJson());
  factory PropertyModel.fromJson(Map<String, dynamic> json) => _$PropertyModelFromJson(json);
  Map<String, dynamic> toJson() => _$PropertyModelToJson(this);
  String get _filePathUrl =>"api/files/${PocketBaseConstants.propertyCollection}/$id";
  String? get thumbImage {
    if(images.isEmpty)
      {
        return null;

      }
    return  "${PocketBaseConstants.apiUrl}/$_filePathUrl/${images.first}";
  }
  List<String> get imagesUrl => images.map((imageName) => "${PocketBaseConstants.apiUrl}/$_filePathUrl/$imageName" ,).toList();




}
@JsonSerializable()
class Expand {
  final UserModel owner;

  Expand({
    required this.owner,
  });

  Expand copyWith({
    UserModel? owner,
  }) =>
      Expand(
        owner: owner ?? this.owner,
      );

  factory Expand.fromJson(Map<String, dynamic> json) {

    return _$ExpandFromJson(json);
  }
  Map<String, dynamic> toJson() => _$ExpandToJson(this);

}

