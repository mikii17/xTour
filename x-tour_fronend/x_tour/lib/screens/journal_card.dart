import 'package:flutter/material.dart';
import '../custom/custom.dart';
import 'package:dots_indicator/dots_indicator.dart';

class journalCard extends StatefulWidget {
  journalCard({
    super.key,
    this.journal,
    this.user,
  });

  final Object? journal;
  final Object? user;

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
              Image.asset(
                "assets/food_cupcake.jpg",
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
                      onPressed: () => {
                            // handle the click
                          },
                      icon: iconBuilder(Icons.link)))
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(children: [
              Text(
                "How to play with differrent shapes",
                style: theme.textTheme.bodyLarge,
              ),
              const SizedBox(height: 10),
              Text(
                "create your own shapes with this things that you see around you. you may be surprised by what you see in there this is the last waenign that U am going to fice you in this arena of child hood",
                style: theme.textTheme.bodyMedium,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.justify,
                maxLines: 3,
              ),
              const SizedBox(
                height: 10,
              ),
              userCard(),
            ]),
          ),
        ]));
  }

  Widget userCard() {
    return Container(
      padding: const EdgeInsets.only(left: 10),
      child: Row(children: [
        profile_avatar(
          imageUrl: "assets/profile_pics/person_sandra.jpeg",
          radius: 50,
        ),
        const SizedBox(
          width: 15,
        ),
        const Text(
          "Leul Abay",
          // TODO: 
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ]),
    );
  }

  Widget iconBuilder(iconData) {
    return Icon(
      iconData,
      size: 35,
    );
  }
}
