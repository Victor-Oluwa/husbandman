// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:husbandman/core/res/media_res.dart';

class PageContent extends Equatable {
  final String image;
  final String title;
  final String description;
  final String buttonText;
  const PageContent({
    required this.image,
    required this.title,
    required this.description,
    required this.buttonText,
  });

  const PageContent.first()
      : this(
          buttonText: 'Next',
          description: 'kindly provide the info listed in the description so '
              ' I can proceed with the sitloshy catalog items '
              ' upload catalog items upload.',
          image: MediaRes.onboardingProduct,
          title: 'QUALITY FARM PRODUCE',
        );

  const PageContent.second()
      : this(
          buttonText: 'Next',
          description: 'kindly provide the info listed in the description so '
              ' I can proceed with the sitloshy catalog items '
              ' upload catalog items upload.',
          image: MediaRes.onboardingFarmer,
          title: 'CHAT WITH FARMERS',
        );

  const PageContent.third()
      : this(
          buttonText: 'GET STARTED',
          description: 'kindly provide the info listed in the description so '
              ' I can proceed with the sitloshy catalog items '
              ' upload catalog items upload.',
          image: MediaRes.onboardingDeliveryGuy,
          title: 'HOME DELIVERY',
        );

  @override
  List<Object?> get props => [image, title, description, buttonText];
}
