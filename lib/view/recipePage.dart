import 'package:flutter/material.dart';
import 'package:myrecipe/services/apicall.dart';
import 'package:myrecipe/models/models.dart';
import 'package:myrecipe/widget.dart';

class RecipePage extends StatefulWidget {
  const RecipePage({Key key}) : super(key: key);

  @override
  _RecipePageState createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  List<Recipe> recipes;
  bool isloading = true;

  @override
  void initState() {
    super.initState();
    getrecipes();
  }

  Future<void> getrecipes() async {
    recipes = await RecipeApi.getRecipe();
    setState(() {
      isloading = false;
    });
    print(recipes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.restaurant_menu,
              color: Colors.blueGrey[800],
            ),
            SizedBox(width: 10),
            Text(
              'My Recipes',
              style: TextStyle(
                color: Colors.blueGrey[800],
              ),
            ),
          ],
        ),
      ),
      body: isloading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: recipes.length,
              itemBuilder: (_, index) => RecipeCard(
                  title: recipes[index].name == null ? '' : recipes[index].name,
                  rating: recipes[index].rating.toString() == null
                      ? ''
                      : recipes[index].rating.toString(),
                  cookTime: recipes[index].totalTime == null
                      ? ''
                      : recipes[index].totalTime,
                  thumbnailUrl:
                      recipes[index].images == null ? '' : recipes[index].images
                  // 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR7l2XRuuEsF_Si30cdUkhF-OPUgezxTqc83A&usqp=CAU',
                  ),
            ),
    );
  }
}
