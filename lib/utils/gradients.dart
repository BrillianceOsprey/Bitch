import 'package:flutter/material.dart';

class Gradients extends StatefulWidget {
  const Gradients({Key? key}) : super(key: key);

  @override
  _GradientsState createState() => _GradientsState();
}

class _GradientsState extends State<Gradients> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.lightBlue, Colors.deepPurple],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
              ),
            ),
            child: Column(
              children: [
                Stack(
                  // alignment: Alignment.topCenter,
                  children: const [
                    WavyHeader(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class WavyHeader extends StatelessWidget {
  const WavyHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: TopWaveClipper(),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: purpleGradients,
              begin: Alignment.topRight,
              end: Alignment.center),
        ),
        height: MediaQuery.of(context).size.height / 1.5,
      ),
    );
  }
}

const List<Color> purpleGradients = [
  Colors.deepPurple,
  Colors.deepPurpleAccent,
  Colors.deepPurple
];

class TopWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // This is where we decide what part of our image is going to be visible.
    var path = Path();
    path.lineTo(0.0, size.height);

    var firstControlPoint = Offset(size.width / 4, size.height - 30);
    var firstEndPoint = Offset(size.width / 2, size.height / 1.5);

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint = Offset(size.width / 1, size.height / 8);
    var secondEndPoint = Offset(size.width / 0.5, size.height / 1);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    var thirdControlPoint =
        Offset(size.width - (size.width / 9), size.height / 6);
    var thirdEndPoint = Offset(size.width, 0.0);
    path.quadraticBezierTo(thirdControlPoint.dx, thirdControlPoint.dy,
        thirdEndPoint.dx, thirdEndPoint.dy);

    ///move from bottom right to top
    path.lineTo(size.width, 0.0);

    ///finally close the path by reaching start point from top right corner
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
