import 'package:package_info/package_info.dart';

enum Env {
  prod,
  dev,
}

class FlavorService {
  FlavorService._();

  static Env? env;

  static init(PackageInfo info) {
    final flavor = info.packageName.split(".").last;
    if (flavor == 'dev') {
      env = Env.dev;
    } else {
      env = Env.prod;
    }
  }

  static String get getBaseApi {
    // return prod url
    if (env == Env.prod) {
      return "http://142.93.215.75/diet-app/api";
    }
    // return url other than prod one
    return "http://142.93.215.75/diet-app/api";
  }
}
