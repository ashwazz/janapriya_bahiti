// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: JanapriyaUpscalePage(),
  ));
}

class JanapriyaUpscalePage extends StatefulWidget {
  @override
  _JanapriyaUpscalePageState createState() => _JanapriyaUpscalePageState();
}

class _JanapriyaUpscalePageState extends State<JanapriyaUpscalePage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final ScrollController _scrollController = ScrollController();
  bool _isAppBarVisible = true;

  @override
  void initState() {
    super.initState();
    
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _scrollController.addListener(() {
      double progress = _scrollController.offset / _scrollController.position.maxScrollExtent;
      _animationController.value = progress > 1 ? 1 : progress;

      // Show/Hide AppBar based on scroll direction
      if (_scrollController.position.userScrollDirection == ScrollDirection.reverse) {
        setState(() {
          _isAppBarVisible = false;
        });
      } else if (_scrollController.position.userScrollDirection == ScrollDirection.forward) {
        setState(() {
          _isAppBarVisible = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: _isAppBarVisible
          ? AppBar(
              backgroundColor: Colors.white.withOpacity(0.8),
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  color: Colors.black12
                  // gradient: LinearGradient(
                  //   colors: [Colors.white, Colors.black12],
                  //   begin: Alignment.topCenter,
                  //   end: Alignment.bottomCenter,
                  // ),
                ),
              ),
              title: Row(
                children: [
                  Text(
                    'Janapriya UPSCALE',
                    style: TextStyle(color: Colors.black),
                  ),
                  Spacer(),
                  _NavBarItem(title: 'Home'),
                  _NavBarItem(title: 'Store'),
                  _NavBarItem(title: 'Projects'),
                  _NavBarItem(title: 'Technology'),
                  _NavBarItem(title: 'About Us'),
                  _NavBarItem(title: 'Contact'),
                  IconButton(
                    icon: Icon(Icons.account_circle, color: Colors.black),
                    onPressed: () {},
                  ),
                ],
              ),
              elevation: 0,
              automaticallyImplyLeading: false,
            )
          : null,
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Janapriya Upscale Bahiti',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Chandanagar',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 24),
                      _CustomTextField(hintText: 'Name'),
                      _CustomTextField(hintText: 'Email'),
                      _CustomTextField(hintText: 'Phone'),
                      _CustomDropdown(items: ['Apartment', 'Villa', 'Plot'], hintText: 'Property Unit Type'),
                      _CustomDropdown(items: ['Morning', 'Afternoon', 'Evening'], hintText: 'Preferred Site Visit'),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Checkbox(value: true, onChanged: (value) {}),
                          Expanded(
                            child: Text(
                              'I allow Janapriya Upscale representatives to override DND registration (if any) and contact me through call, SMS, email or WhatsApp.',
                            ),
                          ),
                          
                        ],
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text('Submit'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        ),
                      ),
                      SizedBox(height: 32),
                      Image.asset('assets/images/info.jpg'), // Add the new image here
                      SizedBox(height: 30,),
                      Text("Select any house of your preference in 3 steps"),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Screen2()),
                              );
                            },
                            child: Text("Select house"),
                          ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Lottie.asset(
                  'assets/lottie/1st_seq_lottie.json',
                  width: MediaQuery.of(context).size.width * 0.3, // Limit Lottie file width to 0.3 screen width
                  controller: _animationController,
                  onLoaded: (composition) {
                    _animationController.duration = composition.duration;
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final String title;

  const _NavBarItem({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        title,
        style: TextStyle(color: Colors.black, fontSize: 16),
      ),
    );
  }
}

class Screen2 extends StatelessWidget {
  const Screen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Choose Your Home',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'in 3 Simple Steps',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Step 1: Select a Block',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Please choose any apartment block from the map to begin the process.',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              flex: 5,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SideSelectionScreen()),
                  );
                },
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: Image.asset(
                    'assets/images/TOPVIEW (1).jpg',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}





class SideSelectionScreen extends StatefulWidget {
  const SideSelectionScreen({super.key});

  @override
  State<SideSelectionScreen> createState() => _SideSelectionScreenState();
}

class _SideSelectionScreenState extends State<SideSelectionScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool _showInitialImage = true;
  bool _showLottieAnimation = false;
  bool _showFinalSlide = false; // Single final slide

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            _showLottieAnimation = false;
            _showFinalSlide = true; // Show the final slide after animation
          });
        }
      });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Preload images for smoother transitions
    precacheImage(AssetImage('assets/images/build1.jpg'), context);
    precacheImage(AssetImage('assets/images/build2.jpg'), context);
    
    // Preload Lottie animation
    precacheImage(NetworkImage('https://assets/lottiefiles.com/path/to/your/lottie.json'), context);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onTap() {
    // Reset state if the final slide is shown
    if (_showFinalSlide) {
      setState(() {
        _showFinalSlide = false; // Hide the final slide
        _showInitialImage = true; // Reset to initial image
      });
      return; // Exit early if final slide is shown
    }

    // Play Lottie animation on first image tap
    if (_showInitialImage) {
      print("Tapped on initial image. Starting Lottie animation.");
      setState(() {
        _showInitialImage = false;
        _showLottieAnimation = true;
      });
      _animationController.forward(from: 0);
    } 
    // Handle tapping on the final slide image
    else if (_showFinalSlide) {
      _openLink(); // Launch the URL
    }
  }

  void _openLink() async {
    const url = 'https://celumestudios.com/virtual-tour';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Building Side'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Choose Your Home',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'in 3 Simple Steps',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Step 1: Select a Block',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Please choose any apartment block from the map to begin the process.',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Step 2: Choose the Side',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Please choose if you want the apartment to be front-facing or back-facing.',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 24), // Spacing between image and text
                  // Step 3 Text is displayed only if the final slide is visible
                  if (_showFinalSlide) ...[
                    Text(
                      'Step 3: Check the Interior',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Click on the image above to view the interior of the building.',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[700],
                      ),
                      textAlign: TextAlign.center, // Center align text
                    ),
                  ],
                ],
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              flex: 5,
              child: GestureDetector(
                onTap: _onTap,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    if (_showInitialImage)
                      Image.asset(
                        'assets/images/build1.jpg',
                        fit: BoxFit.contain,
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height,
                      ),
                    if (_showLottieAnimation)
                      Lottie.asset(
                        'assets/lottie/ne_camera_lottie.json',
                        controller: _animationController,
                        onLoaded: (composition) {
                          _animationController.duration = composition.duration;
                        },
                      ),
                    // Show the final slide with Step 3
                    if (_showFinalSlide)
                      GestureDetector(
                        onTap: _openLink, // Launch URL on image tap
                        child: Image.asset(
                          'assets/images/build2.jpg', // Final image path
                          fit: BoxFit.contain,
                          // width: double.infinity,
                          height: MediaQuery.of(context).size.height, // Adjust height for layout
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}








class _CustomTextField extends StatelessWidget {
  final String hintText;

  const _CustomTextField({required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: hintText,
        ),
      ),
    );
  }
}

class _CustomDropdown extends StatelessWidget {
  final List<String> items;
  final String hintText;

  const _CustomDropdown({required this.items, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
        ),
        hint: Text(hintText),
        items: items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (value) {},
      ),
    );
  }
}