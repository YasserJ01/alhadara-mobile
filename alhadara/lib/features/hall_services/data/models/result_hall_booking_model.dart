import 'package:alhadara/features/hall_services/domain/entities/result_hall_booking_entity.dart';

class HallBookingModel {
  final HallModel hall;
  final List<ServiceModel> includedServices;
  final List<ServiceModel> matchesRequestedServices;
  final double basePrice;
  final double servicesPrice;
  final double privateSurcharge;
  final double totalPrice;
  final int remainingSeats;

  HallBookingModel({
    required this.hall,
    required this.includedServices,
    required this.matchesRequestedServices,
    required this.basePrice,
    required this.servicesPrice,
    required this.privateSurcharge,
    required this.totalPrice,
    required this.remainingSeats,
  });

  factory HallBookingModel.fromJson(Map<String, dynamic> json) {
    return HallBookingModel(
      hall: HallModel.fromJson(json['hall']),
      includedServices: List<ServiceModel>.from(
          json['included_services'].map((x) => ServiceModel.fromJson(x))),
      matchesRequestedServices: List<ServiceModel>.from(
          json['matches_requested_services'].map((x) => ServiceModel.fromJson(x))),
      basePrice: double.parse(json['base_price']),
      servicesPrice: double.parse(json['services_price']),
      privateSurcharge: double.parse(json['private_surcharge']),
      totalPrice: double.parse(json['total_price']),
      remainingSeats: json['remaining_seats'],
    );
  }

  // Add toEntity method inside the class
  HallBookingEntity toEntity() {
    return HallBookingEntity(
      hall: hall.toEntity(),
      includedServices: includedServices.map((service) => service.toEntity()).toList(),
      matchesRequestedServices: matchesRequestedServices.map((service) => service.toEntity()).toList(),
      basePrice: basePrice,
      servicesPrice: servicesPrice,
      privateSurcharge: privateSurcharge,
      totalPrice: totalPrice,
      remainingSeats: remainingSeats,
    );
  }
}

class HallModel {
  final int id;
  final String name;
  final int capacity;
  final String location;
  final double hourlyRate;

  HallModel({
    required this.id,
    required this.name,
    required this.capacity,
    required this.location,
    required this.hourlyRate,
  });

  factory HallModel.fromJson(Map<String, dynamic> json) {
    return HallModel(
      id: json['id'],
      name: json['name'],
      capacity: json['capacity'],
      location: json['location'],
      hourlyRate: double.parse(json['hourly_rate']),
    );
  }

  // Add toEntity method
  HallEntity toEntity() {
    return HallEntity(
      id: id,
      name: name,
      capacity: capacity,
      location: location,
      hourlyRate: hourlyRate,
    );
  }
}

class ServiceModel {
  final int id;
  final String name;
  final double price;

  ServiceModel({
    required this.id,
    required this.name,
    required this.price,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'],
      name: json['name'],
      price: double.parse(json['price']),
    );
  }

  // Add toEntity method
  ServiceEntity toEntity() {
    return ServiceEntity(
      id: id,
      name: name,
      price: price,
    );
  }
}