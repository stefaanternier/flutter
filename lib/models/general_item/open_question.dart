class OpenQuestion {
  bool withAudio;
  bool withPicture;
  bool withVideo;
  bool withText;
  bool withValue;
  String textDescription;
  String valueDescription;

  OpenQuestion(
      {this.withAudio,
      this.withVideo,
      this.withPicture,
      this.withText,
      this.withValue,
      this.textDescription,
      this.valueDescription});

  factory OpenQuestion.fromJson(Map json) {
    return OpenQuestion(
      withAudio: json['withAudio'],
      withVideo: json['withVideo'],
      withPicture: json['withPicture'],
      withText: json['withText'],
      withValue: json['withValue'],
      textDescription: json['textDescription'],
      valueDescription: json['valueDescription'],
    );
  }
}
