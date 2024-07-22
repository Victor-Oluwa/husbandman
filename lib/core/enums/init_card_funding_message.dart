enum CardFundingAuthTypeEnum {
  pinRequired,
  redirecting,
  addressRequired,
  verify,
}

final Map<String, CardFundingAuthTypeEnum> cardFundingAuthTypeEnumMap = {
  for (var value in CardFundingAuthTypeEnum.values) value.name: value,
};

