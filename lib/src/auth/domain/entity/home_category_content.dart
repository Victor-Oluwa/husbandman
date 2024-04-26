import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class HomeCategoryContent extends Equatable{

const HomeCategoryContent({
    required this.name,
    required this.icon,
  });

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

const HomeCategoryContent.tools():this(
  name: 'Tools',
  icon: '',
);

final String name;
final String icon;

  @override
  List<Object?> get props => [name, icon];
}