import 'dart:js' as js;

class JsUtils {
  static void openUrl(String url) {
    js.context.callMethod('open', [url]);
  }
}
