
import 'package:http/http.dart' as http;

final json = {
  'title' : '',
  'description' : ''
};


Future postRquest ()async{
  final url = '';

  final response = await http.post(Uri.parse(url),
  body: json
  );
}