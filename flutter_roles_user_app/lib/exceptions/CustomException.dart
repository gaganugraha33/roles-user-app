import '../Dictionary.dart';
import '../ErrorException.dart';

class CustomException {
  static String onConnectionException(String error) {
    String e;
    if (error
        .toLowerCase()
        .contains(ErrorException.socketException.toLowerCase())) {
      e = Dictionary.errorConnection;
    } else if (error
        .toLowerCase()
        .contains(ErrorException.timeoutException.toLowerCase())) {
      e = Dictionary.errorTimeOut;
    } else if (error
        .toLowerCase()
        .contains(ErrorException.notFound.toLowerCase())) {
      e = Dictionary.errorNotFound;
    } else if (error
        .toLowerCase()
        .contains(ErrorException.ioException.toLowerCase())) {
      e = Dictionary.errorIOConnection;
    } else if (error
        .toLowerCase()
        .contains(ErrorException.unauthorizedException.toLowerCase())) {
      e = Dictionary.errorUnauthorized;
    } else if (error
        .toLowerCase()
        .contains(ErrorException.loginException.toLowerCase())) {
      e = Dictionary.errorLogin;
    } else {
      e = Dictionary.somethingWrong;
    }
    return e;
  }
}
