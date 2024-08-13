
import 'package:json_annotation/json_annotation.dart';
import 'package:pocketbase/pocketbase.dart';
part 'model.g.dart';
@JsonEnum()
enum BookingStatus { pending, confirmed, cancelled }
@JsonSerializable()
class BookingModel {
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "property_id")
  final String propertyId;
  @JsonKey(name: "tenant_id")
  final String tenantId;
  @JsonKey(name: "check_in_date")
  final DateTime checkInDate;
  @JsonKey(name: "check_out_date")
  final DateTime checkOutDate;
  @JsonKey(name: "total_price")
  final int totalPrice;
  @JsonKey(name: "booking_status")
  final BookingStatus bookingStatus;

  BookingModel({
     this.id,
    required this.propertyId,
    required this.tenantId,
    required this.checkInDate,
    required this.checkOutDate,
    required this.totalPrice,
    required this.bookingStatus,
  });

  BookingModel copyWith({
    String? id,
    String? propertyId,
    String? tenantId,
    DateTime? checkInDate,
    DateTime? checkOutDate,
    int? totalPrice,
    BookingStatus? bookingStatus,
  }) =>
      BookingModel(
        id: id ?? this.id,
        propertyId: propertyId ?? this.propertyId,
        tenantId: tenantId ?? this.tenantId,
        checkInDate: checkInDate ?? this.checkInDate,
        checkOutDate: checkOutDate ?? this.checkOutDate,
        totalPrice: totalPrice ?? this.totalPrice,
        bookingStatus: bookingStatus ?? this.bookingStatus,
      );

  factory BookingModel.fromRecord(RecordModel record) => BookingModel.fromJson(record.toJson());
  factory BookingModel.fromJson(Map<String, dynamic> json) => _$BookingModelFromJson(json);

  Map<String, dynamic> toJson() => _$BookingModelToJson(this);
}
