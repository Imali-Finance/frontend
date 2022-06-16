import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:imali/src/ui/dashboard_pages/tutorials.dart';
import 'package:imali/src/ui/dashboard_pages/unverified.dart';
import 'package:imali/src/ui/dashboard_pages/user_summary.dart';
import '../res/styles.dart';
import 'dashboard_pages/account.dart';
import 'dashboard_pages/invest.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with TickerProviderStateMixin {
  int? _pageNo = 0;
  late final TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(
          tag: 'logo',
          child: SvgPicture.asset(
            'assets/images/Logo.svg',
            height: 30,
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Summary(),
          Invest(),
          Tutorials(),
          Account(),
        ],
      ),
      bottomNavigationBar: TabBar(
        indicatorColor: primary(context),
        controller: _tabController,
        tabs: [
          Tab(
            icon: SvgPicture.asset('assets/images/home.svg'),
            text: 'Home',
          ),
          Tab(
            icon: SvgPicture.asset('assets/images/invest.svg'),
            text: 'Invest',
          ),
          Tab(
            icon: SvgPicture.asset('assets/images/brain.svg'),
            text: 'Tutorials',
          ),
          Tab(
            icon: SvgPicture.asset('assets/images/settings.svg'),
            text: 'Account',
          ),
        ],
      )
        );
  }
}
