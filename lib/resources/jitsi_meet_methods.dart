import 'package:flutter/material.dart';
import 'package:jitsi_meet_wrapper/jitsi_meet_wrapper.dart';
import 'package:letzmeet/resources/auth_methods.dart';
import 'package:letzmeet/resources/firestore_methods.dart';

class JitsiMeetMethods {
  final AuthMethods _authMethods = AuthMethods();
  final FirestoreMethods _firestoreMethods = FirestoreMethods();
  void createMeeting({
    required String roomName,
    required bool isAudioMuted,
    required bool isVideoMuted,
    String username = '',
  }) async {
    try {
      // FeatureFlag featureFlag = FeatureFlag();
      // featureFlag.welcomePageEnabled = false;
      // featureFlag.resolution = FeatureFlagVideoResolution.MD_RESOLUTION;
      String name;
      if (username.isEmpty) {
        name = _authMethods.user.displayName!;
      } else {
        name = username;
      }
      var options = JitsiMeetingOptions(
        roomNameOrUrl: roomName,
        userDisplayName: _authMethods.user.displayName,
        userEmail: _authMethods.user.email,
        userAvatarUrl: _authMethods.user.photoURL,
        isAudioMuted: isAudioMuted,
        isVideoMuted: isVideoMuted,
      );

      // Limit video resolution to 360p

      // var options = JitsiMeetingOptions(roomNameOrUrl: roomName)()
      //   ..subject = "Meeting with Gunschu"
      //   ..userDisplayName = "My Name"
      //   ..userEmail = "myemail@email.com"
      //   ..userAvatarURL = "https://someimageurl.com/image.jpg" // or .png
      //   ..audioOnly = true
      //   ..audioMuted = true
      //   ..videoMuted = true
      //   ..featureFlag = featureFlag;
      _firestoreMethods.addToMeetingHistory(roomName);
      await JitsiMeetWrapper.joinMeeting(options: options);

      // await JitsiMeet.joinMeeting(options);
    } catch (error) {
      print("error: $error");
    }
  }
}
