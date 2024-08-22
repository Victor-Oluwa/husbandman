import 'package:flutter/material.dart';
import 'package:husbandman/core/common/widgets/hbm_text_widget.dart';
import 'package:husbandman/core/extensions/context_extension.dart';
import 'package:husbandman/core/res/color.dart';
import 'package:husbandman/core/services/route_names.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HBMColors.coolGrey,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.width * 0.05),
          child: CustomScrollView(
            slivers: [
              _buildAppBar(context),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    SizedBox(height: context.height * 0.03),
                    _buildSection(
                      onTap: () {},
                      context: context,
                      title: 'ACCOUNT INFORMATION',
                      actionText: 'Expand',
                      content: _accountInformationCard(context),
                    ),
                    _buildSection(
                      onTap: () {
                        Navigator.pushNamed(context, RouteNames.sellerProducts);
                      },
                      context: context,
                      title: 'PRODUCTS',
                      actionText: 'Manage',
                      content: _buildProductList(context),
                    ),
                    _buildSection(
                      onTap: () {},
                      context: context,
                      title: 'PERSONAL DETAILS',
                      content: _personalDetailsCard(context),
                    ),
                    _buildSection(
                      onTap: () {},
                      context: context,
                      title: 'History',
                      content: _historyCard(context),
                    ),
                    SizedBox(height: context.height * 0.03),
                    _buildLogoutButton(context),
                    SizedBox(height: context.height * 0.02),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SliverAppBar _buildAppBar(BuildContext context) {
    return SliverAppBar(
      backgroundColor: HBMColors.coolGrey,
      actions: [
        IconButton(
          onPressed: () {},
          icon: const HBMTextWidget(data: 'Done'),
        ),
      ],
      expandedHeight: context.height * 0.30,
      flexibleSpace: FlexibleSpaceBar(
        background: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: context.width * 0.15,
                  backgroundColor: HBMColors.grey,
                ),
                Positioned(
                  right: context.width * 0.00,
                  child: Card(
                    elevation: 0,
                    color: HBMColors.coolGrey,
                    shape: const CircleBorder(
                      side: BorderSide(color: HBMColors.coolGrey),
                    ),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {},
                      icon: const Icon(Icons.edit),
                    ),
                  ),
                ),
              ],
            ),
            HBMTextWidget(
              data: 'Gabriel',
              fontSize: context.width * 0.07,
            ),
            HBMTextWidget(
              data: '0 Customers',
              fontSize: context.width * 0.04,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required BuildContext context,
    required String title,
    required Widget content,
    required VoidCallback onTap,
    String actionText = '',
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _titleWidget(
          context: context,
          title: title,
          actionText: actionText,
          onTap: onTap,
        ),
        SizedBox(height: context.height * 0.01),
        content,
        SizedBox(height: context.height * 0.02),
      ],
    );
  }

  Row _titleWidget({
    required BuildContext context,
    required String title,
    required String actionText,
    required VoidCallback onTap,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        HBMTextWidget(
          data: title,
          fontSize: context.width * 0.03,
        ),
        if (actionText.isNotEmpty)
          GestureDetector(
            onTap: onTap,
            child: HBMTextWidget(
              data: actionText,
              fontSize: context.width * 0.03,
            ),
          ),
      ],
    );
  }

  Container _buildProductList(BuildContext context) {
    return Container(
      height: context.height * 0.16,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (context, index) {
          return SizedBox(
            width: context.width * 0.30,
            child: const Card(color: HBMColors.grey),
          );
        },
      ),
    );
  }

  TextButton _buildLogoutButton(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: HBMColors.mediumGrey,
        fixedSize: Size(context.width, context.height * 0.06),
      ),
      onPressed: () {},
      child: HBMTextWidget(
        data: 'Log out',
        fontSize: context.width * 0.05,
        color: Colors.redAccent,
      ),
    );
  }

  SizedBox _accountInformationCard(BuildContext context) {
    return _buildCard(
      context,
      children: [
        _cardDataRow(
          context: context,
          title: const HBMTextWidget(
            data: 'Account type',
            color: HBMColors.lightGrey,
          ),
          data: const HBMTextWidget(
            data: 'Seller',
            color: HBMColors.lightGrey,
          ),
        ),
        _cardDataRow(
          context: context,
          title: const HBMTextWidget(
            data: 'Badge',
            color: HBMColors.lightGrey,
          ),
          data: const HBMTextWidget(
            data: 'New',
            color: HBMColors.lightGrey,
          ),
        ),
        const Divider(color: Colors.grey),
        SizedBox(height: context.height * 0.01),
        _cardDataRow(
          context: context,
          title: const HBMTextWidget(
            data: 'Description',
            color: HBMColors.lightGrey,
          ),
          data: const Icon(Icons.edit, color: HBMColors.lightGrey),
        ),
      ],
    );
  }

  SizedBox _personalDetailsCard(BuildContext context) {
    return _buildCard(
      context,
      children: [
        _cardDataRow(
          context: context,
          icon:
              const Icon(Icons.person_pin_outlined, color: HBMColors.lightGrey),
          title: const HBMTextWidget(
            data: 'Personal information',
            color: HBMColors.lightGrey,
          ),
          data: Icon(
            size: context.width * 0.04,
            Icons.arrow_forward_ios_rounded,
            color: HBMColors.lightGrey,
          ),
        ),
        const Divider(color: HBMColors.grey),
        _cardDataRow(
          context: context,
          icon: const Icon(Icons.credit_card, color: HBMColors.lightGrey),
          title: const HBMTextWidget(
            data: 'Cards',
            color: HBMColors.lightGrey,
          ),
          data: Icon(
            size: context.width * 0.04,
            Icons.arrow_forward_ios_rounded,
            color: HBMColors.lightGrey,
          ),
        ),
      ],
    );
  }

  SizedBox _historyCard(BuildContext context) {
    return _buildCard(
      context,
      children: [
        _cardDataRow(
          context: context,
          icon: const Icon(Icons.add_card_rounded, color: HBMColors.lightGrey),
          title: const HBMTextWidget(
            data: 'Deposits',
            color: HBMColors.lightGrey,
          ),
          data: Icon(
            size: context.width * 0.04,
            Icons.arrow_forward_ios_rounded,
            color: HBMColors.lightGrey,
          ),
        ),
        const Divider(color: HBMColors.grey),
        _cardDataRow(
          context: context,
          icon:
              const Icon(Icons.food_bank_outlined, color: HBMColors.lightGrey),
          title: const HBMTextWidget(
            data: 'Withdrawals',
            color: HBMColors.lightGrey,
          ),
          data: Icon(
            size: context.width * 0.04,
            Icons.arrow_forward_ios_rounded,
            color: HBMColors.lightGrey,
          ),
        ),
        const Divider(color: HBMColors.grey),
        _cardDataRow(
          context: context,
          icon: const Icon(Icons.error_outline_rounded,
              color: HBMColors.lightGrey),
          title: const HBMTextWidget(
            data: 'Failed transactions',
            color: HBMColors.lightGrey,
          ),
          data: Icon(
            size: context.width * 0.04,
            Icons.arrow_forward_ios_rounded,
            color: HBMColors.lightGrey,
          ),
        ),
        const Divider(color: HBMColors.grey),
        _cardDataRow(
          context: context,
          icon: const Icon(Icons.electric_bike, color: HBMColors.lightGrey),
          title: const HBMTextWidget(
            data: 'Deliveries',
            color: HBMColors.lightGrey,
          ),
          data: Icon(
            size: context.width * 0.04,
            Icons.arrow_forward_ios_rounded,
            color: HBMColors.lightGrey,
          ),
        ),
      ],
    );
  }

  SizedBox _buildCard(BuildContext context, {required List<Widget> children}) {
    return SizedBox(
      width: context.width,
      child: Card(
        margin: EdgeInsets.zero,
        color: HBMColors.mediumGrey,
        child: Padding(
          padding: EdgeInsets.all(context.width * 0.05),
          child: Column(children: children),
        ),
      ),
    );
  }

  Row _cardDataRow({
    required Widget title,
    required Widget data,
    required BuildContext context,
    Widget? icon,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            if (icon != null)
              Padding(
                padding: EdgeInsets.only(right: context.width * 0.02),
                child: icon,
              ),
            title,
          ],
        ),
        data,
      ],
    );
  }
}
