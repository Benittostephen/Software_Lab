import 'package:flutter/material.dart';
import 'package:software_lab/screens/auth/signup/success_screen.dart';
import 'package:software_lab/widgets/const.dart';
import 'package:software_lab/widgets/custom_appbar.dart';
import '../../../api/apis.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/signup_top_text.dart';

class BusinessHoursScreen extends StatefulWidget {
  final String fullName;
  final String email;
  final String phoneNo;
  final String password;
  final String rePassword;
  final String role;
  final String businessName;
  final String informalName;
  final String address;
  final String city;
  final String zipCode;
  final String? state;
  final String? file;

  const BusinessHoursScreen({
    super.key,
    required this.fullName,
    required this.email,
    required this.phoneNo,
    required this.password,
    required this.rePassword,
    required this.role,
    required this.businessName,
    required this.informalName,
    required this.address,
    required this.city,
    required this.zipCode,
    required this.state,
    required this.file,
  });

  @override
  State<BusinessHoursScreen> createState() => _BusinessHoursScreenState();
}

class _BusinessHoursScreenState extends State<BusinessHoursScreen> {
  final List<String> timings = [
    "8:00am - 10:00am",
    "10:00am - 1:00pm",
    "1:00pm - 4:00pm",
    "4:00pm - 7:00pm",
    "7:00pm - 10:00pm",
  ];

  // Map to store selected timings for each day
  Map<String, List<String>> businessHours = {
    "mon": [],
    "tue": [],
    "wed": [],
    "thu": [],
    "fri": [],
    "sat": [],
    "sun": []
  };

  String selectedDay = "mon"; // Default to Monday

  @override
  Widget build(BuildContext context) {
    //Response Message
    String? message = '';

    final ApiService apiService = ApiService();

    Future<void> register() async {
      final registrationBody = {
        "full_name": widget.fullName,
        "email": widget.email,
        "phone": widget.phoneNo,
        "password": widget.password,
        "role": widget.role,
        "business_name": widget.businessName,
        "informal_name": widget.informalName,
        "address": widget.address,
        "city": widget.city,
        "state": widget.state,
        "zip_code": widget.zipCode,
        "registration_proof": widget.file,
        "business_hours": businessHours,
        "device_token": "0imfnc8mVLWwsAawjYr4Rx-Af50DDqtlx",
        "type": "email",
        "social_id": "0imfnc8mVLWwsAawjYr4Rx-Af50DDqtlx"
      };

      final registrationResponse =
          await apiService.registerUser(registrationBody);

      setState(() {
        message = registrationResponse.message;
      });

      if (registrationResponse.success) {
        //Navigation to the next screen
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const SuccessScreen()));

        //SnackBar Message
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(registrationResponse.message)));
      } else {
        // Handle error case
        print("Error: ${registrationResponse.message}");
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(message!)));
      }
    }

    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SignupTopText(headingText: 'Business Hours', pageNo: 4),
            const Text(
              'Choose the hours your farm is open for pickups. This will allow customers to order deliveries.',
              style: TextStyle(fontSize: 14, color: Color(0xFFb3b3b3)),
            ),

            const SizedBox(height: 30),
            // Day selection
            _buildDaySelector(),
            const SizedBox(height: 20),
            // Time selection
            _buildTimingSelector(),

            const Spacer(),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Image.asset('assets/icons/back_arrow.png', height: 17),
                ),
                const Spacer(flex: 1),
                Expanded(
                  flex: 3,
                  child: CustomButton(buttonName: 'Signup', onTap: register),
                )
              ],
            ),
            const SizedBox(height: 40)
          ],
        ),
      ),
    );
  }

  // Day selector widget
  Widget _buildDaySelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _dayButton('M', 'mon'),
        _dayButton('T', 'tue'),
        _dayButton('W', 'wed'),
        _dayButton('Th', 'thu'),
        _dayButton('F', 'fri'),
        _dayButton('S', 'sat'),
        _dayButton('Su', 'sun'),
      ],
    );
  }

  // Custom day button
  Widget _dayButton(String label, String dayKey) {
    bool isSelectedDay = selectedDay == dayKey;
    bool hasTimingsSelected = businessHours[dayKey]?.isNotEmpty ?? false;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedDay = dayKey; // Update selected day
        });
      },
      child: Container(
        width: 37,
        height: 36,
        decoration: BoxDecoration(
          color: isSelectedDay
              ? primaryColor
              : (hasTimingsSelected ? const Color(0xFFeeedec) : Colors.white),
          border: Border.all(
            color: isSelectedDay
                ? primaryColor
                : (hasTimingsSelected ? const Color(0xFFeeedec) : const Color(0xFFbebbb8)),
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: isSelectedDay
                  ? Colors.white
                  : (hasTimingsSelected ? Colors.black : const Color(0xFFbebbb8)),
            ),
          ),
        ),
      ),
    );
  }

  // Timing selector
  Widget _buildTimingSelector() {
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      spacing: 10,
      runSpacing: 10,
      children: timings.map((timing) {
        bool isSelected = businessHours[selectedDay]?.contains(timing) ?? false;
        return GestureDetector(
          onTap: () {
            setState(() {
              if (isSelected) {
                businessHours[selectedDay]?.remove(timing); // Deselect timing
              } else {
                businessHours[selectedDay]?.add(timing); // Select timing
              }
            });
          },
          child: Container(
            height: 48,
            width: 155,
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFFF8C569) : const Color(0xFFeeedec),
              border: Border.all(
                color: isSelected ? const Color(0xFFF8C569) : const Color(0xFFeeedec),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                timing,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
