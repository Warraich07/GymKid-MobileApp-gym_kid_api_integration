import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_kid/components/community_bottom_sheet.dart';
import 'package:gym_kid/controllers/auth_controller.dart';
import 'package:gym_kid/controllers/gym_controller.dart';
import 'package:gym_kid/helper/custom_dialogbox.dart';
import 'package:gym_kid/models/posts_model.dart';
import 'package:gym_kid/res/colors.dart';
import 'package:gym_kid/res/styles.dart';
import 'package:intl/intl.dart';
import 'package:motion/motion.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

import '../../constants/custom_validators.dart';
import '../auth/components/backround_video.dart';
import '../homescreen/components/shimmer_community.dart';
import 'create_feed.dart';
import 'package:cached_network_image/cached_network_image.dart';
class Community extends StatefulWidget {
  const Community({Key? key}) : super(key: key);

  @override
  State<Community> createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  GymController _gymController=Get.find();
AuthController _authController=Get.find();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
// if(_gymController.postsList.isEmpty){
  _gymController.postsList.clear();
  _gymController.postsCurrentPage.value=0;
  _gymController.postsLastPage.value=0;
  _gymController.getPosts();

  }
  @override
  Widget build(BuildContext context) {

    RefreshController _postRefreshController = RefreshController(initialRefresh: false);
    return Scaffold(
      backgroundColor: Get.isDarkMode
          ? AppColors.backgroundColor
          : AppColors.lightBackgroundColor,
      // appBar: PreferredSize(
      //   preferredSize: const Size.fromHeight(80.0),
      //   child: AppBar(
      //       elevation: 1,
      //       shadowColor: Get.isDarkMode ? Colors.white : Colors.black,
      //       bottom: PreferredSize(
      //         preferredSize: const Size.fromHeight(
      //             40.0), // Set your desired height for the bottom area
      //         child: Align(
      //           alignment: Alignment.bottomLeft,
      //           child: DelayedDisplay(
      //             slidingBeginOffset: const Offset(0, 0),
      //             delay: const Duration(milliseconds: 500),
      //             child: Container(
      //               margin: const EdgeInsets.only(
      //                   left: 16.0,
      //                   bottom: 8.0), // Add space around the bottom title
      //               child: Text('Community', style: AppStyles.style25),
      //             ),
      //           ),
      //         ),
      //       ),
      //       backgroundColor:
      //           Get.isDarkMode ? AppColors.backgroundColor : Colors.white),
      // ),
      body: BackgroundImage(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: DelayedDisplay(
              slidingBeginOffset: const Offset(0, 0),
              delay: const Duration(milliseconds: 500),
              child: Obx(
                ()=>  Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),

                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Community', style: TextStyle(
                          color: Get.isDarkMode ? Colors.white : Colors.white,
                          fontSize: 25,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ))),
                    SizedBox(height: 20,),
                    Divider(height:5,color: AppColors.fontColor,),


                    // extract
                    _gymController.isLoading.value==true? const ShimmerCommunityScreen():
                    SizedBox(
                      height: 70.h,
                      child: SmartRefresher(
                        enablePullDown: false,
                        enablePullUp: true,
                        controller: _postRefreshController,
                        onLoading: () async {
                          if (_gymController.postsCurrentPage.value<_gymController.postsLastPage.value) {
                            await _gymController.getPosts();

                            setState(() {});
                          }
                          _postRefreshController.loadComplete();
                        },

                        child: ListView.builder(
                          shrinkWrap: true,
                            itemCount:  _gymController.groupedPosts.keys.length,
                            itemBuilder: (context,index){
                              String dateKey = _gymController.groupedPosts.keys.elementAt(index);
                              List<PostsModel> postsForDate = _gymController.groupedPosts[dateKey]!;
                                    if(!_gymController.postsList[index].isSeen){
                                      _gymController.addSeen(_gymController.postsList[index].id.toString());

                                    }
                          return  Container(

                            child: Padding(
                              padding: const EdgeInsets.only(
                                 top: 15, bottom: 15),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      dateKey,  // Display the date as a header
                                      style: const TextStyle(
                                        fontSize: 14,
                                        // fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  ...postsForDate.map((post) {
                            return Container(
                              margin: EdgeInsets.only(top: 15),
                              padding: const EdgeInsets.only(bottom: 15,left: 15,right: 15,top: 15),
                              // margin: const EdgeInsets.only(bottom: 10),
                              width: Get.width,
                              decoration: ShapeDecoration(
                                color: Get.isDarkMode
                                    ? const Color(0xFF2D2D2D)
                                    : const Color(0xFF2D2D2D),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Image.asset(
                                              'assets/icons/profile.png',
                                              height: 32,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  post.getUser.name.toString(),
                                                  style: TextStyle(
                                                    color: Get.isDarkMode
                                                        ? Colors.white
                                                        : Colors.white,
                                                    fontSize: 12,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                const Text(
                                                  'In Ask a question',
                                                  style: TextStyle(
                                                    color: Color(0xFF70B25D),
                                                    fontSize: 10,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                )
                                              ],
                                            ),
                                            const Spacer(),
                                            Text(
                                              post.time.toString(),
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                color: Get.isDarkMode ? Colors.white : Colors.white,
                                                fontSize: 10,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            )
                                          ],
                                        ),
                                        const Divider(),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            post.message.toString(),
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              color: Get.isDarkMode ? Colors.white : Colors.white,
                                              fontSize: 15,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '${post.totalReplies} replies',
                                              style: const TextStyle(
                                                color: Color(0xFF888888),
                                                fontSize: 10,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Text(
                                              "${post.creationDate}  ${post.creationTime}",
                                              // '12,Aug,2023  6:30pm',
                                              style: const TextStyle(
                                                color: Color(0xFF888888),
                                                fontSize: 10,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w500,
                                              ),
                                            )
                                          ],
                                        ),
                                        const Divider(),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.visibility_outlined,
                                                size: 20,
                                                color: AppColors.yellowColor,
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                post.totalViews.toString(),
                                                style: const TextStyle(
                                                  color: Color(0xFF888888),
                                                  fontSize: 10,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              const Spacer(),
                                              GestureDetector(
                                                onTap: (){
                                                  if(post.isLiked==false){
                                                    _gymController.addLike(post.id.toString());
                                                    post.totalLikes=post.totalLikes+1;
                                                    post.isLiked=true;
                                                    setState(() {
                                                    });
                                                  }else if(post.isLiked==true){
                                                    _gymController.addLike(post.id.toString());
                                                    post.totalLikes=post.totalLikes-1;
                                                    post.isLiked=false;
                                                    setState(() {
                                                    });
                                                  }

                                                },
                                                child: Row(
                                                  children: [
                                                    post.isLiked==true?Icon(
                                                      Icons.favorite,
                                                      size: 20,
                                                      color: AppColors.yellowColor,
                                                    ):Icon(
                                                      Icons.favorite_border_rounded,
                                                      size: 20,
                                                      color: AppColors.yellowColor,
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      post.totalLikes.toString(),
                                                      style: const TextStyle(
                                                        color: Color(0xFF888888),
                                                        fontSize: 10,
                                                        fontFamily: 'Poppins',
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),

                                                  ],
                                                ),
                                              ),

                                              const Spacer(),
                                              Image.asset(
                                                'assets/icons/share.png',
                                                height: 20,
                                                color: AppColors.yellowColor,
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                post.totalShare.toString(),
                                                style: const TextStyle(
                                                  color: Color(0xFF888888),
                                                  fontSize: 10,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        post.getComment.isNotEmpty?
                                        SizedBox(
                                          width: Get.width,
                                          height: 60,
                                          child: PageView.builder(
                                              scrollDirection: Axis.horizontal,
                                              // shrinkWrap: true,
                                              itemCount: post.getComment.length,
                                              itemBuilder: (context,index1){
                                                return Padding(
                                                  padding: const EdgeInsets.only(bottom: 3,right: 5),
                                                  child: Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      // ClipRRect(
                                                      //   borderRadius: BorderRadius.circular(100),
                                                      //   child: SizedBox(
                                                      //     height: 32,
                                                      //     width: 32,
                                                      //     child: CachedNetworkImage(
                                                      //       imageUrl:_authController.userData.value!.image.toString(),
                                                      //       placeholder: (context, url) =>
                                                      //           Center(
                                                      //               child: CircularProgressIndicator()),
                                                      //       errorWidget: (context, url,
                                                      //           error) =>
                                                      //           Image.asset(
                                                      //             "assets/icons/profile2.png",scale: 5.3,
                                                      //             // color:   widget.forMyProfile==false?AppColors.whiteColor:AppColors.primaryColor,
                                                      //
                                                      //           ),
                                                      //       fit: BoxFit.cover,
                                                      //     ),
                                                      //   ),
                                                      // ),
                                                      CircleAvatar(
                                                        child: ClipRRect(
                                                          borderRadius: BorderRadius.circular(20),
                                                          child: CachedNetworkImage(imageUrl: post.getComment[index1].getUser.image??'',
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
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        child: GestureDetector(
                                                          onTap:()async{
                                                            _gymController.commentsCurrentPage.value=0;
                                                            _gymController.commentsLastPage.value=0;
                                                            _gymController.commentsList.clear();
                                                            _gymController.getComments(post.id);
                                                            _gymController.updatePostId(post.id);
                                                            await showModalBottomSheet(
                                                              context: context,
                                                              enableDrag: true,
                                                              showDragHandle: true,
                                                              isScrollControlled: true,
                                                              builder: (context) {
                                                                return DraggableScrollableSheet(
                                                                  initialChildSize: 0.5,
                                                                  maxChildSize: 0.9,
                                                                  minChildSize: 0.3,
                                                                  expand: false,
                                                                  builder: (_, scrollController) {
                                                                    // return Container();
                                                                    return CommentsBottomSheet(scrollController: scrollController, index: index,postId: post.id,);
                                                                  },
                                                                );
                                                              },
                                                            );
                                                          },
                                                          child: Container(
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
                                                                  vertical: 5, horizontal: 10),
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  // com list
                                                                  Text.rich(
                                                                    TextSpan(
                                                                      children: [
                                                                        TextSpan(
                                                                          text: post.getComment[index1].getUser.name.toString(),
                                                                          style: TextStyle(
                                                                            color: Get.isDarkMode
                                                                                ? Colors.white
                                                                                : Colors.white,
                                                                            fontSize: 8,
                                                                            fontFamily: 'Poppins',
                                                                            fontWeight: FontWeight.w600,
                                                                          ),
                                                                        ),
                                                                        // TextSpan(
                                                                        //   text: 'Young Athlete ',
                                                                        //   style: TextStyle(
                                                                        //     color: Get.isDarkMode
                                                                        //         ? Colors.white
                                                                        //         : Colors.white,
                                                                        //     fontSize: 8,
                                                                        //     fontFamily: 'Poppins',
                                                                        //     fontWeight: FontWeight.w500,
                                                                        //   ),
                                                                        // ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                  Text(
                                                                    post.getComment[index1].comment.toString(),
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
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                );
                                              }),
                                        ):Container(),

                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(20),
                                                child: CachedNetworkImage(imageUrl: _authController.userData.value!.image.toString()??'',
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
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: SizedBox(
                                                height: 40,
                                                child: TextFormField(
                                                  validator: (value) => CustomValidator.isEmpty(value),
                                                  controller: post.textEditingController,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                  decoration: InputDecoration(
                                                    fillColor: Get.isDarkMode
                                                        ? const Color(0xB24B4949)
                                                        : const Color(0xB24B4949),
                                                    filled: true,
                                                    contentPadding: const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                    ),
                                                    hintStyle: TextStyle(
                                                      color: Get.isDarkMode
                                                          ? Colors.white
                                                          : Colors.white,
                                                      fontSize: 8,
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
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: GestureDetector(
                                            onTap: (){
                                              if(post.textEditingController.text.isEmpty){
                                                CustomDialog.showErrorDialog(description: "Please write comment");
                                              }else{
                                                _gymController.addComment(post.id.toString(), post.textEditingController.text.toString(),post.id);
                                                post.getComment.insert(0, GetComment(id: 0, userId: post.userId, postId: post.id, comment: post.textEditingController.text.toString(), createdAt: DateTime.now(), updatedAt: DateTime.now(), getUser: GetUser(id: _authController.userData.value!.id, name: _authController.userData.value!.name, image: _authController.userData.value!.image)));
                                                post.textEditingController.clear();
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
                            );}).toList()

                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                    )

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: Motion.elevated(
        filterQuality: FilterQuality.medium,
        elevation: 10,
        glare: true,
        borderRadius: BorderRadius.circular(40),
        // controller: MotionController(),
        child: GestureDetector(
          onTap: () {
            Get.to(() =>  CreateFeed())?.then((value){
              setState(() {
                _gymController.postsList.clear();
                _gymController.postsCurrentPage.value=0;
                _gymController.postsLastPage.value=0;
                _gymController.getPosts();
              });
            });
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

