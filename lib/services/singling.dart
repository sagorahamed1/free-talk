
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:get/get.dart';

import 'package:flutter_webrtc/flutter_webrtc.dart' as webrtc;

import '../utils/utils.dart';

typedef void StreamStateCallback(MediaStream stream);

class Signaling {
  RTCPeerConnection? peerConnection;
  MediaStream? localStream;
  MediaStream? remoteStream;
  String? roomId;
  String? currentRoomText;
  StreamStateCallback? onAddRemoteStream;

  Map<String, dynamic> configuration = {
    'iceServers': [
      {
        'urls': [
          'stun:stun1.l.google.com:19302',
          'stun:stun2.l.google.com:19302',
        ]
      },
      {
        'urls': 'turn:relay1.expressturn.com:3478',
        'username': 'efQ5Z1Z2HISFM0DBH4', // Replace with your TURN server username
        'credential': 'IaKY93w8vuGWrgda', // Replace with your TURN server password
      }
    ]
  };

  Future<String> createRoom(RTCVideoRenderer remoteRenderer, String randomId) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    DocumentReference roomRef = firebaseFirestore.collection("rooms").doc(randomId);

    peerConnection = await createPeerConnection(configuration);
    registerPeerConnectionListeners();

    // Initialize the remote stream
    remoteStream = await createLocalMediaStream("remoteStream");

    localStream?.getTracks().forEach((track) {
      peerConnection?.addTrack(track, localStream!);
    });

    var callerCandidatesCollection = roomRef.collection("callerCandidates");
    peerConnection?.onIceCandidate = (RTCIceCandidate candidate) {
      debugPrint("******************* Got Candidate: ${candidate.toMap()}");
      callerCandidatesCollection.add(candidate.toMap());
    };

    RTCSessionDescription offer = await peerConnection!.createOffer();
    await peerConnection!.setLocalDescription(offer);

    Map<String, dynamic> roomWithOffer = {"offer": offer.toMap()};
    await roomRef.set(roomWithOffer);

    var roomId = roomRef.id;

    debugPrint("************************* New room created with SDK offer. Room ID: $roomId");

    peerConnection?.onTrack = (RTCTrackEvent event) {
      debugPrint("*********************** Got Remote Track: ${event.streams[0]}");
      event.streams[0].getTracks().forEach((track) {
        debugPrint("========================= Adding a Track to the Remote Stream: $track");
        remoteStream?.addTrack(track);
      });
    };

    roomRef.snapshots().listen((snapshot) async {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      if (peerConnection?.getRemoteDescription() != null && data["answer"] != null) {
        var answer = RTCSessionDescription(data["answer"]["sdp"], data["answer"]["type"]);

        debugPrint("*********************** Someone is trying to connect.");
        await peerConnection?.setRemoteDescription(answer);
      }
    });

    roomRef.collection("calleeCandidates").snapshots().listen((snapshot) {
      snapshot.docChanges.forEach((change) {
        if (change.type == DocumentChangeType.added) {
          Map<String, dynamic> data = change.doc.data() as Map<String, dynamic>;
          peerConnection!.addCandidate(
            RTCIceCandidate(data["candidate"], data["sdpMid"], data["sdpMLineIndex"]),
          );
        }
      });
    });

    return roomId;
  }

  Future<void> joinRoom(String roomId, RTCVideoRenderer remoteVideo) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentReference roomRef = firestore.collection("rooms").doc(roomId);
    var roomSnapshot = await roomRef.get();
    debugPrint("******************************* Room exists: ${roomSnapshot.exists}");

    if (roomSnapshot.exists) {
      peerConnection = await createPeerConnection(configuration);
      registerPeerConnectionListeners();
      localStream?.getTracks().forEach((track) {
        peerConnection?.addTrack(track, localStream!);
      });

      var calleeCandidatesCollection = roomRef.collection("calleeCandidates");
      peerConnection!.onIceCandidate = (RTCIceCandidate? candidate) {
        if (candidate != null) {
          debugPrint('**************************** onIceCandidate: Got candidate!');
          calleeCandidatesCollection.add(candidate.toMap());
        }
      };

      peerConnection?.onTrack = (RTCTrackEvent event) {
        event.streams[0].getTracks().forEach((track) {
          remoteStream?.addTrack(track);
        });
      };

      var data = roomSnapshot.data() as Map<String, dynamic>;
      var offer = data["offer"];
      await peerConnection?.setRemoteDescription(RTCSessionDescription(offer["sdp"], offer["type"]));
      var answer = await peerConnection!.createAnswer();

      await peerConnection!.setLocalDescription(answer);
      Map<String, dynamic> roomWithAnswer = {"answer": {"type": answer.type, "sdp": answer.sdp}};
      await roomRef.update(roomWithAnswer);

      roomRef.collection("callerCandidates").snapshots().listen((snapshot) {
        snapshot.docChanges.forEach((document) {
          var data = document.doc.data() as Map<String, dynamic>;
          peerConnection!.addCandidate(
            RTCIceCandidate(data["candidate"], data["sdpMid"], data["sdpMLineIndex"]),
          );
        });
      });
    }
  }

  Future<void> openUserMedia(RTCVideoRenderer localVideo, RTCVideoRenderer remoteVideo) async {
    var stream = await webrtc.navigator.mediaDevices.getUserMedia({'video': true, 'audio': true});
    localVideo.srcObject = stream;
    localStream = stream;

    // Initialize remote video stream
    remoteVideo.srcObject = await createLocalMediaStream("remoteStream");
  }

  Future<void> hangUp(RTCVideoRenderer localVideo) async {
    List<MediaStreamTrack> tracks = localVideo.srcObject!.getTracks();
    for (var track in tracks) {
      track.stop();
    }

    remoteStream?.getTracks().forEach((track) => track.stop());

    if (peerConnection != null) {
      await peerConnection!.close();
      peerConnection = null;
    }

    if (roomId != null) {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      var roomRef = firestore.collection("rooms").doc(roomId);
      var calleeCandidates = await roomRef.collection("calleeCandidates").get();
      for (var document in calleeCandidates.docs) {
        document.reference.delete();
      }

      var callerCandidates = await roomRef.collection("callerCandidates").get();
      for (var document in callerCandidates.docs) {
        document.reference.delete();
      }

      await roomRef.delete();
    }

    // Dispose of local and remote streams
    localStream?.dispose();
    remoteStream?.dispose();
  }

  void registerPeerConnectionListeners() {
    peerConnection?.onIceGatheringState = (RTCIceGatheringState state) {
      debugPrint("************************************ ICE gathering state changed: $state");
    };

    peerConnection?.onConnectionState = (RTCPeerConnectionState state) {
      debugPrint("************************************ Connection state change: $state");
      if (state == RTCPeerConnectionState.RTCPeerConnectionStateDisconnected ||
          state == RTCPeerConnectionState.RTCPeerConnectionStateClosed) {
        hangUp(Utils.localRenderer);
        debugPrint("============================ Call Ended Successfully!");
        Get.back();
      }
    };

    Utils.signaling.peerConnection?.onIceConnectionState = (state) {
      print("======================================= Connection State: $state");
      if (state == RTCIceConnectionState.RTCIceConnectionStateDisconnected ||
          state == RTCIceConnectionState.RTCIceConnectionStateClosed ||
          state == RTCIceConnectionState.RTCIceConnectionStateFailed) {
        Utils.signaling.hangUp(Utils.localRenderer);
        debugPrint("************************************* Call Ended Successfully!");
        Get.back();
      }
    };

    peerConnection?.onAddStream = (MediaStream stream) {
      debugPrint("**************************** Added Remote Stream");
      onAddRemoteStream?.call(stream);
      remoteStream = stream;
    };
  }
}