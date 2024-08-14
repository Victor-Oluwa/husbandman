import 'package:equatable/equatable.dart';

class HomeCategoryContent extends Equatable{

const HomeCategoryContent({
    required this.name,
    required this.icon,
  });

const HomeCategoryContent.all():this(
  name: 'General',
  icon: '',
);

const HomeCategoryContent.grain():this(
  name: 'Grains',
  icon: '',
);
const HomeCategoryContent.herbs():this(
  name: 'Herbs',
  icon: '',
);

const HomeCategoryContent.vegetables():this(
  name: 'Vegetables',
  icon: '',
);

const HomeCategoryContent.powdered():this(
  name: 'Powdered',
  icon: '',
);

const HomeCategoryContent.fruits():this(
  name: 'Fruits',
  icon: '',
);

const HomeCategoryContent.tuber():this(
  name: 'Tuber',
  icon: '',
);

const HomeCategoryContent.others():this(
  name: 'Others',
  icon: '',
);

final String name;
final String icon;

  @override
  List<Object?> get props => [name, icon];
}