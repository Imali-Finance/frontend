import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:imali/src/tutorial_config.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../res/styles.dart';

class Tutorials extends StatefulWidget {
  const Tutorials({Key? key}) : super(key: key);

  @override
  State<Tutorials> createState() => _TutorialsState();
}

class _TutorialsState extends State<Tutorials> {
  bool? isConnected;
  checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      setState(() {
        isConnected = true;
      });
      log('Connected to Mobile Data');
    } else if (connectivityResult == ConnectivityResult.wifi) {
      setState(() {
        isConnected = true;
      });
      log('Connected to Wi-Fi');
    } else if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        isConnected = false;
      });
      log('No net');
    }
  }

  @override
  void initState() {
    super.initState();
    checkConnectivity();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: height(context)*0.75,
        width: width(context),
        padding: const EdgeInsets.all(20),
        child: (isConnected ?? false)
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.getStarted,
                    style: Theme.of(context).textTheme.headline4!.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => _launchYoutubeURL('f7V0NELM8BQ'),
                    child: Container(
                      width: width(context),
                      height: 200,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: primary(context),
                        ),
                      ),
                      child: Image.network('https://img.youtube.com/vi/f7V0NELM8BQ/0.jpg', fit: BoxFit.cover),
                    ),
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
                    height: height(context) * 0.2,
                    child: GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: tutorialList.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 10),
                        itemBuilder: (context, index) {
                          var _item = tutorialList[index];
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () => _launchYoutubeURL(_item.youtubeID),
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  width: 120,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: primary(context),
                                    ),
                                  ),
                                  child: Image.network('https://img.youtube.com/vi/${_item.youtubeID}/0.jpg',
                                      fit: BoxFit.cover),
                                ),
                              ),
                              Text(_item.tutorial)
                            ],
                          );
                        }),
                  ),
                ],
              )
            : Center(
                child: Text(
                    'Sorry it looks like you have no internet. Please connect to a network in order to access this page.')),
      ),
    );
  }

  _launchYoutubeURL(String youtubeURL) async {
    final Uri _url = Uri.parse('https://www.youtube.com/watch?v=$youtubeURL');
    if (!await launchUrl(_url)) throw 'Could not launch $_url';
  }
}
