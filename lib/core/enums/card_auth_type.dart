enum CardFundingValidationTypeEnum {
  otp,
  redirect,
  verify,
}

final Map<String, CardFundingValidationTypeEnum> cardFundingValidationTypeEnumMap ={
  for(var value in CardFundingValidationTypeEnum.values) value.name: value,
};