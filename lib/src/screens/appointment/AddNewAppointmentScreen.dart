import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:good_dentist_mobile/src/api/customer/CustomerService.dart';
import 'package:good_dentist_mobile/src/api/dentist/DentistService.dart';
import 'package:good_dentist_mobile/src/api/dentist_slot/DentistSlotService.dart';
import 'package:good_dentist_mobile/src/api/examination/ExaminationService.dart';
import 'package:good_dentist_mobile/src/models/ApiResponseDTO.dart';
import 'package:good_dentist_mobile/src/models/DentistSlotDTO.dart';
import 'package:good_dentist_mobile/src/models/ExaminationCreateResponseDTO.dart';
import 'package:good_dentist_mobile/src/models/ExaminationCreateResquestDTO.dart';
import 'package:good_dentist_mobile/src/models/UserDTO.dart';
import 'package:good_dentist_mobile/src/screens/appointment/AppointmentScreen.dart';
import 'package:good_dentist_mobile/src/screens/common/LoginScreen.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:time_range_picker/time_range_picker.dart';

class AddNewAppointmentScreen extends StatefulWidget {
  final UserDTO customer;
  const AddNewAppointmentScreen({super.key, required this.customer});

  @override
  State<StatefulWidget> createState() {
    return _AddNewAppointmentScreenState();
  }
}

class _AddNewAppointmentScreenState extends State<AddNewAppointmentScreen> {
  bool _isLoading = true;
  String? _errorMessage;
  String? role;
  String? _selectedDiagnosis = "New Profile";
  String? _selectedDentistSlot;
  late String dateOnlyNow;
  late String dateNow;
  DateTime selectedDate = DateTime.now();
  ApiResponseDTO<List<DentistSlotDTO>>? _dentistSlotList;
  String? _timeStart;
  String? _timeEnd;
  final TextEditingController _diagnosis = TextEditingController();
  final TextEditingController _notes = TextEditingController();

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    dateOnlyNow = DateFormat('yyyy-MM-dd').format(now);
    dateNow = DateFormat('E').format(now);
    _fetchAllInfoForForm();
  }

  String formatTimeOfDay(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    final formatter = DateFormat.Hm(); // HH:mm format
    return formatter.format(dt);
  }

  Future<void> _fetchAllInfoForForm() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? dentistId = prefs.getString('dentistId');
      int? expiration = prefs.getInt('expiration');
      role = prefs.getString('role');

      if (dentistId != null && expiration != null && role != null) {
        if (DateTime.now().millisecondsSinceEpoch > expiration) {
          // If expired, navigate to login page
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
            (Route<dynamic> route) => false,
          );
          return; // Exit early if expired
        }
      }

      ApiResponseDTO<UserDTO> dentistInfo =
          await DentistService.getDentistInformation(dentistId!);
      ApiResponseDTO<List<DentistSlotDTO>>? dentistSlotList =
          await DentistSlotService.getDentistSlotOfDentistByDate(
              dentistId, dentistInfo.result!.clinics![0].clinicId, dateOnlyNow);

      setState(() {
        _dentistSlotList = dentistSlotList;
      });
    } catch (e) {
      setState(() {
        _errorMessage = "Failed to load dentist slot: $e";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Appointment"),
        backgroundColor: Colors.purple[400],
      ),
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : _buildNewAppointmentForm(context),
      ),
    );
  }

  Widget _buildNewAppointmentForm(BuildContext context) {
    final Map<String, int> dropdownExaminationProfileValues = {
      'New Profile': -1,
      for (var profile in widget.customer.examinationProfiles!)
        profile.diagnosis: profile.examinationProfileId,
    };

    final Map<String, int> dropdownDentistSlotValues = {
      for (var dentistSlot in _dentistSlotList!.result!)
        '${DateFormat("HH:mm").format(DateTime.parse(dentistSlot.timeStart.toString()))} - '
            '${DateFormat("HH:mm").format(DateTime.parse(dentistSlot.timeEnd.toString()))} | '
            'Room: ${dentistSlot.room.roomNumber}': dentistSlot.dentistSlotId,
    };

    Future<void> selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1980),
        lastDate: DateTime(2025),
      );
      if (picked != null && picked != selectedDate) {
        setState(() {
          selectedDate = picked;
          dateOnlyNow = DateFormat('yyyy-MM-dd').format(selectedDate);
        });
        _fetchAllInfoForForm();
      }
    }

    Future<void> fetchCreateNewAppointment() async {
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? dentistId = prefs.getString('dentistId');
        int? expiration = prefs.getInt('expiration');
        role = prefs.getString('role');

        if (dentistId != null && expiration != null && role != null) {
          if (DateTime.now().millisecondsSinceEpoch > expiration) {
            // If expired, navigate to login page
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
              (Route<dynamic> route) => false,
            );
            return; // Exit early if expired
          }
        }

        String customerId = widget.customer.userId!;
        int? examProfileId =
            dropdownExaminationProfileValues[_selectedDiagnosis];
        String date = selectedDate.toString();
        int? dentistSlotId = dropdownDentistSlotValues[_selectedDentistSlot];
        String? timeStart = _timeStart;
        String? timeEnd = _timeEnd;
        String diagnosis = _diagnosis.text;
        String notes = _notes.text;
        String mode;

        if (dentistSlotId == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Please select dentist slot.'),
              duration: Duration(seconds: 3),
            ),
          );
          return;
        }
        if (timeStart == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Please select time start.'),
              duration: Duration(seconds: 3),
            ),
          );
          return;
        }
        if (timeEnd == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Please select time end.'),
              duration: Duration(seconds: 3),
            ),
          );
          return;
        }

        if (diagnosis.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Please input diagnosis.'),
              duration: Duration(seconds: 3),
            ),
          );
          return;
        }

        if (notes.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Please input notes.'),
              duration: Duration(seconds: 3),
            ),
          );
          return;
        }

        DateTime praseDate = DateTime.parse(date);

        List<String> timeStartParts = timeStart.split(':');
        int startHours = int.parse(timeStartParts[0]);
        int startMinutes = int.parse(timeStartParts[1]);
        String combinedStartDateTime = DateTime(praseDate.year, praseDate.month,
                praseDate.day, startHours, startMinutes)
            .toIso8601String();

        List<String> timeEndParts = timeEnd.split(':');
        int endHours = int.parse(timeEndParts[0]);
        int endMinutes = int.parse(timeEndParts[1]);
        String combinedDateTime = DateTime(praseDate.year, praseDate.month,
                praseDate.day, endHours, endMinutes)
            .toIso8601String();

        if (examProfileId == -1) {
          mode = "new";
        } else {
          mode = "old";
        }

        ExaminationCreateRequestDTO createDto = new ExaminationCreateRequestDTO(
            examinationId: 0,
            examinationProfileId: examProfileId ?? 0,
            dentistSlotId: dentistSlotId,
            diagnosis: diagnosis,
            timeStart: combinedStartDateTime,
            timeEnd: combinedDateTime,
            notes: notes,
            status: 1);
        ExaminationCreateResponseDTO responseDto =
            await ExaminationService.createNewExamination(
                mode, customerId, createDto);
        if (responseDto.statusCode == 200) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const AppointmentScreen()),
          );
        } else {
          String errorMessage = responseDto.message.join("\n");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorMessage),
              duration: const Duration(seconds: 5),
            ),
          );
          return;
        }
      } catch (e) {
        setState(() {
          _errorMessage = "Failed to load dentist slot: $e";
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }

    return LayoutBuilder(builder: (context, constraints) {
      return SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 15),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 0.8, color: Colors.grey),
                ),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: constraints.maxWidth * 0.91,
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Dentist",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Nguyen Van Thanh",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 120,
              margin: const EdgeInsets.symmetric(horizontal: 15),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 0.8, color: Colors.grey),
                ),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: constraints.maxWidth * 0.91,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Customer Name",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          enabled: false,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[300],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: BorderSide.none,
                            ),
                            hintText: widget.customer.name,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 120,
              margin: const EdgeInsets.symmetric(horizontal: 15),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 0.8, color: Colors.grey),
                ),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: constraints.maxWidth * 0.91,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Customer Phone",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          enabled: false,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[300],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: BorderSide.none,
                            ),
                            hintText: widget.customer.phoneNumber,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 120,
              margin: const EdgeInsets.symmetric(horizontal: 15),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 0.8, color: Colors.grey),
                ),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: constraints.maxWidth * 0.91,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Examination Profile",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: DropdownButton<String>(
                            value: _selectedDiagnosis,
                            isExpanded: true,
                            underline: const SizedBox.shrink(),
                            icon: const Icon(Icons.arrow_drop_down),
                            iconSize: 24,
                            elevation: 16,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 16),
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedDiagnosis = newValue!;
                              });
                            },
                            items: dropdownExaminationProfileValues.keys
                                .map<DropdownMenuItem<String>>((String key) {
                              return DropdownMenuItem<String>(
                                value: key,
                                child: Text(key),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 120,
              margin: const EdgeInsets.symmetric(horizontal: 15),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 0.8, color: Colors.grey),
                ),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: constraints.maxWidth * 0.91,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Date",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () => selectDate(context),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            width: constraints.maxWidth * 0.3,
                            height: 40,
                            decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(15.0)),
                            child: Row(
                              children: [
                                const SizedBox(width: 10),
                                Text(dateOnlyNow),
                                const SizedBox(width: 5),
                                const Icon(
                                  Icons.calendar_today,
                                  color: Colors.black,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 120,
              margin: const EdgeInsets.symmetric(horizontal: 15),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 0.8, color: Colors.grey),
                ),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: constraints.maxWidth * 0.91,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Dentist Slot",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: DropdownButton<String>(
                            value: _selectedDentistSlot,
                            isExpanded: true,
                            underline: const SizedBox.shrink(),
                            icon: const Icon(Icons.arrow_drop_down),
                            iconSize: 24,
                            elevation: 16,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 16),
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedDentistSlot = newValue!;
                              });
                            },
                            items: dropdownDentistSlotValues.keys
                                .map<DropdownMenuItem<String>>((String key) {
                              return DropdownMenuItem<String>(
                                value: key,
                                child: Text(key),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 120,
              margin: const EdgeInsets.symmetric(horizontal: 15),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 0.8, color: Colors.grey),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      SizedBox(
                        width: constraints.maxWidth * 0.91,
                        child: const Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Time",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlinedButton(
                        onPressed: () async {
                          TimeRange result = await showTimeRangePicker(
                            context: context,
                          );
                          setState(() {
                            _timeStart = formatTimeOfDay(result.startTime);
                            _timeEnd = formatTimeOfDay(result.endTime);
                          });
                        },
                        child: const Text("Choose time"),
                      ),
                      _timeStart != null && _timeEnd != null
                          ? Text("$_timeStart - $_timeEnd")
                          : const Text("Please choose time")
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            Container(
              height: 140,
              margin: const EdgeInsets.symmetric(horizontal: 15),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 0.8, color: Colors.grey),
                ),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: constraints.maxWidth * 0.91,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Diagnosis",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: _diagnosis,
                          maxLines: 2,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[300],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: BorderSide.none,
                            ),
                            hintText: 'Diagnosis...',
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 250,
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  SizedBox(
                    width: constraints.maxWidth * 0.91,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Notes",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: _notes,
                          maxLines: 6,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[300],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: BorderSide.none,
                            ),
                            hintText: 'Notes...',
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  SizedBox(
                    width: constraints.maxWidth * 0.91,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.only(left: 70, right: 70),
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.purple[400],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            textStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: fetchCreateNewAppointment,
                          child: const Text("Add New Appointment"),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
