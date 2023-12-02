import 'package:flutter/material.dart';
import 'package:lafyuu_e_commerce/model/favorite_model.dart';
import 'package:lafyuu_e_commerce/repository/favorite_repo.dart';
import 'package:lafyuu_e_commerce/screens/product_detail.dart';
import 'package:lafyuu_e_commerce/widgets/category_shimmer.dart';
import 'package:lafyuu_e_commerce/widgets/ctegory_item_card.dart';
import 'package:shimmer/shimmer.dart';

class FavoriteProducts extends StatefulWidget {
  final int categoryId;
  const FavoriteProducts({super.key, required this.categoryId});

  @override
  State<FavoriteProducts> createState() =>
      _FavoriteProductsState(categoryId: categoryId);
}

class _FavoriteProductsState extends State<FavoriteProducts> {
  final int categoryId;

  _FavoriteProductsState({required this.categoryId});

  late final Future<FavoriteCategoryModel> favoriteData;
  @override
  void initState() {
    favoriteData = FavoriteRepo().getFavoriteCategoey(categoryId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        // leading: Icon(Icons.arrow_back_ios_new),
        title: const Text(
          'Favorite Product',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              FutureBuilder(
                future: favoriteData,
                builder: (BuildContext context,
                    AsyncSnapshot<FavoriteCategoryModel> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Expanded(
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey.shade100,
                        highlightColor: Colors.transparent,
                        child: GridView.builder(
                          itemCount: 8,
                          itemBuilder: (context, index) => Container(
                            height: 242,
                            width: 165,
                            color: Colors.grey,
                          ),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisSpacing: 13,
                                  mainAxisSpacing: 13,
                                  crossAxisCount: 2),
                        ),
                      ),
                    );
                  }
                  if (snapshot.hasData) {
                    
                    return Expanded(
                      child: GridView.builder(
                        itemCount: snapshot.data!.data.data.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 13,
                          crossAxisSpacing: 13,
                          crossAxisCount: 2,
                          childAspectRatio: .59,
                        ),
                        itemBuilder: (BuildContext context, int index) =>
                            InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetail(id: snapshot.data!.data.data[index].id),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: const Color(0xff9098B1))),
                            padding: const EdgeInsets.all(16),
                            width: 200,
                            height: 390,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.network(
                                  snapshot.data!.data.data[index].image
                                      .toString(),
                                  width: 133,
                                  height: 133,
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  snapshot.data!.data.data[index].name,
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xff223263)),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                //discounded price
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${snapshot.data!.data.data[index].price}',
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xff40BFFF)),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                //the text has line in middle horizontal
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Stack(
                                      // alignment: Alignment.center,
                                      children: [
                                        Text(
                                          '\$${snapshot.data!.data.data[index].oldPrice}',
                                          style: const TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xff9098B1),
                                          ),
                                        ),
                                        const Positioned(
                                          right: 0,
                                          left: 0,
                                          child: Divider(
                                            color: Color(0xff9098B1),
                                            thickness: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      '${snapshot.data!.data.data[index].discount}% Off',
                                      style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xffFB7181)),
                                    ),
                                    Container(
                                      width: 18,
                                      height: 18,
                                      child: Tab(
                                        icon: Image.asset(
                                          'assets/images/Group.png',
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                  return const Text('Error');
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
