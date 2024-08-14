
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:husbandman/core/res/color.dart';
import 'package:husbandman/core/services/injection/product_manager/product_manager_injection.dart';
import 'package:husbandman/src/product_manager/presentation/view/upload_product/product_upload_bloc_consumer_widget.dart';

class UploadProductView extends ConsumerStatefulWidget {
  const UploadProductView({super.key});

  @override
  ConsumerState<UploadProductView> createState() => _UploadProductViewState();
}

class _UploadProductViewState extends ConsumerState<UploadProductView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ref.read(productManagerBlocProvider),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: HBMColors.coolGrey,
        body: ProductUploadBlocConsumerWidget(ref: ref),
      ),
    );
  }
}
