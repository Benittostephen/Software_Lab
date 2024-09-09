import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:software_lab/screens/auth/signup/business_hours_screen.dart';
import 'package:software_lab/widgets/const.dart';
import 'package:software_lab/widgets/custom_appbar.dart';
import 'package:software_lab/widgets/custom_button.dart';
import 'package:software_lab/widgets/signup_top_text.dart';

class ProofVerificationScreen extends StatefulWidget {
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

  const ProofVerificationScreen({
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
  });

  @override
  State<ProofVerificationScreen> createState() =>
      _ProofVerificationScreenState();
}

class _ProofVerificationScreenState extends State<ProofVerificationScreen> {
  File? _selectedFile;
  String? _fileName;

  final ImagePicker _picker = ImagePicker();

  // Method to pick an image or file
  Future<void> _pickFile() async {
    // Open options dialog to pick from gallery, camera, or files
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Select from Gallery'),
              onTap: () async {
                Navigator.pop(context);
                final pickedFile =
                    await _picker.pickImage(source: ImageSource.gallery);
                if (pickedFile != null) {
                  setState(() {
                    _selectedFile = File(pickedFile.path);
                    _fileName = pickedFile.name;
                  });
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Take a Picture'),
              onTap: () async {
                Navigator.pop(context);
                final pickedFile =
                    await _picker.pickImage(source: ImageSource.camera);
                if (pickedFile != null) {
                  setState(() {
                    _selectedFile = File(pickedFile.path);
                    _fileName = pickedFile.name;
                  });
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.attach_file),
              title: const Text('Select PDF'),
              onTap: () async {
                Navigator.pop(context);
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: ['pdf'],
                );
                if (result != null) {
                  setState(() {
                    _selectedFile = File(result.files.single.path!);
                    _fileName = result.files.single.name;
                  });
                }
              },
            ),
          ],
        );
      },
    );
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
            const SignupTopText(headingText: 'Verification', pageNo: 3),
            const Text(
              'Attach proof of Department of Agriculture registrations i.e. Florida Fresh, USDA Approved, USDA Organic',
              style: TextStyle(fontSize: 14, color: Color(0xFFb3b3b3)),
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Attach proof of registration',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                GestureDetector(
                  onTap: _pickFile,
                  child: CircleAvatar(
                      backgroundColor: primaryColor,
                      radius: 25,
                      child: Image.asset(
                        'assets/icons/camera.png',
                        color: Colors.white,
                        height: 23,
                      )),
                ),
              ],
            ),
            const SizedBox(height: 30),
            _fileName != null
                ? Container(
                    height: 48,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            _fileName!,
                            style: const TextStyle(
                                fontSize: 16,
                                decoration: TextDecoration.underline),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        GestureDetector(
                          child: const Icon(Icons.close, size: 15),
                          onTap: () {
                            setState(() {
                              _selectedFile = null;
                              _fileName = null;
                            });
                          },
                        ),
                      ],
                    ),
                  )
                : const SizedBox(),
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
                  child: CustomButton(
                      buttonName: (_fileName == null) ? 'Continue' : 'Submit',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BusinessHoursScreen(
                                    fullName: widget.fullName,
                                    email: widget.email,
                                    phoneNo: widget.phoneNo,
                                    password: widget.password,
                                    rePassword: widget.rePassword,
                                    businessName: widget.businessName,
                                    informalName: widget.informalName,
                                    address: widget.address,
                                    city: widget.city,
                                    state: widget.state,
                                    zipCode: widget.zipCode,
                                    role: widget.role,
                                    file: _fileName)));
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
