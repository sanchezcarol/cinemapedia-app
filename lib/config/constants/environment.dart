
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {

  static String tmdbKey = dotenv.env['THE_MOVIEDB_KEY'] ?? 'Not found key';

}