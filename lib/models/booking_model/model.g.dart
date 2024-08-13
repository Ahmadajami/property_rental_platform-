// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingModel _$BookingModelFromJson(Map<String, dynamic> json) => BookingModel(
      id: json['id'] as String?,
      propertyId: json['property_id'] as String,
      tenantId: json['tenant_id'] as String,
      checkInDate: DateTime.parse(json['check_in_date'] as String),
      checkOutDate: DateTime.parse(json['check_out_date'] as String),
      totalPrice: (json['total_price'] as num).toInt(),
      bookingStatus:
          $enumDecode(_$BookingStatusEnumMap, json['booking_status']),
    );

Map<String, dynamic> _$BookingModelToJson(BookingModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'property_id': instance.propertyId,
      'tenant_id': instance.tenantId,
      'check_in_date': instance.checkInDate.toIso8601String(),
      'check_out_date': instance.checkOutDate.toIso8601String(),
      'total_price': instance.totalPrice,
      'booking_status': _$BookingStatusEnumMap[instance.bookingStatus]!,
    };

const _$BookingStatusEnumMap = {
  BookingStatus.pending: 'pending',
  BookingStatus.confirmed: 'confirmed',
  BookingStatus.cancelled: 'cancelled',
};
