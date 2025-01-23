import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gym_kid/models/questions_model.dart';
import 'package:intl/intl.dart';
import '../api_services/api_exceptions.dart';
import '../api_services/data_api.dart';
import '../components/dialogbox.dart';
import '../components/page_navigation.dart';
import '../helper/custom_dialogbox.dart';
import '../helper/shared_preference.dart';
import '../models/comments_model.dart';
import '../models/notes_model.dart';
import '../models/posts_model.dart';
import '../models/previous_answered_model.dart';
import '../views/auth/forgot_passoword/change_password.dart';
import '../views/navbar/bottom_nav_bar.dart';
import 'base_controller.dart';
import 'general_controller.dart';

class GymController extends GetxController {
  // final AuthPreference _authPreference = AuthPreference.instance;
  BaseController _baseController = BaseController.instance;
  RxList<QuestionsModel> questionsList=<QuestionsModel>[].obs;
  RxList<NotesModel> notesList=<NotesModel>[].obs;
  RxList<NotesModel> filteredNotesList=<NotesModel>[].obs;
  RxList<NotesModel> filteredNotes=<NotesModel>[].obs;
  RxList<NotesModel> todaysNotes=<NotesModel>[].obs;
  RxList<PreviousAnsweredModel> previousAnsweredList=<PreviousAnsweredModel>[].obs;
  RxList<PostsModel> postsList=<PostsModel>[].obs;
  RxList<CommentsModel> commentsList=<CommentsModel>[].obs;
  RxString userEmotion=''.obs;
  RxString noteHeading=''.obs;
  RxString suggestions=''.obs;
  RxString gageMeterSuggestionText=''.obs;
  RxString gageMeterPercentage=''.obs;
  RxDouble needleValue=0.0.obs;
  RxList userReason=[].obs;
  RxString formattedDate=''.obs;
  RxList selectedTopics=[].obs;
  RxBool isLoading=false.obs;
  RxBool isLoadingForComments=false.obs;
  RxInt commentsCurrentPage=0.obs;
  RxInt commentsLastPage=0.obs;
  RxInt postId=0.obs;
  RxInt postsCurrentPage=0.obs;
  RxInt postsLastPage=0.obs;
  GeneralController _genneralController=Get.find();
  // for segregation
  RxMap<String, List<PostsModel>> groupedPosts = <String, List<PostsModel>>{}.obs;


  String getEmoji(String mood){
    if(mood=='Distracted'){
      return 'assets/icons/emoji (1).gif';
    }else if(mood=='Motivated'){
      return 'assets/icons/emoji (2).gif';
    }else if(mood=='Beast Mode'){
      return 'assets/icons/emoji (3).gif';
    }else if(mood=='Focused'){
      return 'assets/icons/emoji (4).gif';
    }else if(mood=='Tired'){
      return 'assets/icons/emoji (5).gif';
    }else{
      return 'assets/icons/emoji (6).gif';
    }
  }

  Future saveAnswers(String questionId,String optionId) async {

    Map<String, String> body = {
      'question_id': questionId,
      'option_id': optionId
    };
    var response = await DataApiService.instance
        .post('/save-answer', body)
        .catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        CustomDialog.showErrorDialog(description: apiError["reason"]);
      } else {}
    });
    update();
    if (response == null) return;
    print(response+ "responded");
    var result = json.decode(response);
    if (result['success']) {
     print("answer saved");
    } else {
      String errorMessages = result['message'];
      CustomDialog.showErrorDialog(description: errorMessages);
    }
  }

  Future addComment(String postId,String comment,int id) async {

    Map<String, String> body = {
      'post_id': postId,
      'comment': comment
    };
    _baseController.showLoading();
    var response = await DataApiService.instance
        .post('/add-comment', body)
        .catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        CustomDialog.showErrorDialog(description: apiError["reason"]);
      } else {}
    });
    _baseController.hideLoading();
    update();
    if (response == null) return;
    print(response+ "responded");
    var result = json.decode(response);
    if (result['success']) {
      getPosts();
      getComments(id);
      print("answer saved");
    } else {
      String errorMessages = result['message'];
      CustomDialog.showErrorDialog(description: errorMessages);
    }
  }

  Future addLike(String postId) async {

    Map<String, String> body = {};
    // _baseController.showLoading();
    var response = await DataApiService.instance
        .post('/like-post?post_id=$postId', body)
        .catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        CustomDialog.showErrorDialog(description: apiError["reason"]);
      } else {}
    });
    // _baseController.hideLoading();
    update();
    if (response == null) return;
    print(response+ "responded");
    var result = json.decode(response);
    if (result['success']) {
      // getPosts();
    } else {
      String errorMessages = result['message'];
      CustomDialog.showErrorDialog(description: errorMessages);
    }
  }

  Future addSeen(String postId) async {

    Map<String, String> body = {};
    // _baseController.showLoading();
    var response = await DataApiService.instance
        .post('/add-seen?post_id=$postId', body)
        .catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        CustomDialog.showErrorDialog(description: apiError["reason"]);
      } else {}
    });
    // _baseController.hideLoading();
    update();
    if (response == null) return;
    print(response+ "responded");
    var result = json.decode(response);
    if (result['success']) {
      // getPosts();
    } else {
      String errorMessages = result['message'];
      CustomDialog.showErrorDialog(description: errorMessages);
    }
  }

  Future addAndGetComment(String postId,String comment,int id) async {

    Map<String, String> body = {
      'post_id': postId,
      'comment': comment
    };
    // _baseController.showLoading();
    var response = await DataApiService.instance
        .post('/add-comment', body)
        .catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        CustomDialog.showErrorDialog(description: apiError["reason"]);
      } else {}
    });
    // _baseController.hideLoading();
    update();
    if (response == null) return;
    print(response+ "responded");
    var result = json.decode(response);
    if (result['success']) {
      // getComments(id);
      print("answer saved");
    } else {
      String errorMessages = result['message'];
      CustomDialog.showErrorDialog(description: errorMessages);
    }
  }

  Future createPost(String message) async {

    Map<String, String> body = {
      'message': message,
      'topics': selectedTopics.join(',')
    };
    _baseController.showLoading();
    var response = await DataApiService.instance
        .post('/create-post', body)
        .catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        CustomDialog.showErrorDialog(description: apiError["reason"]);
      } else {}
    });
    _baseController.hideLoading();
    update();
    if (response == null) return;
    print(response+ "responded");
    var result = json.decode(response);
    if (result['success']) {

      getPosts();
      Get.back();
      print("answer saved");
    } else {
      String errorMessages = result['message'];
      CustomDialog.showErrorDialog(description: errorMessages);
    }
  }

  Future addNote(String note,BuildContext context) async {
    _baseController.showLoading();
    Map<String, String> body = {
      'mood': userEmotion.value,
      'reason': userReason.join(', '),
      'note': note
    };
    var response = await DataApiService.instance
        .post('/add-note', body)
        .catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        CustomDialog.showErrorDialog(description: apiError["reason"]);
      } else {}
    });
    update();
    _baseController.hideLoading();
    if (response == null) return;
    print(response+ "responded");
    var result = json.decode(response);
    if (result['success']) {
      _genneralController.onBottomBarTapped(0);
      PageTransition.pageProperNavigation(page: CustomBottomNavBar());

      print("mood added");
      List<String> emotions = [
        'Confused',
        'Excited',
        'Cool',
        'Peaceful',
        'Bad',
        'Terrible'
      ];
      if(userEmotion.value.toString()=='Distracted'){
        Dialogbox.showSadDialog(context,userEmotion.value.toString(),'1');
      }else if(userEmotion.value.toString()=='Motivated'){
        Dialogbox.showHappyDialog(context,userEmotion.value.toString(),'2');
        // Dialogbox.showSadDialog(context,userEmotion.value.toString(),'2');
      }else if(userEmotion.value.toString()=='Beast Mode'){
        Dialogbox.showHappyDialog(context,userEmotion.value.toString(),'3');
        // Dialogbox.showSadDialog(context,userEmotion.value.toString(),'3');
      }else if(userEmotion.value.toString()=='Focused'){
        Dialogbox.showHappyDialog(context,userEmotion.value.toString(),'4');
        // Dialogbox.showSadDialog(context,userEmotion.value.toString(),'4');
      }else if(userEmotion.value.toString()=='Tired'){
        Dialogbox.showSadDialog(context,userEmotion.value.toString(),'5');
      }else{
        Dialogbox.showSadDialog(context,userEmotion.value.toString(),'6');
      }


      // please uncomment this code
      // userEmail.value=email;
      // print("password reset code send to your email");
      // HapticFeedback.heavyImpact();
      // Get.to(() => VerifyOTP(email: '',fromSignUp: false,isUser: true,),
      //   transition: Transition.rightToLeft,
      // );
    } else {
      String errorMessages = result['message'];
      CustomDialog.showErrorDialog(description: errorMessages);
    }
  }



  Future getPreviousAnswers(String date) async {
    Future.microtask(() async {
      if(previousAnsweredList.isEmpty){
        isLoading.value=true;
      }

      // _baseController.showLoading();
      // Map<String, String> body = {
      //   'email': verifiedEmail.value,
      //   'otp': otpCode.value
      // };
      var response = await DataApiService.instance
          .get('/previous-questions?date=$date')
          .catchError((error) {
        if (error is BadRequestException) {
          var apiError = json.decode(error.message!);
          CustomDialog.showErrorDialog(description: apiError["reason"]);
        } else {
          var apiError = json.decode(error.message!);
          CustomDialog.showErrorDialog(description: apiError["reason"]);
        }
      });
      update();
      isLoading.value=false;
      // _baseController.hideLoading();
      if (response == null) return;
      print(response + "responded");
      // print(result['success'])
      var result = json.decode(response);
      if (result['success']) {
        previousAnsweredList.value = List<PreviousAnsweredModel>.from(
            result['data']['data'].map((x) => PreviousAnsweredModel.fromJson(x)));
        // Get.to(() => ChangePassword());
      } else {
        CustomDialog.showErrorDialog(description: result['message']);
      }}
    );
  }

  Future getPosts() async {
    Future.microtask(() async {
      if(postsList.isEmpty){
        isLoading.value=true;
      }

      // _baseController.showLoading();
      // Map<String, String> body = {
      //   'email': verifiedEmail.value,
      //   'otp': otpCode.value
      // };
      var response = await DataApiService.instance
          .get('/get-posts?page=${postsCurrentPage.value+1}')
          .catchError((error) {
        if (error is BadRequestException) {
          var apiError = json.decode(error.message!);
          CustomDialog.showErrorDialog(description: apiError["reason"]);
        } else {
          var apiError = json.decode(error.message!);
          CustomDialog.showErrorDialog(description: apiError["reason"]);
        }
      });
      // _baseController.hideLoading();
   isLoading.value=false;
      update();
      // _baseController.hideLoading();
      if (response == null) return;
      print(response + "responded");
      // print(result['success'])
      var result = json.decode(response);
      if (result['success']) {
        if(postsList.isEmpty){
          postsList.value = List<PostsModel>.from(
              result['data']['data'].map((x) => PostsModel.fromJson(x)));
        }else{
          postsList.addAll(List<PostsModel>.from(result['data']['data'].map((x) => PostsModel.fromJson(x))));
        }
        postsCurrentPage.value=result['data']['current_page'];
        postsLastPage.value=result['data']['last_page'];
        // for segregation
        groupPostsByDate();
        // Get.back();
        // Get.to(() => ChangePassword());
      } else {
        CustomDialog.showErrorDialog(description: result['message']);
      }});
  }

  Future getPostsAfterAddingComment() async {
    Future.microtask(() async {
      // if(postsList.isEmpty){
      //   isLoading.value=true;
      // }

      // _baseController.showLoading();
      // Map<String, String> body = {
      //   'email': verifiedEmail.value,
      //   'otp': otpCode.value
      // };
      _baseController.showLoading();
      var response = await DataApiService.instance
          .get('/get-posts?page=${postsCurrentPage.value+1}')
          .catchError((error) {
        if (error is BadRequestException) {
          var apiError = json.decode(error.message!);
          CustomDialog.showErrorDialog(description: apiError["reason"]);
        } else {
          var apiError = json.decode(error.message!);
          CustomDialog.showErrorDialog(description: apiError["reason"]);
        }
      });
      _baseController.hideLoading();
      // isLoading.value=false;
      update();
      // _baseController.hideLoading();
      if (response == null) return;
      print(response + "responded");
      // print(result['success'])
      var result = json.decode(response);
      if (result['success']) {

          postsList.value = List<PostsModel>.from(
              result['data']['data'].map((x) => PostsModel.fromJson(x)));
        // Get.back();
        // Get.to(() => ChangePassword());
      } else {
        CustomDialog.showErrorDialog(description: result['message']);
      }});
  }

  Future getComments(int postId) async {
    Future.microtask(() async {
      if(commentsList.isEmpty){
        isLoadingForComments.value=true;
      }

      var response = await DataApiService.instance
          .get('/get-comments?post_id=$postId&page=${commentsCurrentPage.value+1}')
          .catchError((error) {
        if (error is BadRequestException) {
          var apiError = json.decode(error.message!);
          CustomDialog.showErrorDialog(description: apiError["reason"]);
        } else {
          var apiError = json.decode(error.message!);
          CustomDialog.showErrorDialog(description: apiError["reason"]);
        }
      });
      // _baseController.hideLoading();
      isLoadingForComments.value=false;
      update();
      // _baseController.hideLoading();
      if (response == null) return;
      print(response + "responded");
      // print(result['success'])
      var result = json.decode(response);
      if (result['success']) {
        if(commentsList.isEmpty){
          commentsList.value = List<CommentsModel>.from(
              result['data']['data'].map((x) => CommentsModel.fromJson(x)));
        }else{
          commentsList.addAll(List<CommentsModel>.from(result['data']['data'].map((x) => CommentsModel.fromJson(x))));
        }

        commentsCurrentPage.value=result['data']['current_page'];
        commentsLastPage.value=result['data']['last_page'];
      } else {
        CustomDialog.showErrorDialog(description: result['message']);
      }});
  }

  Future filterNotes(String date) async {
    Future.microtask(() async {
      isLoading.value=true;
      // _baseController.showLoading();
      // Map<String, String> body = {
      //   'email': verifiedEmail.value,
      //   'otp': otpCode.value
      // };
      var response = await DataApiService.instance
          .get('/filter-notes?date=$date')
          .catchError((error) {
        if (error is BadRequestException) {
          var apiError = json.decode(error.message!);
          CustomDialog.showErrorDialog(description: apiError["reason"]);
        } else {
          var apiError = json.decode(error.message!);
          CustomDialog.showErrorDialog(description: apiError["reason"]);
        }
      });
      update();
      isLoading.value=false;
      // _baseController.hideLoading();
      if (response == null) return;
      print(response + "responded");
      // print(result['success'])
      var result = json.decode(response);
      if (result['success']) {
        filteredNotes.value = List<NotesModel>.from(
            result['data']['data'].map((x) => NotesModel.fromJson(x)));
        // Get.to(() => ChangePassword());
      } else {
        CustomDialog.showErrorDialog(description: result['message']);
      }});
  }

  Future getNotes() async {
    Future.microtask(() async {
      if(notesList.isEmpty){
        isLoading.value=true;

      }
      // _baseController.showLoading();
      // Map<String, String> body = {
      //   'email': verifiedEmail.value,
      //   'otp': otpCode.value
      // };
      var response = await DataApiService.instance
          .get('/get-notes')
          .catchError((error) {
        if (error is BadRequestException) {
          var apiError = json.decode(error.message!);
          CustomDialog.showErrorDialog(description: apiError["reason"]);
        } else {
          var apiError = json.decode(error.message!);
          CustomDialog.showErrorDialog(description: apiError["reason"]);
        }
      });
      isLoading.value=false;
      update();
      _baseController.hideLoading();
      if (response == null) return;
      print(response + "responded");
      // print(result['success'])
      var result = json.decode(response);
      if (result['success']) {
        final DateTime now = DateTime.now();
        final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
        formattedDate.value = dateFormat.format(now);
        notesList.value = List<NotesModel>.from(
            result['data']['data'].map((x) => NotesModel.fromJson(x)));
        print("start");
        saveSuggestions(notesList[0].mood.toString());
        print("end");

        filteredNotes.value = notesList.where((e) => dateFormat.format(e.date) == formattedDate.value ).toList();
        todaysNotes.value = notesList.where((e) => dateFormat.format(e.date) == formattedDate.value ).toList();
        // if(notesList.isNotEmpty){


        // }
        // Get.to(() => ChangePassword());
      } else {
        CustomDialog.showErrorDialog(description: result['message']);
      }});
  }

  Future getQuestions(String date) async {
    Future.microtask(() async {
      if(questionsList.isEmpty){
        isLoading.value=true;
      }

    // _baseController.showLoading();
    // Map<String, String> body = {
    //   'email': verifiedEmail.value,
    //   'otp': otpCode.value
    // };
    var response = await DataApiService.instance
        .get('/get-questions?date=$date')
        .catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        CustomDialog.showErrorDialog(description: apiError["reason"]);
      } else {
        var apiError = json.decode(error.message!);
        CustomDialog.showErrorDialog(description: apiError["reason"]);
      }
    });
      isLoading.value=false;
      update();
    // _baseController.hideLoading();
    if (response == null) return;
    print(response + "responded");
    // print(result['success'])
    var result = json.decode(response);
    if (result['success']) {
      questionsList.value = List<QuestionsModel>.from(
          result['data']['data'].map((x) => QuestionsModel.fromJson(x)));
      // Get.to(() => ChangePassword());
    } else {
      CustomDialog.showErrorDialog(description: result['message']);
    }});
  }
  void updateEmotion(String emotion){
    userEmotion.value=emotion;
  }
  void saveNoteHeading(String emotion){
    // List<String> emotions = [
    //   'Distracted',
    //   'Motivated',
    //   'Beast Mode',
    //   'Focused',
    //   'Change to tired',
    //   'Injured'
    // ];
    if(emotion=='Distracted'){
      noteHeading.value='There’s always tomorrow';
    }else if(emotion=='Motivated'){
      noteHeading.value='You crushed it!';
    }else if(emotion=='Beast Mode'){
      noteHeading.value='You’re unstoppable';
    }else if(emotion=='Focused'){
      noteHeading.value='Way to give your all';
    }else if(emotion=='Tired'){
      noteHeading.value='Practice makes progress';
    }else{
      noteHeading.value='Take it easy.Recovery is key';
    }
  }
  void saveSuggestions(String emotion){
    print(emotion+'kio');
    // List<String> emotions = [
    //   'Distracted',
    //   'Motivated',
    //   'Beast Mode',
    //   'Focused',
    //   'Change to tired',
    //   'Injured'
    // ];
    if(emotion=='Distracted'){
      suggestions.value = 'Take a break—there’s always tomorrow!';
      needleValue.value=67;
      gageMeterSuggestionText.value='Room to improve!';
      gageMeterPercentage.value='30%';
    }else if(emotion=='Motivated'){
      suggestions.value = 'You’re doing great, keep up the momentum!';
      needleValue.value=20;
      gageMeterSuggestionText.value='Good!';
      gageMeterPercentage.value='100%';
    }else if(emotion=='Beast Mode'){
      suggestions.value = 'Stay in the zone—amazing work!';
      gageMeterSuggestionText.value='Great!';
      gageMeterPercentage.value='100%';
      needleValue.value=20;
    }else if(emotion=='Focused'){
      suggestions.value = 'Keep up the great work, you’re on point!';
      gageMeterSuggestionText.value='Well done!';
      gageMeterPercentage.value='100%';
      needleValue.value=20;
    }else if(emotion=='Tired'){
      suggestions.value = 'Remember, practice makes progress!';
      needleValue.value=55;
      gageMeterSuggestionText.value='Room to improve!';
      gageMeterPercentage.value='45%';
    } else {
      suggestions.value = 'Take it easy. Recovery is key!';
      needleValue.value=78;
      gageMeterSuggestionText.value='Room to improve!';
      gageMeterPercentage.value='10%';
    }
  }
  void updateReason(List reason){
    userReason.value=reason;
  }
  void updateSelectedTopics(List topics){
    selectedTopics.value=topics;
  }
  void updatePostId(int postIdOfComments){
    postId.value=postIdOfComments;
  }

  // Method to group posts by date
  void groupPostsByDate() {
    Map<String, List<PostsModel>> tempGroupedPosts = {};

    for (var post in postsList) {
      // Parse the createDate string into a DateTime object
      DateTime date = DateFormat('dd,MMM,yyyy').parse(post.creationDate);
      // Format the date as a string for display
      String formattedDate = DateFormat('dd MMM yyyy').format(date);

      // Group posts by formatted date
      if (tempGroupedPosts.containsKey(formattedDate)) {
        tempGroupedPosts[formattedDate]!.add(post);
      } else {
        tempGroupedPosts[formattedDate] = [post];
      }
    }

    // Update the reactive variable with the grouped posts
    groupedPosts.value = tempGroupedPosts;
  }


}