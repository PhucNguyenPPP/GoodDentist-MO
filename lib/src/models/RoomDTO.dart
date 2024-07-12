class RoomDTO {
  int roomId;
  String roomNumber;
  String clinicId;
  bool status;

  RoomDTO({
    required this.roomId,
    required this.roomNumber,
    required this.clinicId,
    required this.status,
  });

  factory RoomDTO.fromJson(Map<String, dynamic> json) {
    return RoomDTO(
      roomId: json['roomId'],
      roomNumber: json['roomNumber'],
      clinicId: json['clinicId'],
      status: json['status'],
    );
  }
}
