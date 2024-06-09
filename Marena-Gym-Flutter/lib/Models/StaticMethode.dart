
class StaticMethode
{

  static DateTime parseDateString(String dateString) {
    try {
      return DateTime.parse(dateString);
    } catch (e) {
      print('Error parsing date: $e');
      return DateTime.now();
    }
  }




}