class Validation{
  static bool phoneNumber(String text){
    const Pattern pattern = r'(^[+][0-9]{8,12}$)';
    final RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(text)) {
      return false;
    } else {
      return true;
    }
  }
}