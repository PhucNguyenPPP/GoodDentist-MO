import 'package:good_dentist_mobile/src/models/RoomDTO.dart';
import 'package:good_dentist_mobile/src/models/UserDTO.dart';

class DentistSlotDTO {
  int dentistSlotId;
  String dentistId;
  String timeStart;
  String timeEnd;
  int roomId;
  bool status;
  UserDTO dentist;
  RoomDTO room;

  DentistSlotDTO({
    required this.dentistSlotId,
    required this.dentistId,
    required this.timeStart,
    required this.timeEnd,
    required this.roomId,
    required this.status,
    required this.dentist,
    required this.room,
  });

  factory DentistSlotDTO.fromJson(Map<String, dynamic> json) {
    return DentistSlotDTO(
      dentistSlotId: json['dentistSlotId'],
      dentistId: json['dentistId'],
      timeStart: json['timeStart'],
      timeEnd: json['timeEnd'],
      roomId: json['roomId'],
      status: json['status'],
      dentist: UserDTO.fromJson(json['dentist']),
      room: RoomDTO.fromJson(json['room']),
    );
  }
}