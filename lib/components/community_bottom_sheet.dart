import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gym_kid/res/colors.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';

import '../constants/custom_validators.dart';
import '../controllers/auth_controller.dart';
import '../controllers/gym_controller.dart';
import '../helper/custom_dialogbox.dart';
import '../models/comments_model.dart';

class CommentsBottomSheet extends StatefulWidget {
   CommentsBottomSheet({super.key,required this.scrollController,required this.index,required this.postId});
  ScrollController scrollController;
  int index;
  int postId;
  @override
  State<CommentsBottomSheet> createState() => _CommentsBottomSheetState();
}

class _CommentsBottomSheetState extends State<CommentsBottomSheet> {

  GymController _gymController=Get.find();
  AuthController _authController=Get.find();

  @override
  Widget build(BuildContext context) {
    RefreshController _refreshController = RefreshController(initialRefresh: false);
    return  Obx(
        ()=> Container(
        padding: const EdgeInsets.all(16),
        color: const Color(0xFF2D2D2D),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Comments",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height:20),
            _gymController.isLoadingForComments.value==true? const Expanded(
              child: Center(
                  child:CircularProgressIndicator()
              ),
            ):  Expanded(
              child: SmartRefresher(
                enablePullDown: false,
                enablePullUp: true,
                controller: _refreshController,
                onLoading: () async {
                  if (_gymController.commentsCurrentPage.value<_gymController.commentsLastPage.value) {
                    await _gymController.getComments(_gymController.postId.value);

                    setState(() {});
                  }
                  _refreshController.loadComplete();
                },
                child: ListView.builder(
                  controller: widget.scrollController,  // Pass scrollController for scroll functionality
                  itemCount: _gymController.commentsList.length,  // Example with 20 comments
                  itemBuilder: (context, index2) {
                    return  Row(
                      children: [
                        Column(
                          mainAxisAlignment:MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: CachedNetworkImage(imageUrl: _gymController.commentsList[index2].getUser.image??'',
                                  placeholder: (context, url) =>
                                  const Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.black,
                                      )),
                                  errorWidget: (context, url,
                                      error) =>
                                      Image.asset(
                                        'assets/icons/profile2.png',
                                        height: 32,
                                      ),
                                  fit: BoxFit.cover,height: 32,width: 32,),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width:10),
                        Container(
                          width:75.w,
                          margin:const EdgeInsets.only(bottom:5),
                          height: 59,
                          decoration: ShapeDecoration(
                            color: Get.isDarkMode
                                ? const Color(0x994B4A4A)
                                : const Color(0x994B4A4A),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 5),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment:CrossAxisAlignment.center,
                                  children: [

                                    // Image.asset(
                                    //     "assets/img.png",height:40,width:40),

                                    const SizedBox(width:10),
                                    Column(
                                      mainAxisAlignment:MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                text: _gymController.commentsList[index2].getUser.name,
                                                style: TextStyle(
                                                  color: Get.isDarkMode
                                                      ? Colors.white
                                                      : Colors.white,
                                                  fontSize: 8,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                          _gymController.commentsList[index2].comment,
                                          style: TextStyle(
                                            color: Get.isDarkMode
                                                ? Colors.white
                                                : Colors.white,
                                            fontSize: 8,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),

                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                // height: 40,
                child: TextFormField(

                  validator: (value) => CustomValidator.isEmpty(value),
                  controller: _gymController.postsList[widget.index].textEditingController,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: 'Poppins',
                    // fontWeight: FontWeight.w400,
                  ),
                  decoration: InputDecoration(
                    fillColor: Get.isDarkMode
                        ? const Color(0xB24B4949)
                        : const Color(0xB24B4949),
                    filled: true,
                    contentPadding: const EdgeInsets.only(left: 20,right: 20),
                    hintStyle: TextStyle(
                      color: Get.isDarkMode
                          ? AppColors.yellowColor
                          : AppColors.yellowColor,
                      fontSize: 10,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                    border: InputBorder.none,
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0),
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                        // Make the border transparent
                        width:
                        0, // Set the width to 0 to make it disappear
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0),
                      borderSide: const BorderSide(
                        color: Colors
                            .transparent, // Make the border transparent
                        width:
                        0, // Set the width to 0 to make it disappear
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0),
                      borderSide: const BorderSide(
                        color: Colors
                            .transparent, // Make the border transparent
                        width:
                        0, // Set the width to 0 to make it disappear
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0),
                      borderSide: const BorderSide(
                        color: Colors
                            .transparent, // Make the border transparent
                        width:
                        0, // Set the width to 0 to make it disappear
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0),
                      borderSide: const BorderSide(
                        color: Colors
                            .transparent, // Make the border transparent
                        width:
                        0, // Set the width to 0 to make it disappear
                      ),
                    ),
                    hintText: 'Leave your thoughts here......',

                  ),
                ),
              ),
            ),
            const SizedBox(height:10),
            Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: (){
                  if(_gymController.postsList[widget.index].textEditingController.text.isEmpty){
                    CustomDialog.showErrorDialog(description: "Please write comment");
                  }else{
                    _gymController.addComment(widget.postId.toString(), _gymController.postsList[widget.index].textEditingController.text.toString(),_gymController.postsList[widget.index].id);

                    // _gymController.addAndGetComment(_gymController.postsList[widget.index].id.toString(), _gymController.postsList[widget.index].textEditingController.text.toString(),_gymController.postsList[widget.index].id);
                    _gymController.commentsList.insert(_gymController.commentsList.length, CommentsModel(id: 1, userId: 1, postId: _gymController.postsList[widget.index].id, comment: _gymController.postsList[widget.index].textEditingController.text.toString(), getUser: GetUser(id: _authController.userData.value!.id, name: _authController.userData.value!.name, image: '')));
                    _gymController.postsList[widget.index].textEditingController.clear();
                    setState(() {

                    });
                  }
                },
                child: Container(
                  width: 96,
                  height: 26,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF70B25D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'Post',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
