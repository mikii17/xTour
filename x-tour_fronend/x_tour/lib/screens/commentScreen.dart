import 'package:flutter/material.dart';
import '../custom/custom.dart';

class Comment {
  final String username;
  final String commentText;
  List<Comment> replies;
  bool folded;
  String imageUrl;

  Comment({
    required this.username,
    required this.commentText,
    this.replies = const [],
    this.folded = true,
    this.imageUrl = '',
  });
}

class XtourCommentSection extends StatefulWidget {
  @override
  _XtourCommentSectionState createState() => _XtourCommentSectionState();
}

class _XtourCommentSectionState extends State<XtourCommentSection> {
  bool isLike = false;
  final List<Comment> comments = [
    Comment(
      username: 'Mike',
      commentText: 'Awesome post!',
      replies: [
        Comment(
          username: 'Dani',
          commentText: 'Thanks!',
        ),
        Comment(
          username: 'Lula',
          commentText: 'Great shot!',
        ),
      ],
    ),
    Comment(
      username: 'Abiy',
      commentText: 'Nice work!',
      replies: [
        Comment(
          username: 'zele',
          commentText: 'Thanks!',
        ),
        Comment(
          username: 'romi',
          commentText: 'Great shot!',
        ),
      ],
    ),
  ];

  void addComment(String newComment) {
    setState(() {
      final comment = Comment(
        username: 'user-X',
        commentText: newComment,
        replies: [],
      );
      comments.add(comment);
      _commentController.clear();
    });
  }

  void addReply(Comment comment, String replyText) {
    setState(() {
      final reply = Comment(
        username: 'user-X',
        commentText: replyText,
        imageUrl: '',
      );
      comment.replies.add(reply);
    });
  }

  final TextEditingController _commentController = TextEditingController();
  final TextEditingController _replyController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    _replyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 6,
        ),
        Text(
          'Comments',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Container(
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: comments.length,
                itemBuilder: (context, index) {
                  final comment = comments[index];

                  return Column(
                    children: [
                      const SizedBox(
                        height: 8,
                      ),
                      ListTile(
                        leading: profile_avatar(
                          radius: 45,
                          imageUrl: comment.imageUrl,
                        ),
                        title: Text(comment.username),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(comment.commentText),
                            SizedBox(height: 4),
                            TextButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20),
                                    ),
                                  ),
                                  builder: (context) {
                                    return StatefulBuilder(
                                      builder: (BuildContext context,
                                          StateSetter setState) {
                                        return Padding(
                                          padding: EdgeInsets.only(
                                            bottom: MediaQuery.of(context)
                                                .viewInsets
                                                .bottom,
                                          ),
                                          child: Container(
                                            padding: const EdgeInsets.all(16),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Replying to ${comment.username}',
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(height: 8),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: TextField(
                                                        controller:
                                                            _replyController,
                                                        autofocus: true,
                                                        decoration:
                                                            const InputDecoration(
                                                          hintText:
                                                              'Enter your reply',
                                                        ),
                                                      ),
                                                    ),
                                                    IconButton(
                                                      icon: Icon(Icons.send),
                                                      onPressed: () {
                                                        final reply =
                                                            _replyController
                                                                .text;
                                                        if (reply.isNotEmpty) {
                                                          addReply(
                                                              comment, reply);
                                                          Navigator.pop(
                                                              context);
                                                          _replyController
                                                              .clear();
                                                        }
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                              child: const Text('Reply'),
                            ),
                          ],
                        ),
                        onTap: () {
                          // Handle tapping on a comment
                          // e.g., show options or navigate to user's profile
                        },
                      ),
                      if (!comment.folded)
                        ...comment.replies.map((reply) {
                          return Container(
                            margin: const EdgeInsets.only(left: 16),
                            child: ListTile(
                              leading: profile_avatar(
                                radius: 45,
                                imageUrl: comment.imageUrl,
                              ),
                              title: Text(reply.username),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(reply.commentText),
                                ],
                              ),
                              onTap: () {
                                // Handle tapping on a reply
                                // e.g., show options or navigate to user's profile
                              },
                            ),
                          );
                        }).toList(),
                      if (comment.replies.length > 0)
                        Container(
                          margin: EdgeInsets.only(left: 16),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                comment.folded = !comment.folded;
                              });
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 4),
                              child: Text(
                                comment.folded
                                    ? 'View ${comment.replies.length} replies'
                                    : 'Hide replies',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ),
                          ),
                        ),
                      Divider(),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.transparent,
              border: Border.all(
                color: Theme.of(context).primaryColor,
                width: 1.0,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      hintText: 'Add a comment...',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    ),
                    onSubmitted: addComment,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    if (_commentController.text.isNotEmpty) {
                      addComment(_commentController.text);
                      _commentController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
