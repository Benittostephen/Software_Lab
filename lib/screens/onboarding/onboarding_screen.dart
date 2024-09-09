import 'dart:async'; // Import Timer
import 'package:flutter/material.dart';
import '../auth/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController(initialPage: 0);
  int selectedIndex = 0; // Initial selected index
  Timer? _timer; // Declare a Timer

  @override
  void initState() {
    super.initState();

    // Set up a timer that will automatically move to the next page every 2 seconds
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (selectedIndex < 2) {
        selectedIndex++;
      } else {
        selectedIndex = 0;
      }
      _controller.animateToPage(
        selectedIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: PageView(
              controller: _controller,
              onPageChanged: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
              children: const [
                OnboardingPage(
                  title: 'Quality',
                  buttonColor: Color(0xFF5EA25F),
                  description:
                      'Sell your farm fresh products directly to consumers, cutting out the middleman and reducing emissions of the global supply chain. ',
                  imageAsset: 'assets/images/boarding1.png',
                  no: 0,
                ),
                OnboardingPage(
                  title: 'Convenient',
                  buttonColor: Color(0xFFD5715B),
                  description:
                      'Our team of delivery drivers will make sure your orders are picked up on time and promptly delivered to your customers.',
                  imageAsset: 'assets/images/boarding2.png',
                  no: 1,
                ),
                OnboardingPage(
                  title: 'Local',
                  buttonColor: Color(0xFFF8C569),
                  description:
                      'We love the earth and know you do too! Join us in reducing our local carbon footprint one order at a time. ',
                  imageAsset: 'assets/images/boarding3.png',
                  no: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingPage extends StatefulWidget {
  final String imageAsset;
  final String title;
  final String description;
  final Color buttonColor;
  final int no;

  const OnboardingPage(
      {super.key,
      required this.imageAsset,
      required this.title,
      required this.description,
      required this.buttonColor,
      required this.no});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  Widget build(BuildContext context) {
    int selectedIndex = widget.no;
    return Container(
      color: widget.buttonColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 30),
          Expanded(
            child: Image.asset(
              widget.imageAsset,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(50))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35.0),
                    child: Text(
                      widget.description,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w200),
                    ),
                  ),
                  const SizedBox(height: 35),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: selectedIndex == index ? 16 : 7,
                        height: 7,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 45),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          widget.buttonColor, // Set button background to white
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 15.0),
                    ),
                    onPressed: () {},
                    child: const Text(
                      'Join the movement!',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                    },
                    child: const Text('Login',
                        style: TextStyle(
                            fontSize: 14,
                            decoration: TextDecoration.underline,
                            color: Colors.black)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
