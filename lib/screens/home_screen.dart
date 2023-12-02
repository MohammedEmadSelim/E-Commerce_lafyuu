import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lafyuu_e_commerce/model/category_model.dart';
import 'package:lafyuu_e_commerce/repository/category_repo.dart';
import 'package:lafyuu_e_commerce/screens/favorite_products.dart';
import 'package:lafyuu_e_commerce/widgets/category_item.dart';
import 'package:lafyuu_e_commerce/widgets/category_shimmer.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List viewList = [1, 2, 3, 4, 5];
  int indexForCircls = 0;
  late final Future<CategoryMdel> CategoryLoader;
  @override
  void initState() {
    CategoryLoader = CategoryRepo().getCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        elevation: 0,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          // basic colmn
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //row of Search bar
                  Row(
                    children: [
                      Container(
                          width: 263,
                          height: 46,
                          child: TextFormField(
                            decoration: const InputDecoration(
                                prefixIcon: ImageIcon(
                                  AssetImage('assets/images/Search.png'),
                                  size: 16,
                                ),
                                hintText: ('Search Product'),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xff9098B1),
                                  ),
                                )),
                          )),
                      const SizedBox(
                        width: 16,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Image.asset(
                          'assets/images/love.png',
                          width: 24,
                          height: 24,
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: Image.asset(
                            'assets/images/Notification.png',
                            width: 24,
                            height: 24,
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  // slide show
                  Column(
                    children: [
                      CarouselSlider(
                        options: CarouselOptions(
                          onPageChanged: (index, reason) {
                            indexForCircls = index;
                            setState(() {});
                          },
                          // height: 343.0,
                          autoPlay: true,
                          viewportFraction: .96,
                          autoPlayCurve: Curves.bounceInOut,
                        ),
                        items: viewList.map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                height: 206,
                                width: MediaQuery.of(context).size.width,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Image.asset(
                                  'assets/images/Promotion.png',
                                  fit: BoxFit.fill,
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      // the circles under slide show synchrounis with it
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          viewList.length,
                          (index) => Container(
                            child: Icon(
                              size: 14,
                              Icons.circle,
                              color: index == indexForCircls
                                  ? const Color(0xff40BFFF)
                                  : const Color(0xffEBF0FF),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),

                  const Divider(),
                  // const SizedBox(
                  //   height: 16,
                  // ),
                  // Container(
                  //   width: 343,
                  //   height: 206,
                  //   decoration: const BoxDecoration(
                  //     borderRadius: BorderRadius.all(Radius.circular(5)),
                  //     image: DecorationImage(
                  //       image: AssetImage('assets/images/Promotion.png'),
                  //     ),
                  //   ),
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(left: 24, right: 24),
                  //     child: Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         //will change until 1
                  //         const SizedBox(
                  //           height: 32,
                  //         ),
                  //         const Text(
                  //           "Super Flash Sale 50% Off",
                  //           style: TextStyle(
                  //             fontSize: 24,
                  //             color: Colors.white,
                  //             fontWeight: FontWeight.w700,
                  //           ),
                  //         ),
                  //         const SizedBox(
                  //           height: 29,
                  //         ),
                  //         Image.asset('assets/images/PromotionPriod.png'),
                  //         // 1
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // headline Category and text Button more category

                  //row of text with space between
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Category',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff223263)),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'More Category',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Color(0xff40BFFF)),
                        ),
                      ),
                    ],
                  ),
                  FutureBuilder(
                      future: CategoryLoader,
                      builder: (context, snapshot) {
                        var category = snapshot.data;
                        //making app more advanced loading desgin
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Container(
                            height: 80,
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey.shade100,
                              highlightColor: Colors.transparent,
                              child: Center(
                                child: Row(
                                  children: [
                                    categoryShimmer(),
                                    categoryShimmer(),
                                    categoryShimmer(),
                                    categoryShimmer(),
                                    categoryShimmer(),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }

                        if (snapshot.hasData) {
                          return Container(
                            height: 80,
                            child: ListView.builder(
                              itemCount: category!.data.data.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) => InkWell(
                                onTap: () {
                                  //travel to another favorite screen
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => FavoriteProducts(
                                          categoryId:
                                              category.data.data[index].id,
                                        ),
                                      ));
                                },
                                // creating one category circle
                                child: categoryItem(
                                  category.data.data[index],
                                ),
                              ),
                            ),
                          );
                        } else {
                          return const Center(
                            child: Text('Error'),
                          );
                        }
                      }),
                  const SizedBox(
                    height: 24,
                  ),
                  //row of texts
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Flash Sale',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff223263)),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'See More',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Color(0xff40BFFF)),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  //list of products
                  Container(
                    height: 240,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 6,
                      itemBuilder: ((context, index) {
                        return Container(
                          margin: const EdgeInsets.only(right: 16),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: const Color(0xff9098B1))),
                          padding: const EdgeInsets.all(16),
                          width: 141,
                          height: 238,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset('assets/images/imageProduct.png'),
                              const SizedBox(
                                height: 8,
                              ),
                              const Text(
                                'FS - Nike Air Max 270 React...',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xff223263)),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              //discounded price
                              const Text(
                                '\$299,43',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xff40BFFF)),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              //the text has line in middle horizontal
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Stack(
                                    children: [
                                      Text(
                                        '\$534,33',
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xff9098B1),
                                        ),
                                      ),
                                      Positioned(
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
                                    '24% Off',
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xffFB7181)),
                                  )
                                ],
                              ),

                              const SizedBox(
                                height: 8,
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Mega Sale ',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff223263)),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'See More',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Color(0xff40BFFF)),
                        ),
                      )
                    ],
                  ),
                  // List of product 2
                  Container(
                    height: 240,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 6,
                      itemBuilder: ((context, index) {
                        return Container(
                          margin: const EdgeInsets.only(right: 16),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: const Color(0xff9098B1))),
                          padding: const EdgeInsets.all(16),
                          width: 141,
                          height: 238,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset('assets/images/imageProduct2.png'),
                              const SizedBox(
                                height: 8,
                              ),
                              const Text(
                                'FS - Nike Air Max 270 React...',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xff223263)),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              //discounded price
                              const Text(
                                '\$299,43',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xff40BFFF)),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              //the text has line in middle horizontal
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Stack(
                                    children: [
                                      Text(
                                        '\$534,33',
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xff9098B1),
                                        ),
                                      ),
                                      Positioned(
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
                                    '24% Off',
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xffFB7181)),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                  const SizedBox(
                    height: 9,
                  ),
                  Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Image.asset(
                          'assets/images/image51.png',
                          height: 206,
                          width: 343,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            width: 160,
                            child: const Text(
                              'Recomended Product',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xffFFFFFF)),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 16),
                            child: Text(
                              'We recommend the best for you',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xffFFFFFF)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    // color: Colors.black,
                    width: MediaQuery.of(context).size.width,
                    height: 576,
                    child: AlignedGridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 13,
                      crossAxisSpacing: 12,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: const Color(0xffEBF0FF))),
                          height: 300,
                          width: 165,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/imageProduct.png',
                                height: 133,
                                width: 133,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              const Text(
                                'FS - Nike Air Max 270 React...',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xff223263)),
                              ),
                              const SizedBox(
                                height: 4,
                              ),

                              Container(
                                height: 12,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    if (index >= 4) {
                                      return Image.asset(
                                          'assets/images/S05tar.png');
                                    }
                                    return Image.asset(
                                        'assets/images/S04tar.png');
                                  },
                                  itemCount: 5,
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              //discounded price
                              const Text(
                                '\$299,43',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xff40BFFF)),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              //the text has line in middle horizontal
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Stack(
                                    children: [
                                      Text(
                                        '\$534,33',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xff9098B1),
                                        ),
                                      ),
                                      Positioned(
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
                                    '24% Off',
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xffFB7181)),
                                  )
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
