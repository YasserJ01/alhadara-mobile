class HallBookingEntity {
  final HallEntity hall;
  final List<ServiceEntity> includedServices;
  final List<ServiceEntity> matchesRequestedServices;
  final double basePrice;
  final double servicesPrice;
  final double privateSurcharge;
  final double totalPrice;
  final int remainingSeats;

  HallBookingEntity({
    required this.hall,
    required this.includedServices,
    required this.matchesRequestedServices,
    required this.basePrice,
    required this.servicesPrice,
    required this.privateSurcharge,
    required this.totalPrice,
    required this.remainingSeats,
  });
}

class HallEntity {
  final int id;
  final String name;
  final int capacity;
  final String location;
  final double hourlyRate;

  HallEntity({
    required this.id,
    required this.name,
    required this.capacity,
    required this.location,
    required this.hourlyRate,
  });
}

class ServiceEntity {
  final int id;
  final String name;
  final double price;

  ServiceEntity({
    required this.id,
    required this.name,
    required this.price,
  });
}