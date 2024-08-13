
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class ListAll extends ConsumerStatefulWidget {
  const ListAll({super.key});

  @override
  ConsumerState<ListAll> createState() => _ListAllState();
}

class _ListAllState extends ConsumerState<ListAll> {
  bool _isSearching=false;
  void searchIconOnPress(){
    setState(() {
      _isSearching=!_isSearching;
    });
  }
  /*void _searchOnChange (String value, WidgetRef ref){
    ref.read(searchTextProvider.notifier).update((state) => value);


  }*/


  @override
  Widget build(BuildContext context) {
    return Center(child: Text("All"),);
    /* return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: _isSearching ?
           TextField(
            decoration: const InputDecoration(hintText: 'Propertey Name'),
            onChanged: (value){_searchOnChange(value, ref);},
            autofocus: true,
          )
              : const Text("Find Your Dream House") ,

          actions: _isSearching  ? [Padding(padding: const EdgeInsets.all(8.0), child: IconButton(icon: const Icon(Icons.close) ,onPressed: searchIconOnPress,),
            ),] : [Padding(padding: const EdgeInsets.all(8.0), child: IconButton(icon: const Icon(Icons.search) ,onPressed: searchIconOnPress,),
          ),],
        ),
        body: ref.watch(asyncPropertyProvider).when(
            data: (data) => buildListView(context,data),
            error:(error, stackTrace) => Center(child: Text("error : $error")) ,
            loading:  () => const Center(child: CircularProgressIndicator())
        )
        ,

      ),
    );*/
  }
  /*Widget buildListView(BuildContext context,List<PropertyModel> data) {
    return data.isEmpty ? const Center(child: Text("Sorry Not Found"),):ListView.builder(
          itemCount: data.length,
          itemBuilder: (ctx, index) {
            return buildGestureDetector(context, index, data[index]);
          });
  }
  GestureDetector buildGestureDetector(BuildContext context, int index, PropertyModel data) {
    return GestureDetector(
            onTap: () {
              context.go('/all/details/${data.id}');
            },
            child: SizedBox(
              width: double.infinity,
              height: 180.0,
              child: Card(
                child: Row(children: [
                  Expanded(flex: 1,child: decoratedNetworkImage(data)),
                  const VerticalDivider(width: 10.0),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(data.name,
                            maxLines: 2,
                            style: const TextStyle(
                                fontSize: 18,
                                overflow: TextOverflow.ellipsis),
                            softWrap: true),
                        Text(
                          "price :${data.price.round()}",
                          style: const TextStyle(
                              overflow: TextOverflow.ellipsis),
                          softWrap: true,
                        ),
                        const Divider(),
                        Text(
                            "Description:\n ${data.descriptions}",style: const TextStyle(overflow: TextOverflow.ellipsis),),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
          );
  }
  Widget decoratedNetworkImage( PropertyModel prop ){
    return CachedNetworkImage(
      imageUrl: prop.ImageUrl(),
      imageBuilder: (context, imageProvider) {
        return   ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Container(
            height:double.infinity ,

            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),

                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: imageProvider,
                )),

          ),
        );

      },
      placeholder: (context, url) => const Center(child:  CircularProgressIndicator()),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }*/
}

