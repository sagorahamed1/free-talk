import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/call_controller.dart';
import '../../../utils/utils.dart';

class VoiceCallScreen extends StatefulWidget {
  const VoiceCallScreen({Key? key}) : super(key: key);

  @override
  State<VoiceCallScreen> createState() => _VoiceCallScreenState();
}

class _VoiceCallScreenState extends State<VoiceCallScreen> {
  final CallController controller = Get.put(CallController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            // Placeholder background to indicate voice call
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.8),
                child: const Center(
                  child: Text(
                    "Voice Call",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            // Display Room ID
            GetBuilder<CallController>(
              builder: (controller) {
                return Positioned(
                  top: 40,
                  left: (MediaQuery.of(context).size.width - 120) / 2,
                  child: Text(
                    "Room ID: ${Utils.roomId.toString()}",
                    style: TextStyle(color: Colors.red, fontSize: 16),
                  ),
                );
              },
            ),

            // Remote Audio Stream Placeholder
            Positioned(
              top: 100,
              left: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    "Connected to: ${controller.remoteUserName}",
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ),

            // Call Controls
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // End Call Button
                  FloatingActionButton(
                    backgroundColor: Colors.red,
                    onPressed: () {
                      Utils.signaling.hangUp(Utils.localRenderer);
                      Get.back();
                    },
                    child: const Icon(Icons.call_end, color: Colors.white),
                  ),
                  // Mute/Unmute Button
                  FloatingActionButton(
                    backgroundColor: Colors.blue,
                    onPressed: () {
                      controller.isAudioEnable.value =
                      !controller.isAudioEnable.value;
                      controller.toggleAudio();
                    },
                    child: Icon(
                      controller.isAudioEnable.value ? Icons.mic : Icons.mic_off,
                      color: Colors.white,
                    ),
                  ),
                  // Speaker/Headphone Toggle Button
                  FloatingActionButton(
                    backgroundColor: Colors.blue,
                    onPressed: () {
                      controller.toggleSpeaker();
                    },
                    child: Icon(
                      controller.isSpeakerOn.value
                          ? Icons.volume_up
                          : Icons.volume_off,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}