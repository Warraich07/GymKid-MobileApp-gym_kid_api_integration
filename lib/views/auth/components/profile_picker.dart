import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../controllers/auth_controller.dart';
import '../../../res/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';


class ProfilePicker extends StatefulWidget {
  const ProfilePicker({super.key, this.forMyProfile,this.imagePath,required this.isFromSignUp});
  final String? imagePath;
  final bool isFromSignUp;
  @override
  State<ProfilePicker> createState() => _ProfilePickerState();
  final bool?forMyProfile;
}

class _ProfilePickerState extends State<ProfilePicker> {
  // Controller
  final AuthController _authController=Get.find();
  ImagePicker picker = ImagePicker();
  XFile? image;
  @override
  Widget build(BuildContext context) {
    return
      Column(
        children: [
          Center(
            child: Stack(
              children: [
                Container(
                    height: 130,
                    width: 130,
                    decoration: BoxDecoration(
                        border: Border.all(color:widget.forMyProfile==false? Colors.white:AppColors.primaryColor,width: 1.5),
                        color: widget.forMyProfile==false?AppColors.primaryColor:Colors.white, shape: BoxShape.circle),
                    child: image != null
                        ? ClipRRect(
                        borderRadius: BorderRadius.circular(90),
                        child: Image(
                          image: FileImage(File(image!.path)),
                          fit: BoxFit.cover,
                          height: Get.height,
                          width: Get.width,
                        ))
                        :
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: CachedNetworkImage(
                        // memCacheWidth: 150,
                        // memCacheHeight: 150,
                        // maxHeightDiskCache: 150,
                        // maxWidthDiskCache: 150,
                        imageUrl:widget.imagePath??'',
                        placeholder: (context, url) =>
                            Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.primaryColor,
                                )),
                        errorWidget: (context, url,
                            error) =>
                                Center(
                                  child: Text("Select Image",style: TextStyle(color: Colors.black),),
                                ),
                        fit: BoxFit.cover,
                        scale:20 ,
                      ),
                    )
                  // Image.asset(
                  //   widget.imagePath??"assets/app_images/upload_image.png",scale: 5.3,
                  //   color:   widget.forMyProfile==false?AppColors.whiteColor:AppColors.primaryColor,
                  //
                  // ),
                ),
                Positioned(
                  bottom: 5,
                  right: 3,
                  child: GestureDetector(
                    onTap: () async {
                      if(widget.isFromSignUp){
                        // print(_authController.imagePath.value);
                        image = await picker.pickImage(
                            source: ImageSource.gallery);
                        _authController.updateImagePathForSignUp(image!.path.toString());
                        // _authController.completeProImagePath(image!.path.toString());
                        setState(() {});
                      }else{
                        print(_authController.imagePath.value);
                        image = await picker.pickImage(
                            source: ImageSource.gallery);
                        _authController.updateImagePath(image!.path.toString());
                        // _authController.completeProImagePath(image!.path.toString());
                        setState(() {});
                      }

                    },
                    child: Container(
                      height: 32,
                      width: 32,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: widget.forMyProfile==false?Colors.white:AppColors.primaryColor),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 1),
                        child: Icon(
                          CupertinoIcons.camera_fill,
                          size: 16,
                          color:widget.forMyProfile==false? AppColors.primaryColor:Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),

          ),
          SizedBox(height:8),
          BoldText(Text: "Upload Image",color: widget.forMyProfile==true?Colors.black:Colors.white)
        ],
      );




  }

}


class BoldText extends StatefulWidget {
  const BoldText({
    super.key,
    required this.Text,
    this.TextALign,
    this.maxLines,
    this.color,
    this.fontSize, this.height,
  });
  final String Text;
  final int? maxLines;
  final TextAlign? TextALign;
  final Color? color;
  final double? fontSize;
  final double? height;

  @override
  State<BoldText> createState() => _BoldTextState();
}

class _BoldTextState extends State<BoldText> {
  @override
  Widget build(BuildContext context) {
    return Text(

      widget.Text,
      style: TextStyle(
        height: widget.height,overflow: TextOverflow.ellipsis,
        fontSize: widget.fontSize??15,
        color: widget.color??Colors.white,
        fontFamily: "bold",
      ),
      textAlign: widget.TextALign,
      maxLines: widget.maxLines,
      overflow: TextOverflow.ellipsis,


    );
  }
}



// class ProfilePicker extends StatefulWidget {
//   const ProfilePicker({super.key, this.forMyProfile});
//
//   @override
//   State<ProfilePicker> createState() => _ProfilePickerState();
//   final bool?forMyProfile;
// }
//
// class _ProfilePickerState extends State<ProfilePicker> {
//   // Controller
//   final AuthController _authController=Get.find();
//   ImagePicker picker = ImagePicker();
//   XFile? image;
//   @override
//   Widget build(BuildContext context) {
//     return
//       Column(
//         children: [
//           Center(
//             child: Stack(
//               children: [
//                 Container(
//                   height: 130,
//                   width: 130,
//                   decoration: BoxDecoration(
//                       border: Border.all(color:widget.forMyProfile==false? Colors.white:AppColors.primaryColor,width: 1.5),
//                       color: widget.forMyProfile==false?AppColors.primaryColor:Colors.white, shape: BoxShape.circle),
//                   child: image != null
//                       ? ClipRRect(
//                       borderRadius: BorderRadius.circular(90),
//                       child: Image(
//                         image: FileImage(File(image!.path)),
//                         fit: BoxFit.cover,
//                         height: Get.height,
//                         width: Get.width,
//                       ))
//                       : Image.asset(
//                     "assets/app_images/upload_image.png",scale: 5.3,
//                     // color:   widget.forMyProfile==false?Colors.white:AppColors.primaryColor,
//
//                   ),
//                 ),
//                 Positioned(
//                   bottom: 5,
//                   right: 3,
//                   child: GestureDetector(
//                     onTap: () async {
//                       image = await picker.pickImage(
//                           source: ImageSource.gallery);
//                       _authController.updateImagePath(image!.path.toString());
//                       setState(() {});
//                     },
//                     child: Container(
//                       height: 32,
//                       width: 32,
//                       decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: widget.forMyProfile==false?Colors.white:AppColors.primaryColor),
//                       child: Padding(
//                         padding: const EdgeInsets.only(left: 1),
//                         child: Icon(
//                           CupertinoIcons.camera_fill,
//                           size: 16,
//                           color:widget.forMyProfile==false? AppColors.primaryColor:Colors.white,
//                         ),
//                       ),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//
//           ),
//           SizedBox(height:8),
//           Text( "Upload Image",style: TextStyle(color: Colors.white),)
//         ],
//       );
//
//
//
//
//   }
//
// }

