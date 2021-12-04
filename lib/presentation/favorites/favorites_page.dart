import 'package:auto_route/auto_route.dart';
import 'package:checklist/injection/cubit_factory.dart';
import 'package:checklist/presentation/favorites/cubit/favorites_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesPage extends StatefulWidget implements AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    final CubitFactory cubitFactory = CubitFactory.of(context);
    final FavoritesCubit favoritesCubit = cubitFactory.get();

    return BlocProvider<FavoritesCubit>(
      create: (context) => favoritesCubit,
      child: this,
    );
  }

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Favorites page"),
      ),
    );
  }
}
