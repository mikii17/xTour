import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:x_tour/journal/models/journal.dart';
import 'package:x_tour/user/models/user.dart';
import 'custom.dart';
import 'package:share_plus/share_plus.dart';

class journalCard extends StatefulWidget {
  const journalCard({
    super.key,
    required this.journal,
    required this.user,
  });

  final Journal journal;
  final User user;

  @override
  JournalState createState() => JournalState();
}

class JournalState extends State<journalCard> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
        height: null,
        width: double.infinity,
        color: theme.cardColor,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Stack(
            children: [
              Image.network(
                "http://10.0.2.2/${widget.journal.image!}",
                width: double.infinity,
                height: 400, // Adjust the width as needed
                fit: BoxFit.cover,
              ),
              Container(
                height: 400,
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.transparent, Colors.black],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.7, 1],
                  ),
                ),
              ),
              Positioned(
                  right: 15,
                  bottom: 10,
                  child: IconButton(
                      onPressed: () {
                        GoRouter.of(context).push(
                            "/journal/webview?link=${widget.journal.link}");
                      },
                      icon: iconBuilder(Icons.link)))
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(children: [
              Text(
                widget.journal.title,
                style: theme.textTheme.bodyLarge,
              ),
              const SizedBox(height: 10),
              Text(
                widget.journal.description,
                style: theme.textTheme.bodyMedium,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.justify,
                maxLines: 3,
              ),
              const SizedBox(
                height: 10,
              ),
              userCard(context),
            ]),
          ),
        ]));
  }

  Widget userCard(context) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context)
            .go("/journal/othersProfile/${widget.journal.creator!.id}");
      },
      child: Container(
        padding: const EdgeInsets.only(left: 10),
        child: Row(children: [
          profile_avatar(
            imageUrl: widget.journal.creator!.profilePicture!,
            radius: 50,
          ),
          const SizedBox(
            width: 15,
          ),
          Text(
            widget.journal.creator!.username!,
            // TODO:
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ]),
      ),
    );
  }

  Widget iconBuilder(iconData) {
    return Icon(
      iconData,
      size: 35,
    );
  }
}
