import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerHomeScreen extends StatelessWidget {
  const ShimmerHomeScreen({super.key});



  @override
  Widget build(BuildContext context) {
    return Container(
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
          height:290,
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
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    // margin:EdgeInsets.only(bottom:20),
                    width:100,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),

                ],
              ),
              SizedBox(height: 20),
              // Second row: Three lines of text
              Column(
                children: List.generate(1, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      width: double.infinity,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  );
                }),
              ),
              Column(
                children: List.generate(1, (index) {
                  return Container(
                    width: 200,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(25),
                    ),
                  );
                }),
              ),
              SizedBox(height: 20),

              Center(
                child: Column(
                  children: List.generate(3, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Container(
                        width: 230,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}