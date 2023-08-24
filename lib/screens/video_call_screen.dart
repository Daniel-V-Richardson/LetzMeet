import 'package:flutter/material.dart';
import 'package:jitsi_meet_wrapper/jitsi_meet_wrapper.dart';
import 'package:letzmeet/resources/auth_methods.dart';
import 'package:letzmeet/resources/jitsi_meet_methods.dart';
import 'package:letzmeet/utils/colors.dart';
import 'package:letzmeet/widgets/meeting_option.dart';

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({super.key});

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  final JitsiMeetMethods _jitsiMeetMethods = JitsiMeetMethods();
  final AuthMethods _authMethods = AuthMethods();
  late TextEditingController meetingIdController;
  late TextEditingController nameController;
  bool isAudioMuted = true;
  bool isVideoMuted = true;

  @override
  void initState() {
    meetingIdController = TextEditingController();
    nameController = TextEditingController(
      text: _authMethods.user.displayName,
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    meetingIdController.dispose();
    nameController.dispose();
  }

  _joinMeeting() {
    _jitsiMeetMethods.createMeeting(
      roomName: meetingIdController.text,
      isAudioMuted: isAudioMuted,
      isVideoMuted: isVideoMuted,
      username: nameController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: backgroundColor,
          title: const Text('Join a Meeting',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          centerTitle: true,
        ),
        body: Column(
          children: [
            SizedBox(
              height: 60,
              child: TextField(
                controller: meetingIdController,
                maxLines: 1,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    fillColor: secondaryBackgroundColor,
                    filled: true,
                    border: InputBorder.none,
                    hintText: 'Room ID',
                    contentPadding: EdgeInsets.fromLTRB(16, 8, 0, 0)),
              ),
            ),
            SizedBox(
              height: 60,
              child: TextField(
                controller: nameController,
                maxLines: 1,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    fillColor: secondaryBackgroundColor,
                    filled: true,
                    border: InputBorder.none,
                    hintText: 'Name',
                    contentPadding: EdgeInsets.fromLTRB(16, 8, 0, 0)),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
                onTap: _joinMeeting,
                child: const Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'Join',
                    style: TextStyle(fontSize: 16),
                  ),
                )),
            const SizedBox(height: 20),
            MeetingOption(
              text: 'Turn off my Audio ',
              isMute: isAudioMuted,
              onChange: onAudioMuted,
            ),
            MeetingOption(
              text: 'Turn off my Video',
              isMute: isVideoMuted,
              onChange: onVideoMuted,
            ),
          ],
        ));
  }

  onAudioMuted(bool? val) {
    setState(() {
      isAudioMuted = val!;
    });
  }

  onVideoMuted(bool? val) {
    setState(() {
      isVideoMuted = val!;
    });
  }
}