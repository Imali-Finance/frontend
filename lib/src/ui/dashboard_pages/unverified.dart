import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../res/styles.dart';

class Unverified extends StatefulWidget {

  const Unverified({Key? key}) : super(key: key);

  @override
  State<Unverified> createState() => _UnverifiedState();
}

class _UnverifiedState extends State<Unverified> {
  final YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: 'f7V0NELM8BQ',
    flags: const YoutubePlayerFlags(
        autoPlay: false,
        showLiveFullscreenButton: false,
        useHybridComposition: false,
    ),
);

  String user = 'Kimberly';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: height(context),
        width: width(context),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(),
            Text(
              AppLocalizations.of(context)!.unverifiedTitle(user),
              style: Theme.of(context).textTheme.headline4,
            ),
            const Spacer(),
            Text(
              AppLocalizations.of(context)!.unverifiedBody,
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.justify,
            ),
            const Spacer(flex: 2),
            Container(
              width: width(context),
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(
                  color: primary(context),
                ),
              ),
              child: YoutubePlayer(
                controller: _controller,
              )
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
