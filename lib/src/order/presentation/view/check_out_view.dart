import 'dart:developer';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:husbandman/core/common/widgets/bread_text_field.dart';
import 'package:husbandman/core/common/widgets/hbm_text_widget.dart';
import 'package:husbandman/core/extensions/context_extension.dart';
import 'package:husbandman/core/res/color.dart';
import 'package:husbandman/core/res/fonts.dart';
import 'package:husbandman/src/auth/domain/entity/user/props/address/address_entity.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

// class CheckOutView extends StatefulWidget {
//   const CheckOutView({super.key});
//
//   @override
//   State<CheckOutView> createState() => _CheckOutViewState();
// }

// class _CheckOutViewState extends State<CheckOutView> {
//   late PageController _controller;
//   late TextEditingController _addressControler;
//
//   @override
//   void initState() {
//     _controller = PageController();
//     _addressControler = TextEditingController();
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: HBMColors.coolGrey,
//       body: SafeArea(
//         child: Stack(
//           children: [
//             PageView(
//               controller: _controller,
//               children: [
//                 CheckOutVie(addressControler: _addressControler),
//                 SizedBox(
//                   height: context.height * 0.60,
//                   width: context.width * 0.80,
//                   child: Card(
//                     elevation: 0,
//                     color: HBMColors.transparent,
//                   ),
//                 ),
//                 SizedBox(
//                   height: context.height * 0.60,
//                   width: context.width * 0.80,
//                   child: Card(
//                     elevation: 0,
//                     color: HBMColors.transparent,
//                   ),
//                 ),
//               ],
//             ),
//             Align(
//               alignment: Alignment.topRight,
//               child: Padding(
//                 padding: EdgeInsets.only(
//                   top: context.height * 0.03,
//                   right: context.width * 0.05,
//                 ),
//                 child: SmoothPageIndicator(
//                   controller: _controller,
//                   count: 3,
//                   onDotClicked: (index) {
//                     _controller.animateToPage(
//                       index,
//                       duration: const Duration(milliseconds: 500),
//                       curve: Curves.easeIn,
//                     );
//                   },
//                   effect: CustomizableEffect(
//                     dotDecoration: DotDecoration(
//                       color: HBMColors.grey,
//                       height: context.height * 0.09,
//                       borderRadius: BorderRadius.circular(context.width * 0.05),
//                     ),
//                     activeDotDecoration: DotDecoration(
//                       color: HBMColors.charcoalGrey,
//                       height: context.height * 0.09,
//                       borderRadius: BorderRadius.circular(
//                         context.width * 0.05,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class CheckOutView extends StatefulWidget {
  const CheckOutView({super.key});

  @override
  State<CheckOutView> createState() => _CheckOutViewState();
}

class _CheckOutViewState extends State<CheckOutView> {
  late TextEditingController _addressController;
  late TextEditingController _cityController;
  late TextEditingController _countryController;
  late TextEditingController _stateController;
  late TextEditingController _zipCodeController;
  late TextEditingController _phoneNumberController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _addressController = TextEditingController();
    _cityController = TextEditingController();
    _countryController = TextEditingController();
    _stateController = TextEditingController();
    _zipCodeController = TextEditingController();
    _phoneNumberController =TextEditingController();
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

    return Scaffold(
      backgroundColor: HBMColors.coolGrey,
      body: SingleChildScrollView(
        child: SafeArea(
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
          HBMTextWidget(
            data: 'Confirm Your ',
            fontFamily: HBMFonts.quicksandBold,
            fontSize: context.width * 0.09,
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
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(context.width * 0.04),
                borderSide: BorderSide(
                  color: HBMColors.mediumGrey,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(context.width * 0.04),
                borderSide: BorderSide(
                  color: HBMColors.mediumGrey,
                ),
              ),
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
            ),
            SizedBox(
              height: context.height * 0.03,
            ),
            BreadTextField(
              fieldController: _cityController,
              cursorColor: HBMColors.charcoalGrey,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(context.width * 0.04),
                borderSide: BorderSide(
                  color: HBMColors.mediumGrey,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(context.width * 0.04),
                borderSide: BorderSide(
                  color: HBMColors.mediumGrey,
                ),
              ),
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
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(context.width * 0.04),
                borderSide: BorderSide(
                  color: HBMColors.mediumGrey,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(context.width * 0.04),
                borderSide: BorderSide(
                  color: HBMColors.mediumGrey,
                ),
              ),
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
            ),
            SizedBox(
              height: context.height * 0.03,
            ),
            BreadTextField(
              fieldController: _zipCodeController,
              cursorColor: HBMColors.charcoalGrey,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(context.width * 0.04),
                borderSide: BorderSide(
                  color: HBMColors.mediumGrey,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(context.width * 0.04),
                borderSide: BorderSide(
                  color: HBMColors.mediumGrey,
                ),
              ),
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
            ),
            SizedBox(
              height: context.height * 0.03,
            ),
            BreadTextField(
              fieldController: _addressController,
              keyboardType: TextInputType.phone,
              cursorColor: HBMColors.charcoalGrey,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(context.width * 0.04),
                borderSide: BorderSide(
                  color: HBMColors.mediumGrey,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(context.width * 0.04),
                borderSide: BorderSide(
                  color: HBMColors.mediumGrey,
                ),
              ),
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
                  padding:
                  EdgeInsets.symmetric(horizontal: context.width * 0.03),
                  child: Row(
                    children: [
                      Icon(Icons.keyboard_arrow_down_rounded,
                        color: HBMColors.grey,),
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
          onPressed: () {},
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
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: HBMColors.mediumGrey,
            fixedSize: Size(
              context.width * 0.50,
              context.height * 0.05,
            ),
          ),
          child: HBMTextWidget(
            color: HBMColors.coolGrey,
            data: 'Proceed',
          ),
        ),
      ],),
    );

  }

  void _selectCountry(BuildContext context, TextEditingController countryController) {
    return showCountryPicker(
        context: context,
        countryListTheme: CountryListThemeData(
          flagSize: context.width * 0.05,
          backgroundColor: HBMColors.coolGrey,
          textStyle: TextStyle(
              fontSize: context.width * 0.04, color: HBMColors.mediumGrey,
              fontFamily: HBMFonts.quicksandNormal
          ),
          bottomSheetHeight: 500,
          // Optional. Country list modal height
          //Optional. Sets the border radius for the bottomsheet.
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
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

