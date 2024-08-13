

import 'package:airbnb/features/property/controller/paging/paging.dart';
import 'package:airbnb/features/property/controller/property_controller.dart';
import 'package:airbnb/features/property/controller/query.dart';
import 'package:airbnb/features/property/screens/widgets/error_tile.dart';
import 'package:airbnb/features/property/screens/widgets/property_tile.dart';

import 'package:airbnb/features/property/screens/widgets/shimmer_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';





class AllProperty extends ConsumerStatefulWidget {
  const AllProperty({super.key});

  @override
  ConsumerState createState() => _AllPropertyState();
}

class _AllPropertyState extends ConsumerState<AllProperty> {
  final _controller =TextEditingController();
  bool _isSearching=false;
  void searchIconOnPress(){
    ref.read(searchQueryProvider.notifier).setQuery(null);
    setState(() {
      _isSearching=!_isSearching;
    });
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context){
    final query=ref.watch(searchQueryProvider);


    return Scaffold(
      appBar:propertySearchBar() ,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async{
            ref.invalidate(paginatedListProvider);
            // keep showing the progress indicator until the first page is fetched
            try {
              await ref.read(
                paginatedListProvider(const PagingCriteria(page: 1))
                    .future,
              );
            } catch (e) {
              // fail silently as the provider error state is handled inside the ListView
            }
          },
          child: ListView.builder(
            key: ValueKey(query),
            itemBuilder: (context, index) {
              final page = index ~/ 10 + 1;
              final indexInPage = index % 10;
              final responseAsync = ref.watch(paginatedListProvider(PagingCriteria(page: page,perPage: 10)));
              return responseAsync.when(
                error: (err, stack) => TileError( page: page, indexInPage: indexInPage, isLoading: responseAsync.isLoading, error: err.toString()),
                loading: () => const ShimmerTile(),
                data: (properties) {
                  if (indexInPage >= properties.length) {

                    return null;
                  }
                  final property = properties[indexInPage];
                  return PropertyTile(property: property);
                },
              );
            },
          ),
        ),
      ) ,
    );

  }
  AppBar propertySearchBar(){
    return AppBar(
      backgroundColor: Colors.transparent,
      title: _isSearching ?
      TextField(
        controller: _controller,
        decoration: const InputDecoration(hintText: 'Property Name'),
        onChanged: (value){
          ref.read(searchQueryProvider.notifier).setQuery(value);
        },
        autofocus: true,
      )
          : const Text("Find Your Dream House") ,

      actions: _isSearching  ? [Padding(padding: const EdgeInsets.all(8.0), child: IconButton(icon: const Icon(Icons.close) ,onPressed: searchIconOnPress,),
      ),] : [Padding(padding: const EdgeInsets.all(8.0), child: IconButton(icon: const Icon(Icons.search) ,onPressed: searchIconOnPress,),
      ),],
    );
  }

}
