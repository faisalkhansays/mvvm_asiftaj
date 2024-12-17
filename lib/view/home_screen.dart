import 'package:flutter/material.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/view_model/home_view_view_model.dart';
import 'package:mvvm/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

import '../data/response/status.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeViewViewModel homeViewViewModel = HomeViewViewModel();

  @override
  void initState() {
    homeViewViewModel.fetchMoviesListApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userPreference = Provider.of<UserViewModel>(context);
    return Scaffold(
        appBar: AppBar(
          actions: [
            InkWell(
              onTap: () {
                userPreference.remove().then((value) {}).then((value) {
                  Navigator.pushNamed(context, RoutesName.login);
                });
              },
              child: Text("Logout"),
            ),
            SizedBox(
              width: 20,
            )
          ],
          automaticallyImplyLeading: false,
        ),
        body: ChangeNotifierProvider<HomeViewViewModel>(
          create: (context) => homeViewViewModel,
          child: Consumer<HomeViewViewModel>(
            builder: (context, value, _) {
              switch (value.moviesList.status) {
                case Status.LOADING:
                  return CircularProgressIndicator();
                case Status.ERROR:
                  return Text(value.moviesList.message.toString());

                case Status.COMPLETED:
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          leading: Image.network(
                            value.moviesList.data!.movies![index].posterurl.toString(),
                            errorBuilder: (context, error, stack) =>
                                Icon(Icons.error, color: Colors.red),
                          ),
                          title: Text(value.moviesList.data!.movies![index].title.toString()),
                          subtitle: Text(value.moviesList.data!.movies![index].year.toString()),
                          trailing: Row(
                            children: [
                              Text("233"),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                case null:

              }
              //eve.holt@reqres.in
              // cityslicka
              return Container();
            },
          ),
        ));
  }
}
