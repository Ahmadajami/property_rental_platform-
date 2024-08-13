// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PropertyModel _$PropertyModelFromJson(Map<String, dynamic> json) {
  try{
    return  PropertyModel(
      address: json['address'] as String,
      availabilityStatus: json['availability_status'] as bool,
      city: $enumDecode(_$CityEnumMap, json['city']),
      description: json['description'] as String,
      expand: json['expand'] == null || json['expand'].isEmpty
          ? null
          : Expand.fromJson(json['expand'] as Map<String, dynamic>),
      id: json['id'] as String,
      images:
      (json['images'] as List<dynamic>).map((e) => e as String).toList(),
      numberOfBathrooms: (json['number_of_bathrooms'] as num).toInt(),
      numberOfRooms: (json['number_of_rooms'] as num).toInt(),
      owner: json['owner'] as String,
      priceDaily: (json['price_daily'] as num).toInt(),
      priceMonthly: (json['price_monthly'] as num).toInt(),
      size: (json['size'] as num).toInt(),
      hasWifi: json['has_wifi'] as bool,
    );
  }
  catch(e){
    log(" errorr  in parsing ${e.toString()}");
    return PropertyModel(address: "none",
        availabilityStatus: false, city: City.damascus , description: "nono", id: "id",
        images: ["http://picssum.io/300"],
        numberOfBathrooms:0,
        numberOfRooms: 0,
        owner:"s",
        priceDaily:0,
        priceMonthly:0,
        size: 0,
        hasWifi: false);
  }

}
Map<String, dynamic> _$PropertyModelToJson(PropertyModel instance) =>
    <String, dynamic>{
      'address': instance.address,
      'availability_status': instance.availabilityStatus,
      'city': _$CityEnumMap[instance.city]!,
      'description': instance.description,
      'expand': instance.expand,
      'id': instance.id,
      'images': instance.images,
      'number_of_bathrooms': instance.numberOfBathrooms,
      'number_of_rooms': instance.numberOfRooms,
      'owner': instance.owner,
      'price_daily': instance.priceDaily,
      'price_monthly': instance.priceMonthly,
      'size': instance.size,
      'has_wifi': instance.hasWifi,
    };

const _$CityEnumMap = {
  City.damascus: 'damascus',
  City.tartus: 'tartus',
  City.aleppo: 'aleppo',
  City.homs: 'homs',
};

Expand _$ExpandFromJson(Map<String, dynamic> json) => Expand(
      owner: UserModel.fromJson(json['owner'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ExpandToJson(Expand instance) => <String, dynamic>{
      'owner': instance.owner,
    };
