import 'package:husbandman/core/enums/update_user.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/auth/domain/entity/user/user_entity.dart';

abstract class ProfileRepo{

  ResultFuture<UserEntity> updateUser({
    required dynamic newData,
    required UpdateUserCulprit culprit,
  });

  
}
