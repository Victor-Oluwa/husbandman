import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:husbandman/core/common/app/provider/state_notifier_providers/general_product_provider.dart';
import 'package:husbandman/core/common/app/provider/state_notifier_providers/user_provider.dart';
import 'package:husbandman/core/common/widgets/hbm_text_widget.dart';
import 'package:husbandman/core/extensions/context_extension.dart';
import 'package:husbandman/core/res/color.dart';
import 'package:husbandman/core/res/fonts.dart';
import 'package:husbandman/core/services/injection/auth/auth_injection.dart';
import 'package:husbandman/core/services/route_names.dart';
import 'package:husbandman/src/auth/presentation/bloc/auth_bloc.dart';

class Dashboard extends ConsumerStatefulWidget {
  const Dashboard({super.key});

  @override
  ConsumerState<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends ConsumerState<Dashboard> {
  final _advancedDrawerController = AdvancedDrawerController();

  void _handleMenuButtonPressed() {
    _advancedDrawerController.showDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ref.read(authBlocProvider),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return AdvancedDrawer(
            backdrop: _buildBackdrop(),
            controller: _advancedDrawerController,
            animationCurve: Curves.easeInOut,
            animationDuration: const Duration(milliseconds: 300),
            childDecoration: const BoxDecoration(
              boxShadow: <BoxShadow>[BoxShadow(color: Colors.black12)],
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            drawer: _buildDrawer(context),
            child: Scaffold(
              backgroundColor: HBMColors.coolGrey,
              appBar: _buildAppBar(context),
              body: _buildBody(context),
            ),
          );
        },
      ),
    );
  }

  Container _buildBackdrop() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(color: HBMColors.charcoalGrey),
    );
  }

  SafeArea _buildDrawer(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildDrawerHeader(context),
              const Divider(),
              _buildDrawerItems(context),
            ],
          ),
        ),
      ),
    );
  }

  Padding _buildDrawerHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: context.width * 0.04,
        top: context.height * 0.06,
      ),
      child: Row(
        children: [
          CircleAvatar(
            minRadius: context.width * 0.09,
            backgroundImage: NetworkImage(
              ref.read(generalProductProvider)[1].images[0],
            ),
          ),
          SizedBox(width: context.width * 0.04),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HBMTextWidget(
                data: ref.read(userProvider).name,
                fontSize: context.width * 0.04,
                fontFamily: HBMFonts.quicksandBold,
                color: HBMColors.coolGrey,
              ),
              HBMTextWidget(
                data: 'View Profile',
                fontSize: context.width * 0.03,
                color: HBMColors.coolGrey,
              ),
            ],
          ),
        ],
      ),
    );
  }

  ListTileTheme _buildDrawerItems(BuildContext context) {
    return ListTileTheme(
      dense: true,
      textColor: HBMColors.mediumGrey,
      tileColor: HBMColors.mediumGrey,
      iconColor: HBMColors.coolGrey,
      contentPadding: EdgeInsets.only(left: context.width * 0.04),
      child: Column(
        children: [
          _buildDrawerItem(context, 'Customers', Icons.history),
          _buildDrawerItem(context, 'Deposit History', Icons.history),
          _buildDrawerItem(context, 'Withdraw History', Icons.history),
          _buildDrawerItem(context, 'Chat', Icons.history),
          _buildDrawerItem(context, 'Settings', Icons.history),
          _buildDrawerItem(context, 'Invoices', Icons.history),
          _buildDrawerItem(
            context,
            'Log Out',
            Icons.history,
            onTap: () {
              context.read<AuthBloc>().add(const SignOutEvent());
            },
          ),
          _buildDrawerItem(
            context,
            'Cart',
            Icons.history,
            onTap: () {},
          ),
          _buildDrawerItem(
            context,
            'Card',
            Icons.payment,
            onTap: () {
              Navigator.pushNamed(context, RouteNames.allCardView);
            },
          ),
        ],
      ),
    );
  }

  ListTile _buildDrawerItem(
    BuildContext context,
    String title,
    IconData icon, {
    VoidCallback? onTap,
  }) {
    return ListTile(
      onTap: onTap ?? () {},
      leading: Icon(icon, size: context.width * 0.06),
      trailing: Icon(
        Icons.arrow_forward_ios_rounded,
        color: HBMColors.coolGrey,
        size: context.width * 0.03,
      ),
      title: HBMTextWidget(
        data: title,
        fontFamily: HBMFonts.quicksandNormal,
        fontSize: context.width * 0.04,
        color: HBMColors.coolGrey,
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      elevation: 0,
      toolbarHeight: context.width * 0.20,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      title: Column(
        children: [
          HBMTextWidget(
            data: 'Welcome',
            fontSize: context.width * 0.03,
            fontFamily: HBMFonts.exoLight,
            color: Colors.grey,
          ),
          HBMTextWidget(
            data: ref.read(userProvider).name,
            fontSize: context.width * 0.05,
            fontFamily: HBMFonts.exoLight,
          ),
        ],
      ),
      leading: IconButton(
        onPressed: _handleMenuButtonPressed,
        icon: ValueListenableBuilder<AdvancedDrawerValue>(
          valueListenable: _advancedDrawerController,
          builder: (_, value, __) {
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child: Icon(
                value.visible ? Icons.clear : Icons.menu,
                key: ValueKey<bool>(value.visible),
              ),
            );
          },
        ),
      ),
    );
  }

  Column _buildBody(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildCard(context),
        _buildIconButtons(context),
        SizedBox(height: context.height * 0.01),
        _buildOrdersSection(context),
      ],
    );
  }

  SizedBox _buildCard(BuildContext context) {
    return SizedBox(
      height: context.height * 0.32,
      width: context.width * 0.95,
      child: Card(
        elevation: 0,
        color: HBMColors.transparent,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: HBMColors.grey),
          borderRadius: BorderRadius.circular(context.width * 0.05),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.width * 0.05,
            vertical: context.height * 0.03,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildCardHeader(context),
              Divider(color: HBMColors.mediumGrey),
              _buildCardDetails(context),
              _buildAddMoneyButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Wrap _buildCardHeader(BuildContext context) {
    return Wrap(
      direction: Axis.vertical,
      crossAxisAlignment: WrapCrossAlignment.center,
      alignment: WrapAlignment.center,
      children: [
        HBMTextWidget(
          data: '₦50,300,255',
          color: HBMColors.mediumGrey,
          fontSize: context.width * 0.06,
          fontFamily: HBMFonts.quicksandBold,
        ),
        HBMTextWidget(
          data: 'Current Balance',
          color: HBMColors.mediumGrey,
          fontSize: context.width * 0.03,
        ),
      ],
    );
  }

  Row _buildCardDetails(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildCardDetail(context, '₦90,322,551', 'Total Deposit'),
        _buildCardDetail(context, '17', 'Total Transaction'),
        _buildCardDetail(context, '₦33,114,088', 'Total Withdrawal'),
      ],
    );
  }

  Column _buildCardDetail(BuildContext context, String amount, String label) {
    return Column(
      children: [
        HBMTextWidget(
          data: amount,
          color: HBMColors.mediumGrey,
          fontSize: context.width * 0.04,
          fontFamily: HBMFonts.quicksandBold,
        ),
        HBMTextWidget(
          data: label,
          color: HBMColors.mediumGrey,
          fontSize: context.width * 0.03,
          fontFamily: HBMFonts.quicksandNormal,
        ),
      ],
    );
  }

  OutlinedButton _buildAddMoneyButton(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
      child: HBMTextWidget(
        data: 'Add Money',
        fontSize: context.width * 0.04,
        color: HBMColors.grey,
      ),
    );
  }

  SizedBox _buildIconButtons(BuildContext context) {
    return SizedBox(
      width: context.width * 0.85,
      height: context.height * 0.17,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildIconButton(
            context,
            HBMColors.mediumGrey,
            context.width * 0.10,
            FontAwesomeIcons.buildingColumns,
            'Withdraw',
          ),
          _buildIconButton(
            context,
            HBMColors.mediumGrey,
            context.width * 0.10,
            FontAwesomeIcons.store,
            'Shop',
          ),
          _buildIconButton(
            context,
            HBMColors.mediumGrey,
            context.width * 0.10,
            FontAwesomeIcons.idBadge,
            'Account',
          ),
        ],
      ),
    );
  }

  Container _buildIconButton(
    BuildContext context,
    Color color,
    double size,
    IconData iconData,
    String label,
  ) {
    return Container(
      width: context.width * 0.25,
      height: context.height * 0.14,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(context.width * 0.02),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FaIcon(
            iconData,
            color: color,
            size: size,
          ),
          HBMTextWidget(
            data: label,
            fontFamily: HBMFonts.quicksandBold,
            fontSize: context.width * 0.04,
            color: HBMColors.grey,
          ),
        ],
      ),
    );
  }

  Padding _buildOrdersSection(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.width * 0.03),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(context, 'Orders', () {}),
          SizedBox(height: context.height * 0.02),
          _buildOrdersList(context),
        ],
      ),
    );
  }

  Row _buildSectionHeader(
    BuildContext context,
    String title,
    VoidCallback onViewAllPressed,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        HBMTextWidget(
          data: title,
          fontSize: context.width * 0.04,
          fontFamily: HBMFonts.quicksandBold,
        ),
        GestureDetector(
          onTap: onViewAllPressed,
          child: HBMTextWidget(
            data: 'View All',
            fontSize: context.width * 0.03,
            fontFamily: HBMFonts.quicksandBold,
          ),
        ),
      ],
    );
  }

  Container _buildOrdersList(BuildContext context) {
    return Container(
      height: context.height * 0.28,
      width: context.width,
      decoration: BoxDecoration(
        color: HBMColors.lightGrey,
        border: Border.fromBorderSide(BorderSide(color: HBMColors.lightGrey)),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(
            context.width * 0.04,
          ),
          topLeft: Radius.circular(context.width * 0.04),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.width * 0.04,
          vertical: context.height * 0.02,
        ),
        child: ListView.separated(
          itemBuilder: _buildOrderItem,
          separatorBuilder: (context, index) =>
              Divider(color: HBMColors.mediumGrey),
          itemCount: 4,
        ),
      ),
    );
  }

  Widget _buildOrderItem(BuildContext context, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildOrderIcon(
          context,
          ref.read(generalProductProvider)[index].images[0],
        ),
        _buildOrderDetails(context, index),
        _buildOrderAmount(context, '₦2,200.32'),
      ],
    );
  }

  Widget _buildOrderIcon(BuildContext context, String imageUrl) {
    return FaIcon(
      FontAwesomeIcons.road,
      color: HBMColors.mediumGrey,
    );
  }

  Container _buildOrderDetails(BuildContext context, int index) {
    return Container(
      width: context.width * 0.25,
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HBMTextWidget(
            overflow: TextOverflow.ellipsis,
            data: ref.read(generalProductProvider)[index].name,
            fontFamily: HBMFonts.quicksandBold,
            fontSize: context.width * 0.04,
            color: HBMColors.mediumGrey,
          ),
          HBMTextWidget(
            data: '$index/15',
            fontFamily: HBMFonts.quicksandNormal,
            fontSize: context.width * 0.03,
            color: HBMColors.mediumGrey,
          ),
        ],
      ),
    );
  }

  HBMTextWidget _buildOrderAmount(BuildContext context, String amount) {
    return HBMTextWidget(
      data: amount,
      fontFamily: HBMFonts.quicksandBold,
      fontSize: context.width * 0.04,
      color: HBMColors.mediumGrey,
    );
  }
}
