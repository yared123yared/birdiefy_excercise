// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i4;
import 'package:injectable/injectable.dart' as _i2;

import '../preference/user_preference_data.dart' as _i5;
import '../Repository/repository.dart' as _i3;
import '../streams/nearby_course_stream.dart'
    as _i6; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  gh.lazySingleton<_i3.Repository>(
      () => _i3.Repository(httpClient: get<_i4.Client>()));
  gh.lazySingleton<_i5.UserPreferences>(() => _i5.UserPreferences());
  gh.lazySingleton<_i6.NearbyStream>(
      () => _i6.NearbyStream(get<_i3.Repository>()));
  return get;
}
