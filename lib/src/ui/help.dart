import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:imali/src/methods.dart';
import 'package:imali/src/res/styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Help extends StatefulWidget {
  const Help({Key? key}) : super(key: key);

  @override
  State<Help> createState() => _HelpState();
}

class _HelpState extends State<Help> {
  bool _isVerified = false;
  GlobalKey<FormState> _issueForm = GlobalKey<FormState>();
  TextEditingController _issue = TextEditingController();
  PageController _controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Align(
          alignment: Alignment.centerRight,
          child: Hero(
            tag: 'logo',
            child: SvgPicture.asset(
              'assets/images/Logo.svg',
              height: 30,
            ),
          ),
        ),
      ),
      body: Container(
        height: height(context),
        width: width(context),
        padding: const EdgeInsets.all(20),
        child: PageView(
          controller: _controller,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Column(
              children: [
                const Spacer(),
                Icon(Icons.help_outline, size: 125, color: primary(context)),
                const Spacer(),
                Text(
                  AppLocalizations.of(context)!.help,
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const Spacer(),
                SizedBox(
                  width: width(context),
                  child: OutlinedButton(
                    child: Text(AppLocalizations.of(context)!.faqs),
                    onPressed: () {},
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: width(context),
                  child: OutlinedButton(
                    child: Text(AppLocalizations.of(context)!.problem),
                    onPressed: () {
                      _controller.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
                    },
                  ),
                ),
                const Spacer(flex: 2),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.contact,
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const Spacer(),
                Text(
                  AppLocalizations.of(context)!.issueSub,
                  style: Theme.of(context).textTheme.subtitle2,
                  textAlign: TextAlign.justify,
                ),
                const Spacer(),
                Container(
                  height: height(context) * 0.25,
                  width: width(context),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: primary(context),
                    ),
                  ),
                  child: Form(
                    key: _issueForm,
                    child: TextFormField(
                      expands: true,
                      maxLines: null,
                      minLines: null,
                      controller: _issue,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Please enter your issue';
                        }
                        if (val.length < 100) {
                          return 'Please be more detailed';
                        }
                        return null;
                      },
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.issue,
                        enabledBorder: InputBorder.none,
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.all(0),
                      ),
                    ),
                  ),
                ),
                const Spacer(flex: 2),
                SizedBox(
                  width: width(context),
                  child: OutlinedButton(
                    child: Text(AppLocalizations.of(context)!.submitButton),
                    onPressed: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      if (_issueForm.currentState!.validate()) {
                        log('Issue has been sent');
                      }
                    },
                  ),
                ),
                const Spacer(flex: 2),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
