import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerPreviousQuestionScreen extends StatelessWidget {
  const ShimmerPreviousQuestionScreen({super.key});



  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin:EdgeInsets.only(top:20),
          padding:EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.grey..withOpacity(0.1),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: 400,
              height: 250,
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // First row: User image, username, and time
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      SizedBox(width: 10),
                      Container(
                        width:200,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),

                    ],
                  ),
                  SizedBox(height: 10),
                  Column(
                    children: List.generate(2, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Align(
                          alignment:Alignment.centerLeft,
                          child: Container(
                            width:index==1? 200: double.infinity,
                            height: 15,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  SizedBox(height: 10),
                  // Second row: Three lines of text
                  Column(
                    children: List.generate(3, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Align(
                          alignment:Alignment.centerLeft,
                          child: Container(
                            width: double.infinity,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  SizedBox(height: 10),

                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}