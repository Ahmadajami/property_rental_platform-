import 'package:airbnb/features/property/controller/paging/paging.dart';
import 'package:airbnb/features/property/controller/property_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TileError extends ConsumerWidget {
  const TileError({
    super.key,
    required this.page,
    required this.indexInPage,
    required this.isLoading,
    required this.error,
  });
  final int page;
  final int indexInPage;
  final bool isLoading;
  final String error;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // * Only show error on the first item of the page
    return indexInPage == 0
        ? Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(error),
          ElevatedButton(
            onPressed: isLoading
                ? null
                : () {
              ref.invalidate(paginatedListProvider(PagingCriteria(page: page)));
              // wait until the page is loaded again
              return ref.read(
              paginatedListProvider(PagingCriteria(page: page)),);
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    )
        : const SizedBox.shrink();
  }
}