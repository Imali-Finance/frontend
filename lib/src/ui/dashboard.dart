import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:imali/src/ui/dashboard_pages/tutorials.dart';
import 'package:imali/src/ui/dashboard_pages/unverified.dart';
import '../res/styles.dart';
import 'dashboard_pages/account.dart';
import 'dashboard_pages/invest.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with TickerProviderStateMixin {
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
        children: const [
          Unverified(),
          Invest(),
          Tutorials(),
          Account(),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: TabBar(
          indicator: BoxDecoration(
            border: Border.all(color: primary(context))
          ),
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
        ),
      )
        );
  }
}
