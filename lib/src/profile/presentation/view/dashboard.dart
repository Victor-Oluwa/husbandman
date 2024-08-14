import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:husbandman/core/common/widgets/hbm_text_widget.dart';
import 'package:husbandman/core/extensions/context_extension.dart';
import 'package:husbandman/core/res/color.dart';
import 'package:husbandman/core/res/fonts.dart';
import 'package:husbandman/core/services/route_names.dart';
import 'package:husbandman/src/auth/presentation/view/verify_invitation_key_screen.dart';
import 'package:husbandman/src/profile/presentation/view/profile_view.dart';
import 'package:husbandman/src/profile/presentation/widgets/chart.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  final List<Widget> _pages = [
    const HomeDashboard(),
    const VerifyInvitationKeyScreen(),
    const Center(child: Text('chat Page', style: TextStyle(fontSize: 24))),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HBMColors.coolGrey,
      body: Stack(
        children: _pages.asMap().entries.map((entry) {
          int index = entry.key;
          Widget page = entry.value;
          return Offstage(
            offstage: _selectedIndex != index,
            child: AnimatedOpacity(
              opacity: _selectedIndex == index ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: page,
            ),
          );
        }).toList(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.space_dashboard_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box_rounded),
            label: 'Deposit',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mark_unread_chat_alt_rounded),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_pin_rounded),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: HBMColors.charcoalGrey,
        unselectedItemColor: HBMColors.mediumGrey,
        backgroundColor: HBMColors.coolGrey,
        elevation: 0,
        selectedLabelStyle: TextStyle(
          fontFamily: HBMFonts.quicksandBold,
        ),
        unselectedLabelStyle: TextStyle(
          fontFamily: HBMFonts.quicksandBold,
        ),
      ),
    );
  }
}

class HomeDashboard extends StatefulWidget {
  const HomeDashboard({super.key});

  @override
  State<HomeDashboard> createState() => _HomeDashboardState();
}

class _HomeDashboardState extends State<HomeDashboard> {
  final ScrollController _scrollController = ScrollController();
  bool _isAutoScrolling = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.userScrollDirection ==
            ScrollDirection.reverse &&
        !_isAutoScrolling &&
        _scrollController.position.pixels <
            _scrollController.position.maxScrollExtent -
                (context.height * 0.07)) {
      setState(() {
        _isAutoScrolling = true;
      });

      double offset =
          _scrollController.position.maxScrollExtent - (context.height * 0.07);

      _scrollController
          .animateTo(
        offset,
        duration: const Duration(seconds: 1),
        curve: Curves.easeOut,
      )
          .then((_) {
        // Check if more content can be scrolled manually
        setState(() {
          _isAutoScrolling = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HBMColors.coolGrey,
      body: Listener(
        onPointerMove: (_) {
          if (_scrollController.position.pixels == 0 && !_isAutoScrolling) {
            _onScroll();
          }
        },
        child: SafeArea(
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                leading: Padding(
                  padding: EdgeInsets.only(left: context.width * 0.02),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.circle_notifications_outlined,
                      size: context.width * 0.07,
                    ),
                  ),
                ),
                actions: [
                  Padding(
                    padding: EdgeInsets.only(right: context.width * 0.02),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, RouteNames.homePage);
                      },
                      icon: Icon(
                        Icons.storefront,
                        size: context.width * 0.07,
                      ),
                    ),
                  ),
                ],
                backgroundColor: HBMColors.coolGrey,
                pinned: false,
                expandedHeight: context.height * 0.32,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  background: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.width * 0.05,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: context.height * 0.06,
                        ),
                        Wrap(
                          direction: Axis.vertical,
                          children: [
                            HBMTextWidget(
                              data: 'Welcome back',
                              fontSize: context.width * 0.10,
                              fontFamily: HBMFonts.quicksandBold,
                            ),
                            HBMTextWidget(
                              data: 'Gabriel',
                              fontSize: context.width * 0.08,
                              fontFamily: HBMFonts.quicksandBold,
                            ),
                          ],
                        ),
                        SizedBox(height: context.height * 0.03),
                        Wrap(
                          direction: Axis.vertical,
                          children: [
                            HBMTextWidget(
                              data: 'Your current balance:',
                              fontSize: context.width * 0.04,
                              fontFamily: HBMFonts.quicksandBold,
                            ),
                            HBMTextWidget(
                              data: '₦250,000',
                              fontSize: context.width * 0.08,
                              fontFamily: HBMFonts.quicksandBold,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: context.width * 0.05),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          HBMTextWidget(
                            data: 'Statistics:',
                            fontFamily: HBMFonts.quicksandBold,
                          ),
                          SizedBox(height: context.height * 0.01),
                          _buildStatisticsCard(context),
                          SizedBox(height: context.height * 0.02),
                          _buildSectionTitle(context, 'Overview:', 'See All'),
                          SizedBox(height: context.height * 0.01),
                          _buildOverViewCard(context),
                          SizedBox(height: context.height * 0.02),
                          _buildSectionTitle(
                              context, 'Last transactions:', 'See All'),
                          SizedBox(height: context.height * 0.01),
                          _buildTransactionCard(context),
                          SizedBox(height: context.height * 0.02),
                          _buildSectionTitle(context, 'Orders:', 'See All'),
                          SizedBox(height: context.height * 0.01),
                          _buildOrderCard(context),
                          SizedBox(height: context.height * 0.02),
                          _buildSectionTitle(
                              context, 'Pending deposits:', 'See All'),
                          SizedBox(height: context.height * 0.01),
                          _buildPendingDepositsCard(context),
                          SizedBox(height: context.height * 0.02),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOverViewCard(BuildContext context) {
    return SizedBox(
      width: context.width,
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 0,
        color: HBMColors.mediumGrey,
        child: Padding(
          padding: EdgeInsets.all(context.width * 0.06),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildOverviewItem(title: 'Delivered:', data: '₦0'),
              _buildOverviewItem(title: 'Products:', data: '0'),
              _buildOverviewItem(title: 'Pending deliveries:', data: '0'),
              _buildOverviewItem(title: 'Pending funds:', data: '₦0'),
              _buildOverviewItem(title: 'Customers:', data: '0'),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildOverviewItem({
    required String title,
    required String data,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        HBMTextWidget(
          data: title,
          color: HBMColors.lightGrey,
          fontFamily: HBMFonts.quicksandBold,
        ),
        HBMTextWidget(
          data: data,
          color: HBMColors.lightGrey,
        ),
      ],
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title, String action) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        HBMTextWidget(
          data: title,
          fontFamily: HBMFonts.quicksandBold,
        ),
        HBMTextWidget(
          data: action,
          color: HBMColors.grey,
        ),
      ],
    );
  }

  Widget _buildTransactionCard(BuildContext context) {
    return SizedBox(
      width: context.width,
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 0,
        color: HBMColors.mediumGrey,
        child: Padding(
          padding: EdgeInsets.all(context.width * 0.06),
          child: const HBMTextWidget(
            data: 'No transaction made yet',
            color: HBMColors.lightGrey,
          ),
        ),
      ),
    );
  }

  Widget _buildStatisticsCard(BuildContext context) {
    return SizedBox(
      width: context.width,
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 0,
        color: HBMColors.mediumGrey,
        child: Padding(
          padding: EdgeInsets.all(context.width * 0.02),
          child: const LineChartSample2(),
        ),
      ),
    );
  }

  Widget _buildOrderCard(BuildContext context) {
    return SizedBox(
      width: context.width,
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 0,
        color: HBMColors.mediumGrey,
        child: Padding(
          padding: EdgeInsets.all(context.width * 0.06),
          child: const HBMTextWidget(
            data: 'No order placed yet',
            color: HBMColors.lightGrey,
          ),
        ),
      ),
    );
  }

  Widget _buildPendingDepositsCard(BuildContext context) {
    return SizedBox(
      width: context.width,
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 0,
        color: HBMColors.mediumGrey,
        child: Padding(
          padding: EdgeInsets.all(context.width * 0.06),
          child: const HBMTextWidget(
            data: 'No pending deposits',
            color: HBMColors.lightGrey,
          ),
        ),
      ),
    );
  }
}
