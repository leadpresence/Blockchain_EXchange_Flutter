import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'favorites_view_model.dart';

class FavoritesView extends StatefulWidget {
  FavoritesView({Key key}) : super(key: key);

  @override
  _FavoritesViewState createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FavoritesViewModel>.reactive(
        viewModelBuilder: () => FavoritesViewModel(),
        onModelReady: (FavoritesViewModel model) async {
          model.initialize();
        },
        builder: (BuildContext context, FavoritesViewModel model, child) =>
            Scaffold(
              appBar: AppBar(
                title: Text('Select Currencies'),
              ),
              body: ListView.builder(
                itemCount: model.choices.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: SizedBox(
                        width: 60,
                        child: Text(
                          '${model.choices[index].flag}',
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                      title: Text('${model.choices[index].alphabeticCode}'),
                      subtitle: Text('${model.choices[index].longName}'),
                      trailing: (model.choices[index].isFavorite)
                          ? Icon(Icons.favorite, color: Colors.red)
                          : Icon(Icons.favorite_border),
                      onTap: () {
                        model.toggleFavoriteStatus(index);
                      },
                    ),
                  );
                },
              ),
            ));
  }
}
