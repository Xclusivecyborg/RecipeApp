import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:myrecipe/models/models.dart';

class RecipeApi {
  static Future<List<Recipe>> getRecipe() async {
    try {
      var url = Uri.https(
        'yummly2.p.rapidapi.com',
        '/feeds/list',
        {'start': '0', 'limit': '18', 'tag': 'list.recipe.popular'},
      );

      final response = await http.get(
        url,
        headers: {
          'x-rapidapi-key':
              '3016fe2c40msh1f4d0df842f54e1p174119jsn8bb1469ef1c4',
          'x-rapidapi-host': 'yummly2.p.rapidapi.com',
          'useQueryString': 'true'
        },
      );
      Map data = jsonDecode(response.body);
      List _temp = [];
      for (var item in data['feed']) {
        _temp.add(item['content']['details']);
      }
      return Recipe.recipesFromSnapshot(_temp);
    } on SocketException {
      throw "You're not connectected to the internet";
    }
  }
}
