import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

import '../../utils/Config.dart';

class CallInvitation extends StatelessWidget {
  final Widget child;
  final String userName;
  const CallInvitation({super.key, required this.child, required this.userName});

  @override
  Widget build(BuildContext context) {
    ZegoUIKitPrebuiltCallInvitationService().init(
      appID: Config.appId,
      appSign: Config.appSign,
      userID: userName,
      userName: userName,
      plugins: [ZegoUIKitSignalingPlugin()],
    );
    return child;
  }
}