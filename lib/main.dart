import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(WebApp());
}

double opacitylevel = 1;
double scrollposition = 0;

class WebApp extends StatefulWidget {
  WebApp({super.key});

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
  void _scrollListener() {
    double offset = _scrollController.offset;

    double threshold1 = MediaQuery.of(context).size.height * 0.5;
    double threshold5 = MediaQuery.of(context).size.height * 4.5;
  }

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Web App'),
        ),
        body: Stack(
          children: [
            ListView(
              controller: _scrollController,
              scrollDirection: Axis.vertical,
              children: [
                slide1(onPressed: () => _scrollToItem(1)),
                slide2(),
                slide3(),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    scrollposition < 1.2
                        ? AnimatedOpacity(
                            opacity: opacitylevel,
                            duration: Duration(seconds: 2),
                            child: Container(
                              //margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05),
                              // width: MediaQuery.of(context).size.width*0.3,
                              height: MediaQuery.of(context).size.height * 0.94,
                              color: Color.fromARGB(5, 0, 255, 60),
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
                            opacity: 1 - opacitylevel,
                            duration: Duration(seconds: 2),
                            child: Container(
                              height:
                                  MediaQuery.of(context).size.height * 0.94,
                              color: Color.fromARGB(5, 0, 255, 60),
                              child: Container(
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
                                              IconButton(onPressed: (){}, icon: Icon(Icons.place_rounded) ,style: IconButton.styleFrom(backgroundColor: Colors.white,),),
                                              SizedBox(width: MediaQuery.of(context).size.width*0.08,),
                                              IconButton(onPressed: (){}, icon: Icon(Icons.place_rounded),style: IconButton.styleFrom(backgroundColor: Colors.white,),),
                                            ],
                                          ),
                                          
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.26),
                                          child: Row(
                                          
                                            children: [
                                              IconButton(onPressed: (){}, icon: Icon(Icons.place_rounded) ,style: IconButton.styleFrom(backgroundColor: Colors.white,),),
                                              SizedBox(width: MediaQuery.of(context).size.width*0.08,),
                                              //IconButton(onPressed: (){}, icon: Icon(Icons.place_rounded),style: IconButton.styleFrom(backgroundColor: Colors.white,),),
                                            ],
                                          ),
                                          
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.32),
                                          child: Row(
                                          
                                            children: [
                                              IconButton(onPressed: (){}, icon: Icon(Icons.place_rounded) ,style: IconButton.styleFrom(backgroundColor: Colors.white,),),
                                              SizedBox(width: MediaQuery.of(context).size.width*0.08,),
                                              IconButton(onPressed: (){}, icon: Icon(Icons.place_rounded),style: IconButton.styleFrom(backgroundColor: Colors.white,),),
                                            ],
                                          ),
                                          
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
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
          child: Text('Slide 1'),
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

class slide3 extends StatelessWidget {
  const slide3({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: const Color.fromARGB(255, 255, 255, 255),
    );
  }
}
