import 'package:flutter/material.dart';

import '../../../core/utilities/enum/request_status.dart';
import '../../../presentation/widgets/shared/retry.dart';
import '../../../presentation/widgets/shared/spinkit_indicator.dart';
import 'empty_list.dart';
import 'not_auth.dart';

class PageBuilder extends StatelessWidget {
  final RequestStatus requestStatus;
  final Function onError;
  final bool isAuth;
  final bool isEmpty;
  final String emptyStateImage;
  final String emptyStateTitle;

  final Widget child;
  const PageBuilder(
      {Key? key,
      this.isAuth = true,
      required this.requestStatus,
      required this.onError,
      this.isEmpty = false,
      this.emptyStateImage = '',
      this.emptyStateTitle = '',
      required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return !isAuth
        ? const NotAuth()
        : isEmpty
            ? EmptyList(
                title: emptyStateTitle,
                image: emptyStateImage,
              )
            : requestStatus == RequestStatus.isLoading
                ? const SpinkitIndicator()
                : requestStatus == RequestStatus.error
                    ? Retry(
                        onPressed: () {
                          onError();
                        },
                      )
                    : child;
  }
}