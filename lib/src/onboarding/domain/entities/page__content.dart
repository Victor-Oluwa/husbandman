// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:husbandman/core/res/media_res.dart';

class PageContent extends Equatable {
  final String image;
  final String title;
  final String description;
  final String buttonText;
  final String? accessory;

  const PageContent({
    required this.image,
    required this.title,
    required this.description,
    required this.buttonText,
    this.accessory,
  });

  const PageContent.first()
      : this(
          buttonText: 'Next',
          description: 'kindly provide the info listed in the description so '
              ' I can proceed with the callosity catalog items '
              ' upload catalog items upload.',
          image: MediaRes.produceBasket,
          title: 'QUALITY  PRODUCE',
        );

  const PageContent.second()
      : this(
          buttonText: 'Next',
          description: 'kindly provide the info listed in the description so '
              ' I can proceed with the callosity catalog items '
              ' upload catalog items upload.',
          image: MediaRes.deliveryBus,
          title: 'SAFE DELIVERY',
        );

  const PageContent.third()
      : this(
          buttonText: 'Sign Up',
          description: 'kindly provide the info listed in the description so '
              ' I can proceed with the callosity catalog items '
              ' upload catalog items upload.',
          image: MediaRes.africaElephant,
          accessory: MediaRes.africaMap,
          title: 'PROUDLY AFRICA',
        );

  @override
  List<Object?> get props => [image, title, description, buttonText];
}
