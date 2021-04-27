class ErrorUtils {

  static Map<String, String> getErrorMessage(dynamic e) {
    print(e);
    return {"message" : "$e"};
  }
}