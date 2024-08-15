import 'package:flutter/material.dart';
 import 'package:flutter_login/block/Home/home_block.dart';
import 'package:flutter_login/block/Home/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../../block/Home/home_event.dart';
import '../../routes/app_routes.dart';


class HomeScreen extends StatelessWidget {

TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    context.read<HomeBloc>().add(FetchPosts() );
    return Scaffold(
appBar: AppBar(
  actions: [
    IconButton(
      icon: const Icon(Icons.exit_to_app   , color: Colors.red,),
      onPressed: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn' , false);
        Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.loginScreen, (Route route) => false);

      },
    )
  ]
),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (query) {


                    context.read<HomeBloc>().add(SearchPosts(query));


                },
                decoration: const InputDecoration(
                  hintText: 'Search posts...',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is PostLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is PostLoaded) {
                    return ListView.separated(
                      itemCount: state.posts.length,
                      itemBuilder: (context, index) {
                        final post = state.posts[index];
                        return ListTile(
                          title: Text(post.title),
                          subtitle: Text(post.content),
                        );
                      }, separatorBuilder: (BuildContext context, int index) {
                        return const Divider();
                    },
                    );
                  } else if (state is PostError) {
                    return Center(child: Text(state.message));
                  } else {
                    return const Center(child: Text('No posts found'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
