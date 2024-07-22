enum FundingStatus {
  successful,
  failed,
  pending,
  none,
}

final Map<String, FundingStatus> fundingStatusMap = {
  for(var status in FundingStatus.values) status.name: status,
};
