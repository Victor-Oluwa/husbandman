import 'dart:developer';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:husbandman/core/common/app/provider/state_notifier_providers/cart_provider.dart';
import 'package:husbandman/core/common/app/provider/state_notifier_providers/user_provider.dart';
import 'package:husbandman/core/common/widgets/bread_text_field.dart';
import 'package:husbandman/core/common/widgets/hbm_text_widget.dart';
import 'package:husbandman/core/common/widgets/snack_bar.dart';
import 'package:husbandman/core/enums/update_user.dart';
import 'package:husbandman/core/extensions/context_extension.dart';
import 'package:husbandman/core/res/color.dart';
import 'package:husbandman/core/res/fonts.dart';
import 'package:husbandman/core/services/injection/auth/auth_injection.dart';
import 'package:husbandman/core/services/injection/order/order_injection.dart';
import 'package:husbandman/src/auth/domain/entity/user/props/address/address_entity.dart';
import 'package:husbandman/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:husbandman/src/order/domain/entity/order_entity.dart';
import 'package:husbandman/src/order/presentation/bloc/order_bloc.dart';

final orderNameProvider = StateProvider((ref) => '');

class CheckOutView extends ConsumerStatefulWidget {
  const CheckOutView({super.key});

  @override
  ConsumerState<CheckOutView> createState() => _CheckOutViewState();
}

class _CheckOutViewState extends ConsumerState<CheckOutView> {
  late TextEditingController _addressController;
  late TextEditingController _cityController;
  late TextEditingController _countryController;
  late TextEditingController _stateController;
  late TextEditingController _zipCodeController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _orderNameController;

  final _formKey = GlobalKey<FormState>();
  final _orderNameKey = GlobalKey<FormState>();

  @override
  void initState() {
    final user = ref.read(userProvider);
    _addressController = TextEditingController(text: user.address.fullAddress);
    _cityController = TextEditingController(text: user.address.city);
    _countryController = TextEditingController(text: user.address.country);
    _stateController = TextEditingController(text: user.address.state);
    _zipCodeController = TextEditingController(text: user.address.zipCode);
    _orderNameController = TextEditingController();
    _phoneNumberController =
        TextEditingController(text: user.phone.isNotEmpty ? user.phone[0] : '');
    super.initState();
  }

  @override
  void dispose() {
    _addressController.dispose();
    _cityController.dispose();
    _countryController.dispose();
    _stateController.dispose();
    _zipCodeController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ref.read(orderBlocProvider)),
        BlocProvider(create: (context) => ref.read(authBlocProvider)),
      ],
      child: Scaffold(
        backgroundColor: HBMColors.coolGrey,
        body: MultiBlocListener(
          listeners: [
            BlocListener<OrderBloc, OrderState>(
              listener: (context, state) {
                if (state is OrderCreated) {
                  log('Order created');

                  HBMSnackBar.show(context: context, content: 'Order placed');

                  Navigator.pop(context);
                }

                if (state is OrderError) {
                  log('Order error occurred: ${state.message}');
                }
              },
            ),
          ],
          child: SingleChildScrollView(
            child: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is UserUpdated) {
                  showNameOrderDialog(context);
                  log('User updates successfully');
                }

                if (state is AuthError) {
                  log('Failed to save address: $state.message');
                  HBMSnackBar.show(
                    context: context,
                    content: 'oops.. something went wrong',
                  );
                }
              },
              builder: (context, state) {
                return SafeArea(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: context.width * 0.04,
                      top: context.height * 0.04,
                      right: context.width * 0.04,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildHeaderText(context),
                        _buildForm(context),
                        _buildBottomButtons(context),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Align _buildHeaderText(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _zipCodeController.text = '553303';
                _countryController.text = 'Nigeria';
                _stateController.text = 'Lagos';
                _cityController.text = 'Ijeododo';
                _addressController.text = '2, peace street, Ijeododo Lagos.';
                _phoneNumberController.text = '09055729707';
              });
            },
            child: HBMTextWidget(
              data: 'Confirm Your ',
              fontFamily: HBMFonts.quicksandBold,
              fontSize: context.width * 0.09,
            ),
          ),
          HBMTextWidget(
            data: 'Details',
            fontFamily: HBMFonts.quicksandBold,
            fontSize: context.width * 0.09,
          ),
        ],
      ),
    );
  }

  Form _buildForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.only(
          top: context.height * 0.04,
        ),
        child: Column(
          children: [
            BreadTextField(
              fieldController: _addressController,
              cursorColor: HBMColors.charcoalGrey,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              enabledBorder: textFieldBorder(),
              focusedBorder: textFieldBorder(),
              errorBorder: textFieldBorder(color: Colors.red.shade300),
              focusedErrorBorder: textFieldBorder(color: Colors.red.shade300),
              labelText: 'Full address',
              labelStyle: TextStyle(
                fontFamily: HBMFonts.quicksandNormal,
                color: HBMColors.mediumGrey,
              ),
              hintText: 'Address',
              hintStyle: TextStyle(
                fontFamily: HBMFonts.exoLight,
                color: HBMColors.grey,
              ),
              validator: validateTextField,
            ),
            SizedBox(
              height: context.height * 0.03,
            ),
            BreadTextField(
              fieldController: _cityController,
              cursorColor: HBMColors.charcoalGrey,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              enabledBorder: textFieldBorder(),
              focusedBorder: textFieldBorder(),
              errorBorder: textFieldBorder(color: Colors.red.shade300),
              focusedErrorBorder: textFieldBorder(color: Colors.red.shade300),
              hintText: 'City',
              labelText: 'City',
              labelStyle: TextStyle(
                fontFamily: HBMFonts.quicksandNormal,
                color: HBMColors.mediumGrey,
              ),
              hintStyle: TextStyle(
                fontFamily: HBMFonts.exoLight,
                color: HBMColors.grey,
              ),
              validator: validateTextField,
            ),
            SizedBox(
              height: context.height * 0.03,
            ),
            _buildCountrySelector(context),
            SizedBox(
              height: context.height * 0.03,
            ),
            BreadTextField(
              fieldController: _stateController,
              cursorColor: HBMColors.charcoalGrey,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              enabledBorder: textFieldBorder(),
              focusedBorder: textFieldBorder(),
              errorBorder: textFieldBorder(color: Colors.red.shade300),
              focusedErrorBorder: textFieldBorder(color: Colors.red.shade300),
              hintText: 'State',
              labelText: 'State',
              labelStyle: TextStyle(
                fontFamily: HBMFonts.quicksandNormal,
                color: HBMColors.mediumGrey,
              ),
              hintStyle: TextStyle(
                fontFamily: HBMFonts.quicksandNormal,
                color: HBMColors.grey,
              ),
              validator: validateTextField,
            ),
            SizedBox(
              height: context.height * 0.03,
            ),
            BreadTextField(
              fieldController: _zipCodeController,
              cursorColor: HBMColors.charcoalGrey,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              enabledBorder: textFieldBorder(),
              focusedBorder: textFieldBorder(),
              errorBorder: textFieldBorder(color: Colors.red.shade300),
              focusedErrorBorder: textFieldBorder(color: Colors.red.shade300),
              hintText: 'Zipcode',
              labelText: 'Zipcode',
              labelStyle: TextStyle(
                fontFamily: HBMFonts.quicksandNormal,
                color: HBMColors.mediumGrey,
              ),
              hintStyle: TextStyle(
                fontFamily: HBMFonts.quicksandNormal,
                color: HBMColors.grey,
              ),
              validator: validateTextField,
            ),
            SizedBox(
              height: context.height * 0.03,
            ),
            BreadTextField(
              fieldController: _phoneNumberController,
              keyboardType: TextInputType.phone,
              cursorColor: HBMColors.charcoalGrey,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              enabledBorder: textFieldBorder(),
              focusedBorder: textFieldBorder(),
              errorBorder: textFieldBorder(color: Colors.red.shade300),
              focusedErrorBorder: textFieldBorder(color: Colors.red.shade300),
              labelText: 'Phone number',
              labelStyle: TextStyle(
                fontFamily: HBMFonts.quicksandNormal,
                color: HBMColors.mediumGrey,
              ),
              hintText: '09055729707',
              hintStyle: TextStyle(
                fontFamily: HBMFonts.exoLight,
                color: HBMColors.grey,
              ),
              validator: validateTextField,
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector _buildCountrySelector(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _selectCountry(context, _countryController);
      },
      child: SizedBox(
        height: context.height * 0.08,
        width: double.infinity,
        child: Card(
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(context.width * 0.04),
            borderSide: BorderSide(
              color: HBMColors.mediumGrey,
            ),
          ),
          elevation: 0,
          color: HBMColors.transparent,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: context.width * 0.03),
            child: Row(
              children: [
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: HBMColors.grey,
                ),
                SizedBox(
                  width: context.width * 0.05,
                ),
                HBMTextWidget(
                  data: _countryController.text.isEmpty
                      ? 'Select country'
                      : _countryController.text,
                  color: HBMColors.grey,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding _buildBottomButtons(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: context.height * 0.07,
        bottom: context.height * 0.03,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          OutlinedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: HBMColors.transparent),
              fixedSize: Size(
                context.width * 0.30,
                context.height * 0.05,
              ),
            ),
            child: HBMTextWidget(
              data: 'Go back',
              color: HBMColors.mediumGrey,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                updateAddress(context);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: HBMColors.mediumGrey,
              fixedSize: Size(
                context.width * 0.50,
                context.height * 0.05,
              ),
            ),
            child: const HBMTextWidget(
              color: HBMColors.coolGrey,
              data: 'Proceed',
            ),
          ),
        ],
      ),
    );
  }

  void _selectCountry(
    BuildContext context,
    TextEditingController countryController,
  ) {
    return showCountryPicker(
      context: context,
      countryListTheme: CountryListThemeData(
        flagSize: context.width * 0.05,
        backgroundColor: HBMColors.coolGrey,
        textStyle: TextStyle(
          fontSize: context.width * 0.04,
          color: HBMColors.mediumGrey,
          fontFamily: HBMFonts.quicksandNormal,
        ),
        bottomSheetHeight: 500,
        // Optional. Country list modal height
        //Optional. Sets the border radius for the bottomsheet.
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        //Optional. Styles the search field.
        inputDecoration: InputDecoration(
          labelText: 'Search',
          hintText: 'Start typing to search',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: const Color(0xFF8C98A8).withOpacity(0.2),
            ),
          ),
        ),
      ),
      onSelect: (Country country) {
        setState(() {
          _countryController.text = country.displayNameNoCountryCode;
        });
        log('Select country: ${country.name}');
      },
    );
  }

  void showNameOrderDialog(BuildContext context) {
    showDialog<AlertDialog>(
      context: context,
      builder: (_) {
        return AlertDialog(
          titlePadding: applyPadding(
            context: context,
            bottom: 0.04,
            top: 0.02,
          ),
          contentPadding: applyPadding(
            context: context,
            bottom: 0.04,
            left: 0.05,
            right: 0.05,
          ),
          title: Align(
            child: HBMTextWidget(
              data: 'Name Your Order',
              fontSize: context.width * 0.07,
            ),
          ),
          backgroundColor: HBMColors.coolGrey,
          alignment: Alignment.center,
          content: Form(
            autovalidateMode: AutovalidateMode.always,
            key: _orderNameKey,
            child: BreadTextField(
              textStyle: textStyle(HBMColors.mediumGrey),
              cursorColor: HBMColors.mediumGrey,
              fieldController: _orderNameController,
              focusedBorder: textFieldBorder(),
              enabledBorder: textFieldBorder(),
              errorBorder: textFieldBorder(color: Colors.red.shade300),
              focusedErrorBorder: textFieldBorder(color: Colors.red.shade300),
              hintText: 'e.g Christmas shopping',
              hintStyle: textStyle(HBMColors.grey),
              validator: validateTextField,
            ),
          ),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: [
            OutlinedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: HBMTextWidget(
                fontFamily: HBMFonts.quicksandNormal,
                color: HBMColors.mediumGrey,
                data: 'Cancel',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                placeOrder(context);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: HBMColors.mediumGrey),
              child: HBMTextWidget(
                fontFamily: HBMFonts.quicksandNormal,
                color: HBMColors.coolGrey,
                data: 'Place order',
              ),
            ),
          ],
        );
      },
    );
  }

  void updateAddress(BuildContext context) {
    final user = ref.read(userProvider);
    final address = AddressEntity(
      fullAddress: _addressController.text,
      city: _cityController.text,
      state: _stateController.text,
      country: _countryController.text,
      zipCode: _zipCodeController.text,
    );

    context.read<AuthBloc>().add(
          UpdateUserEvent(
            userId: user.id,
            userType: user.userType,
            newData: address,
            culprit: UpdateUserCulprit.address,
          ),
        );
  }

  void placeOrder(BuildContext context) {
    if (!_orderNameKey.currentState!.validate()) {
      HBMSnackBar.show(
          context: context, content: 'You have not typed in a name');
      return;
    }

    final cartItems = ref.read(cartProvider).items;
    final ownerId = ref.read(userProvider).id;

    final order = OrderEntity.fromCart(
      ownerId: ownerId,
      cartItems: cartItems,
      orderName: _orderNameController.text,
    );
    log('Seller name: ${order.orders[0].orderItems[0].sellerName}');
    context.read<OrderBloc>().add(CreateOrderEvent(order));
  }

  EdgeInsets applyPadding({
    required BuildContext context,
    double bottom = 0,
    double top = 0,
    double left = 0,
    double right = 0,
  }) {
    return EdgeInsets.only(
      bottom: context.height * bottom,
      top: context.height * top,
      left: context.width * left,
      right: context.width * right,
    );
  }

  OutlineInputBorder textFieldBorder({Color color = HBMColors.mediumGrey}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(context.width * 0.04),
      borderSide: BorderSide(color: color),
    );
  }

  TextStyle textStyle(Color color) {
    return TextStyle(
      fontSize: context.width * 0.04,
      color: color,
      fontFamily: HBMFonts.quicksandNormal,
    );
  }

  String? validateTextField(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Cannot be empty';
    }

    if (_countryController.text.trim().isEmpty) {
      return 'Select your country';
    }
    return null;
  }

// void _buildPhoneNumberInput(PhoneNumber initialNumber){
//   InternationalPhoneNumberInput(
//     onInputChanged: (PhoneNumber number) {
//       print(number.phoneNumber);
//     },
//     onInputValidated: (bool value) {
//       print(value);
//     },
//     selectorConfig: SelectorConfig(
//       selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
//       useBottomSheetSafeArea: true,
//     ),
//     ignoreBlank: false,
//     autoValidateMode: AutovalidateMode.disabled,
//     selectorTextStyle: TextStyle(color: Colors.black),
//     initialValue: initialNumber,
//     textFieldController: _phoneNumberController,
//     formatInput: true,
//     keyboardType:
//     TextInputType.numberWithOptions(signed: true, decimal: true),
//     inputBorder: OutlineInputBorder(),
//     onSaved: (PhoneNumber number) {
//       print('On Saved: $number');
//     },
//   );
// }
}
