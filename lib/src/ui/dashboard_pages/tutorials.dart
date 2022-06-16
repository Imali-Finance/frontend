import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../methods.dart';
import '../../res/styles.dart';

class Tutorials extends StatelessWidget {
  String user = 'Kimberly';
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height(context),
      width: width(context),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.getStarted,
            style: Theme.of(context).textTheme.headline4!.copyWith(fontWeight: FontWeight.bold),
          ),
          const Spacer(),
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
          Text(
            AppLocalizations.of(context)!.getStartedSubtext,
            style: Theme.of(context).textTheme.subtitle2,
            textAlign: TextAlign.justify,
          ),
          const Spacer(),
          Text(
            AppLocalizations.of(context)!.otherTopics,
            style: Theme.of(context).textTheme.subtitle2!.copyWith(fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          SizedBox(
            width: width(context),
            height: height(context) * 0.25,
            child: GridView.builder(
              physics: BouncingScrollPhysics(),
                itemCount: _placeholder.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisSpacing: 10),
                itemBuilder: (context, index) {
                  var _item = _placeholder[index];
                  return Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.all(20),
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: primary(context),
                          ),
                        ),
                        child: SvgPicture.asset('assets/images/youtube.svg'),
                      ),
                      Text(_item)
                    ],
                  );
                }),
          ),
        ],
      ),
    );
  }

  final List<String> _placeholder = ['Topic 1', 'Topic 2', 'Topic 3', 'Topic 4', 'Topic 5', 'Topic 6', 'Topic 7'];
}
