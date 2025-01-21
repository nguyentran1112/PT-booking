import 'package:json_annotation/json_annotation.dart';

enum SocialEnum {
  @JsonValue('facebook')
  facebook,
  @JsonValue('instagram')
  instagram,
  @JsonValue('twitter')
  twitter,
  @JsonValue('youtube')
  youtube,
  @JsonValue('tiktok')
  tiktok,
  @JsonValue('linkedin')
  linkedin,
  @JsonValue('unknown')
  unknown,
}

extension SocialEnumExtension on SocialEnum {
  String get icon {
    switch (this) {
      case SocialEnum.facebook:
        return 'assets/facebook.svg';
      case SocialEnum.instagram:
        return 'assets/instagram.svg';
      case SocialEnum.twitter:
        return 'assets/twitter.svg';
      case SocialEnum.youtube:
        return 'assets/youtube.svg';
      case SocialEnum.tiktok:
        return 'assets/tiktok.svg';
      case SocialEnum.linkedin:
        return 'assets/linkedin.svg';
      default:
        return 'assets/global.svg';
    }
  }
}
