import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/post_model.dart';
import 'post_card.dart';
import 'nav_bar.dart';

class MobileLayout extends StatefulWidget {
  final String temperature;

  const MobileLayout({Key? key, required this.temperature}) : super(key: key);

  @override
  _MobileLayoutState createState() => _MobileLayoutState();
}

class _MobileLayoutState extends State<MobileLayout> {
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
        MobileNavBar(temperature: widget.temperature),
        Expanded(
          child: Consumer<PostModel>(
            builder: (context, postModel, child) {
              return RefreshIndicator(
                onRefresh: () => postModel.refreshPosts(),
                child: ListView.builder(
                  controller: _scrollController,
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