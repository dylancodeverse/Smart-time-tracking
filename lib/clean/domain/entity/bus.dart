enum BusStatus { active, inactive }

class Bus {
  final String id;
  final String registrationNumber;
  final String model;
  final BusStatus status;

  Bus({
    required this.id,
    required this.registrationNumber,
    required this.model,
    required this.status,
  });

}
