// Flutter SDK
export 'package:flutter/material.dart';
export 'package:flutter/cupertino.dart' hide RefreshCallback;
export 'package:flutter/foundation.dart';
export 'package:flutter/services.dart';
export 'package:flutter_native_splash/flutter_native_splash.dart';

export 'package:easy_localization/easy_localization.dart'
    hide TextDirection, MapExtension;

// Project Core — everything exported through shared.dart (theme, extensions,
// utils, widgets, enums) plus routing and services.
export '../config/app_config.dart';
export '../config/api_endpoints.dart';
export '../routing/app_router.dart';
export '../routing/app_routes.dart';
export '../routing/global_navigator.dart';
export '../routing/app_bindings.dart';
export '../services/services.dart';
export '../shared/shared.dart';

export '../features/auth/presentation/screens/login_screen.dart';
export '../features/auth/presentation/screens/nanny_signup_screen.dart';
export '../features/auth/presentation/screens/parent_signup_screen.dart';
export '../features/auth/presentation/screens/forgot_password_screen.dart';
export '../features/auth/presentation/screens/verify_code_screen.dart';
export '../features/auth/presentation/screens/change_password_screen.dart';
export '../features/auth/presentation/screens/password_success_screen.dart';
export '../features/auth/presentation/screens/membership_agreement_screen.dart';
export '../features/auth/presentation/screens/membership_terms_screen.dart';
export '../features/home/presentation/screens/home_page.dart';
export '../features/splash/presentation/screens/splash_screen.dart';
export '../features/splash/presentation/providers/splash_controller.dart';
export '../features/role_selection/presentation/screens/choosing_screen.dart';
