import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerCommunityScreen extends StatelessWidget {
  const ShimmerCommunityScreen({super.key});



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
              height: 200,
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
                      Expanded(
                        child: Container(
                          height: 20,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                      ),

                    ],
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
                            width: index==2?200:double.infinity,
                            height: 15,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  SizedBox(height: 10),

                  Container(
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height:10),
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
              height: 200,
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
                      Expanded(
                        child: Container(
                          height: 20,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                      ),

                    ],
                  ),
                  SizedBox(height: 10),
                  // Second row: Three lines of text
                  Column(
                    children: List.generate(3, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Container(
                          width: double.infinity,
                          height: 15,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                      );
                    }),
                  ),
                  SizedBox(height: 10),

                  Container(
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(5),
                    ),
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