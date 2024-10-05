// ignore_for_file: avoid_print, camel_case_types

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const WebApp());
}

double opacitylevel = 1;
double opacitylevel2 = 1-opacitylevel;
double opacitylevel3 = 0;
double opacitylevel4 = 0;
double scrollposition = 0;
bool clicked = false;
bool clicked1 = false;


class WebApp extends StatefulWidget {
  const WebApp({super.key});

  @override
  State<WebApp> createState() => _WebAppState();
}

class _WebAppState extends State<WebApp> with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late AnimationController _animationController;
  //  void initState() {
  //   super.initState();

  //   _scrollController.addListener(_scrollListener);
  // }

  void _scrollToItem(int index) {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        index * MediaQuery.of(context).size.height * 1.1,
        duration: const Duration(seconds: 2),
        curve: Curves.easeOutSine,
      );
      // print("has clients");
    } else {
      // print("no clients");
    }
  }

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 3),
        upperBound: 1,
        lowerBound: 0);
    _scrollController.addListener(() {
      print(_scrollController.offset / 1000);
      _animationController.value = (_scrollController.offset / 1000) > 1
          ? 1
          : (_scrollController.offset / 1000);
      setState(() {
        opacitylevel = _scrollController.offset / 1000 > 1.1 ? 0 : 1;
        scrollposition = _scrollController.offset / 1000;
      });
    });
   
    super.initState();
  }

  void opacitycontrol(){
    setState(() {
      
      opacitylevel2 = 0;
      opacitylevel3 = 1;
      _scrollToItem(3);
      clicked = true;

    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Web App'),
          
        ),
        body: Stack(
          children: [
            ListView(
              controller: _scrollController,
              scrollDirection: Axis.vertical,
              children: [
                slide1(onPressed: () => _scrollToItem(1)),
                const slide2(),
                const slide3(),
              ],
            ),
            clicked ? Container():  Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    scrollposition < 1.2
                        ? AnimatedOpacity(
                            opacity: opacitylevel,
                            duration: const Duration(seconds: 2),
                            child: Container(
                              //margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05),
                              // width: MediaQuery.of(context).size.width*0.3,
                              height: MediaQuery.of(context).size.height * 0.94,
                              color: const Color.fromARGB(5, 0, 255, 60),
                              child: Lottie.asset(
                                'assets/lottie/1st_seq_lottie.json',
                                controller: _animationController,
                                fit: BoxFit.fill,
                                // onLoaded: (animation) {

                                //   _animationController
                                //     ..duration = animation.duration
                                //     ..repeat(reverse: true);
                                // },
                              ),
                            ),
                          )
                        : AnimatedOpacity(
                            opacity:  opacitylevel2,
                            duration: const Duration(seconds: 2),
                            child: Container(
                              height:
                                  MediaQuery.of(context).size.height * 0.94,
                              color: const Color.fromARGB(5, 0, 255, 60),
                              child: Stack(
                                alignment: Alignment.topCenter,
                              
                              
                                children: [
                                  Image.asset(
                                    'assets/images/TopView.png',
                                    fit: BoxFit.fill,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                   
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.075),
                                        child: Row(
                                        
                                          children: [
                                            IconButton(onPressed: (){
                                              opacitycontrol();
                                             
                                            }, icon: const Icon(Icons.place_rounded) ,style: IconButton.styleFrom(backgroundColor: Colors.white,),),
                                            SizedBox(width: MediaQuery.of(context).size.width*0.08,),
                                            IconButton(onPressed: (){
                                             opacitycontrol();
                                            }, icon: const Icon(Icons.place_rounded),style: IconButton.styleFrom(backgroundColor: Colors.white,),),
                                          ],
                                        ),
                                        
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.26),
                                        child: Row(
                                        
                                          children: [
                                            IconButton(onPressed: (){}, icon: const Icon(Icons.place_rounded) ,style: IconButton.styleFrom(backgroundColor: Colors.white,),),
                                            SizedBox(width: MediaQuery.of(context).size.width*0.08,),
                                            //IconButton(onPressed: (){}, icon: Icon(Icons.place_rounded),style: IconButton.styleFrom(backgroundColor: Colors.white,),),
                                          ],
                                        ),
                                        
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.32),
                                        child: Row(
                                        
                                          children: [
                                            IconButton(onPressed: (){}, icon: const Icon(Icons.place_rounded) ,style: IconButton.styleFrom(backgroundColor: Colors.white,),),
                                            SizedBox(width: MediaQuery.of(context).size.width*0.08,),
                                            IconButton(onPressed: (){}, icon: const Icon(Icons.place_rounded),style: IconButton.styleFrom(backgroundColor: Colors.white,),),
                                          ],
                                        ),
                                        
                                      ),
                                    ],
                                  ),
                                 
                                ],
                              ),
                            ),
                        ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class slide1 extends StatelessWidget {
  final VoidCallback onPressed;

  const slide1({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 1,
      color: const Color.fromARGB(255, 255, 255, 255),
      child: Center(
        child: ElevatedButton(
          onPressed: onPressed,
          child: const Text('Slide 1'),
        ),
      ),
    );
  }
}

class slide2 extends StatelessWidget {
  const slide2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: const Color.fromARGB(255, 255, 255, 255),
    );
  }
}
class slide3 extends StatefulWidget {
 


  const slide3({super.key});

  @override
  State<slide3> createState() => _slide3State();
}

class _slide3State extends State<slide3> with SingleTickerProviderStateMixin {
  late AnimationController _animationControllerbelow;
  
  @override
  void initState() {
    super.initState();
    _animationControllerbelow = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
      upperBound: 1,
      lowerBound: 0,
    );
  }
  
  void _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
  void startAnimation() {
    _animationControllerbelow.forward();
  }
  void updateOpacity(){
    setState(() {
      opacitylevel4 = 1;
      clicked1 = true;
    });
  }

  @override
  void dispose() {
    _animationControllerbelow.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: const Color.fromARGB(255, 255, 255, 255),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            //alignment: Alignment.center,
              
            children: [
             const Column( 
               children: [
                  Row(
                    
                     mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                 
                      Center(child: Text('360° Virtual Tour',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),),
                   
                  ],),
               ],
             ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // ignore: sized_box_for_whitespace
                Container(
                  height: MediaQuery.of(context).size.height * 0.94,
                  child: AnimatedOpacity(
                    opacity: opacitylevel3,
                    duration: const Duration(seconds: 2),
                    child: Lottie.asset(
                      'assets/lottie/ne_camera_lottie.json',
                      fit: BoxFit.fill,
                      controller: _animationControllerbelow,
                    ),
                  ),
                ),
                
              ],
            ),
            clicked1 ? Container():Container(
              
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.45),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [ 
                  SizedBox(width: MediaQuery.of(context).size.width*0.055,),
                  IconButton(onPressed: (){
                    startAnimation();
      
                    updateOpacity();
                    print(opacitylevel4);
      
                  }, icon: const Icon(Icons.place) , style: IconButton.styleFrom(backgroundColor: Colors.white,iconSize: 40,),),
                  SizedBox(width: MediaQuery.of(context).size.width*0.1,),
                   IconButton(onPressed: (){
                    startAnimation();
                    updateOpacity();
                                       }, icon: const Icon(Icons.place), style: IconButton.styleFrom(backgroundColor: Colors.white,iconSize: 40,),),
                ],
              ),
            ),
            Container(
               margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.33 , left: MediaQuery.of(context).size.width*0.15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                   AnimatedOpacity(
                    curve: Curves.easeInExpo,
                     opacity: opacitylevel4,
                     duration: const Duration(seconds: 3),
                     child: IconButton(onPressed: (){
                      _launchURL('https://celumestudios.com/virtual-tour');
                     }, icon: const Icon(Icons.threed_rotation_sharp ), style: IconButton.styleFrom(backgroundColor: Colors.white,iconSize: 30
                                        ,),),
                   )
                  ],
                ),
            )
            ],
          ),
        ],
      ),
    );
  }
}
//  Future<void> _launchWebsite() async {
//     if (await canLaunch(websiteLink)) {
//       await launch(websiteLink);
//     } else {
//       throw 'Could not launch $websiteLink';
//     }
//   }

