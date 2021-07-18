//import 'package:screens/constants.dart';
import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import '../constants.dart';

class OnBoardScreen extends StatefulWidget {

  @override
  _OnBoardScreenState createState() => _OnBoardScreenState();
}

final _controller = PageController(
  initialPage: 0,
);

int _currentPage = 0;

List<Widget> _pages=[
  Column(
    children: [
      Expanded(child: Image.asset('images/grocry.png')),
      Text('Order from Your Fav Store',style: kPageViewTextStyle,),
    ],
  ),
  Column(
    children: [
      Expanded(child: Image.asset('images/mapicon.png')),
      Text('Deliver to Your Doorstep',style: kPageViewTextStyle,),
    ],
  ),
];

class _OnBoardScreenState extends State<OnBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children:[
        Expanded(
          child: PageView(
            controller: _controller,
            children: _pages,
            onPageChanged: (index){
              setState(() {
                _currentPage=index;
              });
            },
          ),
        ),
        DotsIndicator(
          dotsCount: _pages.length,
          position: _currentPage.toDouble(),
          decorator: DotsDecorator(
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
              activeColor: Colors.blueAccent
          ),
        ),
        SizedBox(height: 20,),
      ],
    );
  }
}
