import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_kid/views/diary/my_diary.dart';
import 'package:motion/motion.dart';
import 'package:page_flip/page_flip.dart';
import 'package:sizer/sizer.dart';

import '../../components/page_navigation.dart';
import '../../controllers/gym_controller.dart';
import '../../res/colors.dart';
import '../calendar/emotions.dart';

class BookPageFlip extends StatefulWidget {
  @override
  _BookPageFlipState createState() => _BookPageFlipState();
}

class _BookPageFlipState extends State<BookPageFlip> {
  final _controller = GlobalKey<PageFlipWidgetState>();
  GymController _gymController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Get.isDarkMode ? AppColors.backgroundColor : AppColors.backgroundColor,
      body: PageFlipWidget(
        duration: Duration(milliseconds: 1000),
        key: _controller,
        backgroundColor: Colors.white,
        // lastPage: Container(
        //     color: Colors.white, child: const Center(child: Text('The End!'))),
        children: <Widget>[
          // for (var i = 0; i < _gymController.filteredNotes.length; i++)
            MyDiary(),
        ],
      ),
      floatingActionButton: Motion.elevated(
        filterQuality: FilterQuality.medium,
        elevation: 10,
        glare: true,
        borderRadius: BorderRadius.circular(40),
        // controller: MotionController(),
        child: GestureDetector(
          onTap: () {
            Get.to(() => const Emotions());
          },
          child: Container(
            width: 61,
            height: 61,
            decoration: const ShapeDecoration(
              gradient: LinearGradient(
                begin: Alignment(0.00, -1.00),
                end: Alignment(0, 1),
                colors: [Color(0xFFFED985), Color(0xFFE0AD3A)],
              ),
              shape: OvalBorder(),
              shadows: [
                BoxShadow(
                  color: Color(0x19000000),
                  blurRadius: 20,
                  offset: Offset(0, 0),
                  spreadRadius: 0,
                )
              ],
            ),
            child: const Center(
              child: Icon(
                Icons.edit,
                size: 25,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class NotebookLinesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1.0;

    // Define the gap between lines and the number of lines you want on the page
    final lineGap = 20.0;
    final numberOfLines = (size.height / lineGap).ceil();

    // Draw the lines
    for (var i = 0; i < numberOfLines; i++) {
      final y = i * lineGap;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
