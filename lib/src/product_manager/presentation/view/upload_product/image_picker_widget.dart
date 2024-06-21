import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:husbandman/core/common/app/provider/picked_product_image_provider.dart';
import 'package:husbandman/core/common/app/public_methods/loading/loading_controller.dart';
import 'package:husbandman/core/common/widgets/hbm_text_widget.dart';
import 'package:husbandman/core/extensions/context_extension.dart';
import 'package:husbandman/core/res/color.dart';
import 'package:husbandman/core/utils/constants.dart';
import 'package:husbandman/src/product_manager/presentation/bloc/product_manager_bloc.dart';

class ImagePickerWidget extends StatelessWidget {
  const ImagePickerWidget({required this.ref, super.key});

  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: InkWell(
        onTap: () {
          //Launch the image picker
          context.read<ProductManagerBloc>().add(PickProductImageEvent());
          LoadingIndicatorController.instance.show();
        },
        child: SizedBox(
          height: context.height * 0.20,
          width: double.maxFinite,
          child: Card(
            color: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kCardRadius),
              side: BorderSide(color: HBMColors.mediumGrey, width: 3),
            ),
            elevation: 0,
            //Checks if the image path has been picked from the device
            // ..if yes it is loaded as the place holder
            child: ref.watch(pickedProductImageProvider) != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.file(
                      File(ref.watch(pickedProductImageProvider)![0]),
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_a_photo, color: HBMColors.mediumGrey),
                      HBMTextWidget(
                        data: 'Tap to add image',
                        color: HBMColors.mediumGrey,
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
