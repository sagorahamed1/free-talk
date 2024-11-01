import 'package:get/get.dart';
import '../utils/utils.dart';

class CallController extends GetxController{
  var remoteStream = Utils.remoteRenderer.obs;
  var localStream = Utils.localRenderer.obs;

  RxBool isVideoEnable = true.obs;
  RxBool isAudioEnable = true.obs;
  String remoteUserName = "Remote User";
  RxBool isSpeakerOn = false.obs;

  void toggleVideo() {
    var videoTracks = Utils.localRenderer.srcObject?.getVideoTracks();
    if (videoTracks != null && videoTracks.isNotEmpty) {
      videoTracks[0].enabled = isVideoEnable.value; // Enable or disable video
    }
  }

  void toggleAudio() {
    var audioTracks = Utils.localRenderer.srcObject?.getAudioTracks();
    if (audioTracks != null && audioTracks.isNotEmpty) {
      audioTracks[0].enabled = isAudioEnable.value; // Enable or disable audio
    }
  }



  // Toggle between speaker and headphone
  void toggleSpeaker() {
    isSpeakerOn.value = !isSpeakerOn.value;
    if (isSpeakerOn.value) {
      // Enable speaker
      Utils.localRenderer.srcObject?.getAudioTracks().forEach((track) {
        track.enableSpeakerphone(true);
      });
    } else {
      // Disable speaker (use earpiece or default audio output)
      Utils.localRenderer.srcObject?.getAudioTracks().forEach((track) {
        track.enableSpeakerphone(false);
      });
    }
    update();
  }

}