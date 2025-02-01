import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:stock/domain/model/company_info.dart';
import 'package:stock/domain/model/intraday_info.dart';

part 'company_info_state.freezed.dart';
part 'company_info_state.g.dart';

@freezed
class CompanyInfoState with _$CompanyInfoState {
  const factory CompanyInfoState({
    CompanyInfo? companyInfo,
    @Default(false) bool isLoading,
    String? errorMessage,
    @Default([]) List<IntradayInfo> intradayInfo,
  }) = _CompanyInfoState;

  factory CompanyInfoState.fromJson(Map<String, Object?> json) =>
      _$CompanyInfoStateFromJson(json);
}
