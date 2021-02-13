class Settings {
  String colorMode;
  String language;

  Settings(this.colorMode, this.language);

  factory Settings.fromJson(dynamic json) {
    //print("Tip : " + json['tabloKolonlari'].toString());
    return Settings(json['colorMode'], json['language']);
  }

  Map<String, dynamic> toJson() => {
        'colorMode': colorMode,
        'language': language,
      };
}
