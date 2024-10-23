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
  double _lastScrollOffset = 0.0;
  double _scrollSpeed = 0.0;
  bool _isAutoScrolling = false;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller for Lottie animation
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    // Add a listener to the ScrollController to update Lottie animation based on scroll position
    _scrollController.addListener(() {
      if (!_isAutoScrolling) {
        // Calculate scroll speed
        _scrollSpeed = (_scrollController.offset - _lastScrollOffset).abs();
        _lastScrollOffset = _scrollController.offset;

        // Sync Lottie animation with scroll
        _syncLottieWithScroll();

        // Show or hide the app bar based on scroll direction
        if (_scrollController.position.userScrollDirection == ScrollDirection.reverse) {
          setState(() {
            _isAppBarVisible = false;
          });
        } else if (_scrollController.position.userScrollDirection == ScrollDirection.forward) {
          setState(() {
            _isAppBarVisible = true;
          });
        }
      }
    });
  }

  // Sync Lottie animation with the current scroll position
  void _syncLottieWithScroll() {
    double maxScrollExtent = _scrollController.position.maxScrollExtent;
    double scrollOffset = _scrollController.offset;

    // Calculate the target animation progress based on scroll percentage
    double targetProgress = (scrollOffset / maxScrollExtent).clamp(0.0, 1.0);

    // Smoothly transition the animation controller value to the target progress
    _animationController.animateTo(
      targetProgress,
      duration: const Duration(milliseconds: 300), // Adjust duration for smoothness
      curve: Curves.easeInOut,
    );
  }

  // Trigger auto-scrolling and sync with Lottie animation
  void _triggerAutoScroll() {
    _isAutoScrolling = true;

    // Scroll to the bottom smoothly
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent, // Scroll to the bottom
      duration: const Duration(seconds: 3), // Adjust speed to match your needs
      curve: Curves.easeOut,
    ).then((_) {
      // Ensure Lottie animation is synced
      _syncLottieWithScroll();
      _isAutoScrolling = false;
    });
  }

  // New method to handle "Choose Home" navigation
  void _chooseHome() {
    _triggerAutoScroll(); // Scroll to the end
    _animationController.forward(from: 0); // Start the Lottie animation
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
                decoration: const BoxDecoration(
                  color: Colors.black12,
                ),
              ),
              title: Row(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.08,
                    child: Image.asset("assets/images/jana_logo.png"),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: _chooseHome, // Trigger the choose home action
                    child: const Text(
                      'Choose Home',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  const _NavBarItem(title: 'Home'),
                  const _NavBarItem(title: 'Store'),
                  const _NavBarItem(title: 'Projects'),
                  const _NavBarItem(title: 'Technology'),
                  const _NavBarItem(title: 'About Us'),
                  const _NavBarItem(title: 'Contact'),
                  IconButton(
                    icon: const Icon(Icons.account_circle, color: Colors.black),
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
                      const Text(
                        'Janapriya Upscale Bahiti',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(60, 135, 112, 1)
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Chandanagar',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 24),
                      const _CustomTextField(hintText: 'Name'),
                      const _CustomTextField(hintText: 'Email'),
                      const _CustomTextField(hintText: 'Phone'),
                      const _CustomDropdown(items: ['Apartment', 'Villa', 'Plot'], hintText: 'Property Unit Type'),
                      const _CustomDropdown(items: ['Morning', 'Afternoon', 'Evening'], hintText: 'Preferred Site Visit'),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Checkbox(value: true, onChanged: (value) {}),
                          const Expanded(
                            child: Text(
                              'I allow Janapriya Upscale representatives to override DND registration (if any) and contact me through call, SMS, email or WhatsApp.',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text('Submit'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        ),
                      ),
                      const SizedBox(height: 32),
                      const Text("The Houses have the following amenities available"),
                      const SizedBox(height: 32),
                      Image.asset('assets/images/info.jpg'), // Add the new image here
                      const SizedBox(height: 30),
                      const Text(
                        "Try our method of choosing a house of your preference in 3 steps",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      Row(
                        children: [
                          const Text("==>"),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const Screen2()),
                              );
                            },
                            child: const Text(
                              "Step-1",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.redAccent,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Lottie.asset(
                  'assets/lottie/1st_seq_lottie.json',
                  controller: _animationController,
                  width: MediaQuery.of(context).size.width * 0.2, // Limit Lottie file width to 0.2 screen width
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
        style: const TextStyle(color: Colors.black, fontSize: 16),
      ),
    );
  }
}

class Screen2 extends StatelessWidget {
  const Screen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.8),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            color: Colors.black12,
          ),
        ),
        title: Row(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.08,
              child: Image.asset("assets/images/jana_logo.png"),
            ),
            const Spacer(),
            const _NavBarItem(title: 'Home'),
            const _NavBarItem(title: 'Store'),
            const _NavBarItem(title: 'Projects'),
            const _NavBarItem(title: 'Technology'),
            const _NavBarItem(title: 'About Us'),
            const _NavBarItem(title: 'Contact'),
            IconButton(
              icon: const Icon(Icons.account_circle, color: Colors.black),
              onPressed: () {},
            ),
          ],
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
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
                  const Text(
                    'Choose Your Home',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'in 3 Simple Steps',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Step 1: Select a Block',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Please choose any apartment block from the map to begin the process. Each block offers unique features and amenities:',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Block A: Offers a scenic view of the park and includes a community hall.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Block B: Features a rooftop swimming pool and a modern gym.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Block C: Known for its spacious apartments and proximity to the shopping center.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Block D: Includes a children’s play area and a pet-friendly environment.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Block E: Offers premium penthouses with private terraces and garden views.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              flex: 5,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SideSelectionScreen()),
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
    precacheImage(const AssetImage('assets/images/build1.jpg'), context);
    precacheImage(const AssetImage('assets/images/build2.jpg'), context);
    precacheImage(const AssetImage('assets/images/Fp_removedBg.png'), context);
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
        backgroundColor: Colors.white.withOpacity(0.8),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            color: Colors.black12,
          ),
        ),
        title: Row(
          children: [
            IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back)),
            Container(
              height: MediaQuery.of(context).size.height * 0.08,
              child: Image.asset("assets/images/jana_logo.png"),
            ),
            const Spacer(),
            const _NavBarItem(title: 'Home'),
            const _NavBarItem(title: 'Store'),
            const _NavBarItem(title: 'Projects'),
            const _NavBarItem(title: 'Technology'),
            const _NavBarItem(title: 'About Us'),
            const _NavBarItem(title: 'Contact'),
            IconButton(
              icon: const Icon(Icons.account_circle, color: Colors.black),
              onPressed: () {},
            ),
          ],
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Choose Your Home',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'in 3 Simple Steps',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Step 1: Select a Block',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Please choose any apartment block from the map to begin the process.',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Step 2: Choose the Side',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent,
                    ),
                  ),
                  const SizedBox(height: 8),
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
                    const Text(
                      'Step 3: Check the Interior',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                      ),
                    ),
                    const SizedBox(height: 8),
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
            SizedBox(width: 90,),
            if(_showInitialImage)
            Image.asset(
              'assets/images/mp_removedBg.png',
              fit: BoxFit.contain,
              height: MediaQuery.of(context).size.height,
            ),
            if(_showLottieAnimation)
            Image.asset(
                        'assets/images/Fp_removedBg.png',
                        fit: BoxFit.contain,
                        // width: double.infinity,
                        height: MediaQuery.of(context).size.height,
                      ),
            if(_showFinalSlide)
            Image.asset(
                        'assets/images/Fp_removedBg.png',
                        fit: BoxFit.contain,
                        // width: double.infinity,
                        height: MediaQuery.of(context).size.height,
                      ),

            const SizedBox(width: 20),
            Expanded(
              flex: 5,
              child: GestureDetector(
                onTap: _onTap,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    
                    if (_showInitialImage)
                      Positioned(
                        right: 0,
                        child: Image.asset(
                          'assets/images/build1.jpg',
                          fit: BoxFit.contain,
                          height: MediaQuery.of(context).size.height,
                        ),
                      ),
                    if (_showLottieAnimation)
                      Positioned(
                        right: 0,
                        child: Lottie.asset(
                          'assets/lottie/ne_camera_lottie.json',
                          controller: _animationController,
                          height: MediaQuery.of(context).size.height,
                          onLoaded: (composition) {
                            _animationController.duration = composition.duration;
                          },
                        ),
                      ),
                    if (_showFinalSlide)
                      Positioned(
                        right: 0,
                        child: GestureDetector(
                          onTap: _openLink, // Launch URL on image tap
                          child: Image.asset(
                            'assets/images/build2.jpg', // Final image path
                            fit: BoxFit.contain,
                            height: MediaQuery.of(context).size.height, // Adjust height for layout
                          ),
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
          border: const OutlineInputBorder(),
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
        decoration: const InputDecoration(
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







