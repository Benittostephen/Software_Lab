import 'package:flutter/material.dart';
import 'package:software_lab/screens/auth/signup/proof_verification_screen.dart';
import 'package:software_lab/widgets/custom_appbar.dart';
import 'package:software_lab/widgets/custom_button.dart';
import 'package:software_lab/widgets/custom_textfield.dart';
import 'package:software_lab/widgets/signup_top_text.dart';

class FarmInfoScreen extends StatefulWidget {
  final String fullName;
  final String email;
  final String phoneNo;
  final String password;
  final String rePassword;
  final String role;

  const FarmInfoScreen(
      {super.key,
      required this.phoneNo,
      required this.password,
      required this.email,
      required this.fullName,
      required this.rePassword,
      required this.role});

  @override
  State<FarmInfoScreen> createState() => _FarmInfoScreenState();
}

class _FarmInfoScreenState extends State<FarmInfoScreen> {
  late TextEditingController businessNameController;
  late TextEditingController informalNameController;
  late TextEditingController addressController;
  late TextEditingController cityController;
  late TextEditingController zipCodeController;
  String? selectedState;

  final List<String> states = [
    'Alabama',
    'Alaska',
    'Arizona',
    'Arkansas',
    'California',
    'Colorado',
    'Delaware'
  ];

  @override
  void initState() {
    super.initState();
    businessNameController = TextEditingController();
    informalNameController = TextEditingController();
    addressController = TextEditingController();
    cityController = TextEditingController();
    zipCodeController = TextEditingController();
  }

  @override
  void dispose() {
    businessNameController.dispose();
    informalNameController.dispose();
    addressController.dispose();
    cityController.dispose();
    zipCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SignupTopText(
              headingText: 'Farm Info',
              pageNo: 2,
            ),
            CustomTextfield(
                controller: businessNameController,
                hintText: 'Business Name',
                obscureText: false,
                prefixicon: 'assets/icons/tag.png'),
            //const SizedBox(height: 20),
            CustomTextfield(
                controller: informalNameController,
                hintText: 'Informal Name',
                obscureText: false,
                prefixicon: 'assets/icons/emoji.png'),
            //  const SizedBox(height: 20),
            CustomTextfield(
                controller: addressController,
                hintText: 'Street Address',
                obscureText: false,
                prefixicon: 'assets/icons/home.png'),
            //  const SizedBox(height: 20),
            CustomTextfield(
                controller: cityController,
                hintText: 'City',
                obscureText: false,
                prefixicon: 'assets/icons/location.png'),
            // const SizedBox(height: 20),
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                            color: const Color(0xffeeedec),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: DropdownButtonFormField<String>(
                            value: selectedState,
                            decoration: const InputDecoration(
                              labelText: 'State',
                              labelStyle: TextStyle(color: Color(0xFFa7a6a5)),
                              border: InputBorder.none,
                            ),
                            dropdownColor: Colors.white,
                            items: states
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedState = newValue;
                              });
                            },
                          ),
                        )),
                    const SizedBox(width: 20),
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          SizedBox(height: 20),
                          CustomTextfield(
                            prefixicon: null,
                            obscureText: false,
                            controller: zipCodeController,
                            hintText: 'Enter Zipcode',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Image.asset('assets/icons/back_arrow.png', height: 18),
                ),
                const Spacer(flex: 1),
                Expanded(
                  //flex: 3,
                  child: CustomButton(
                      buttonName: 'Continue',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProofVerificationScreen(
                                      fullName: widget.fullName,
                                      password: widget.password,
                                      rePassword: widget.rePassword,
                                      email: widget.email,
                                      phoneNo: widget.phoneNo,
                                      role: widget.role,
                                      businessName: businessNameController.text,
                                      address: addressController.text,
                                      informalName: informalNameController.text,
                                      city: cityController.text,
                                      zipCode: zipCodeController.text,
                                      state: selectedState,
                                    )));
                      }),
                )
              ],
            ),
            const SizedBox(height: 40)
          ],
        ),
      ),
    );
  }
}
