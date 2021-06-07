import 'package:youplay/models/response.dart';

class PictureResponseAction {
  PictureResponse pictureResponse;

  PictureResponseAction({this.pictureResponse});
}

class VideoResponseAction {
  VideoResponse videoResponse;

  VideoResponseAction({this.videoResponse});
}

class AudioResponseAction {
  AudioResponse audioResponse;

  AudioResponseAction({this.audioResponse});
}

class TextResponseAction {
  Response textResponse;

  TextResponseAction({this.textResponse});
}

class MultiplechoiceAction {
  Response mcResponse;

  MultiplechoiceAction({this.mcResponse});

}
