import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../methods.dart';
import '../../res/styles.dart';

class Unverified extends StatelessWidget {
//   final YoutubePlayerController _controller = YoutubePlayerController(
//     initialVideoId: 'iLnmTe5Q2Qw',
//     flags: const YoutubePlayerFlags(
//         autoPlay: false,
//         mute: true,
//     ),
// );
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
              // child: YoutubePlayer(
              //   controller: _controller,
    //           onReady () {
    //     _controller.addListener(listener);
    // },
              // )
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
