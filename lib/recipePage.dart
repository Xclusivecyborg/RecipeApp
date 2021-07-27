import 'package:flutter/material.dart';
import 'package:myrecipe/apicall.dart';
import 'package:myrecipe/models.dart';

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

class RecipeCard extends StatelessWidget {
  final String title;
  final String rating;
  final String cookTime;
  final String thumbnailUrl;
  RecipeCard({
    @required this.title,
    @required this.cookTime,
    @required this.rating,
    @required this.thumbnailUrl,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 22, vertical: 10),
          width: MediaQuery.of(context).size.width,
          height: 180,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.9),
                offset: Offset(
                  0.0,
                  10.0,
                ),
                blurRadius: 10.0,
                spreadRadius: -6.0,
              ),
            ],
            image: DecorationImage(
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.35),
                BlendMode.multiply,
              ),
              image: NetworkImage(thumbnailUrl),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Align(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 18,
                          ),
                          SizedBox(width: 7),
                          Text(
                            rating,
                            style: TextStyle(color: Colors.yellow),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.schedule,
                            color: Colors.yellow,
                            size: 18,
                          ),
                          SizedBox(width: 7),
                          Text(
                            cookTime,
                            style: TextStyle(color: Colors.yellow),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                alignment: Alignment.bottomLeft,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Container(
            padding: const EdgeInsets.only(top: 8),
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  offset: Offset(
                    0.0,
                    10.0,
                  ),
                  blurRadius: 10.0,
                  spreadRadius: -6.0,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// class Mycard extends StatelessWidget {
//   final String name;
//   const Mycard({Key key, this.name}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           height: 220,
//           width: double.infinity,
//           child: Text('name'),
//           decoration: BoxDecoration(
//             color: Colors.black45,
//             borderRadius: BorderRadius.circular(15),
//           ),
//         ),
//         SizedBox(
//           height: 15,
//         ),
//         Row(children: [
//           Container(
//             padding: EdgeInsets.only(left: 12),
//             child: Row(
//               children: [
//                 Icon(
//                   Icons.star,
//                   color: Colors.yellow[400],
//                 ),
//               ],
//             ),
//             height: 50,
//             width: 100,
//             decoration: BoxDecoration(
//               color: Colors.black,
//               borderRadius: BorderRadius.circular(8),
//               boxShadow: [
//                 BoxShadow(
//                   blurRadius: 5,
//                   spreadRadius: 2,
//                   color: Colors.blueGrey[800],
//                 )
//               ],
//             ),
//           ),
//           SizedBox(width: 15),
//           Container(
//             height: 50,
//             width: 235,
//             decoration: BoxDecoration(
//               color: Colors.blueGrey[800],
//               borderRadius: BorderRadius.circular(8),
//               boxShadow: [
//                 BoxShadow(
//                   blurRadius: 5,
//                   spreadRadius: 2,
//                   color: Colors.lime[800],
//                 ),
//               ],
//             ),
//           )
//         ]),
//       ],
//     );
//   }
// }



