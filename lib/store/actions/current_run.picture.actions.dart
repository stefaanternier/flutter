import 'package:youplay/models/response.dart';

class PictureResponseAction {
  PictureResponse pictureResponse;

  PictureResponseAction({required this.pictureResponse});
}

class VideoResponseAction {
  VideoResponse videoResponse;

  VideoResponseAction({required this.videoResponse});
}

class AudioResponseAction {
  AudioResponse audioResponse;

  AudioResponseAction({required this.audioResponse});
}

class TextResponseAction {
  Response textResponse;

  TextResponseAction({required this.textResponse});
}

class MultiplechoiceAction {
  Response mcResponse;

  MultiplechoiceAction({required this.mcResponse});

}
