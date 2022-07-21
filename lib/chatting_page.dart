import 'package:flutter/material.dart';

class ChattingPage extends StatefulWidget {
  const ChattingPage({Key? key}) : super(key: key);

  @override
  State<ChattingPage> createState() => _ChattingPageState();
}

class _ChattingPageState extends State<ChattingPage>
    with TickerProviderStateMixin {


  double turns = 0.0;
  bool isClicked = false;
  late AnimationController _controller;

  @override
  void initState() {
    _controller =
        AnimationController(duration: Duration(microseconds: 600), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          //버튼에 애니메이션주기
          child: AnimatedRotation(
            curve: Curves.easeOutExpo,
            turns: turns,
            duration: Duration(seconds: 1),
            //버튼 모양/기능
            child: GestureDetector(
              onTap: () {
                if (isClicked == true) {
                  setState(() {
                    turns -= 1 / 4;
                  });
                  _controller.reverse();
                } else {
                  setState(() {
                    turns += 1 / 4;
                  });
                  _controller.forward();
                }
                setState(() {
                  isClicked = !isClicked;
                });
              },
              child: AnimatedContainer(
                curve: Curves.easeOutExpo,
                duration: Duration(seconds: 1),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: Colors.blueAccent,
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 30.0,
                      offset:Offset(20, 20),
                      color: Colors.grey,
                    ),
                    BoxShadow(
                      blurRadius: 30.0,
                      offset: Offset(-20, -20),
                      color: Colors.white,
                    )
                  ],
                ),
                child: SizedBox(
                  height: 150,
                  width: 150,
                  child: Center(
                    child: AnimatedIcon(
                      icon: AnimatedIcons.menu_close,
                      progress: _controller,
                      size: 100,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
