import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/post_model.dart';
import 'post_card.dart';
import 'nav_bar.dart';

class DesktopLayout extends StatefulWidget {
  final String temperature;

  const DesktopLayout({Key? key, required this.temperature}) : super(key: key);

  @override
  _DesktopLayoutState createState() => _DesktopLayoutState();
}

class _DesktopLayoutState extends State<DesktopLayout> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      Provider.of<PostModel>(context, listen: false).loadMorePosts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DesktopNavBar(temperature: widget.temperature),
        Expanded(
          child: Consumer<PostModel>(
            builder: (context, postModel, child) {
              return RefreshIndicator(
                onRefresh: () => postModel.refreshPosts(),
                child: GridView.builder(
                  controller: _scrollController,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.0,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: postModel.displayedPosts.length + 1,
                  itemBuilder: (context, index) {
                    if (index < postModel.displayedPosts.length) {
                      return PostCard(post: postModel.displayedPosts[index]);
                    } else if (postModel.hasMore) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      return Center(child: Text('No more posts'));
                    }
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}