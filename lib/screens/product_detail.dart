import 'package:flutter/material.dart';
import 'package:lafyuu_e_commerce/model/category_model.dart';
import 'package:lafyuu_e_commerce/model/product_details_model.dart';
import 'package:lafyuu_e_commerce/repository/product_details_repo.dart';
import 'package:lafyuu_e_commerce/widgets/category_shimmer.dart';
import 'package:shimmer/shimmer.dart';

class ProductDetail extends StatefulWidget {
  final int id;
  ProductDetail({super.key, required this.id});

  @override
  State<ProductDetail> createState() => _ProductDetailState(id: id);
}

class _ProductDetailState extends State<ProductDetail> {
  final int id;
  List<double> sizes = [
    6,
    6.5,
    7,
    7.5,
    8,
    8.5,
  ];

  List<Color> colors = [
    Colors.yellow,
    Colors.blue.shade400,
    Colors.red.shade400,
    Colors.green.shade200,
    Colors.indigoAccent,
    Colors.blueAccent.shade400,
  ];
  int? sizeSwitch = 0;
  int? colorSwitch = 0;

  _ProductDetailState({required this.id});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Nike Air Max 270 Rea...',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: false,
        actions: [
          InkWell(
            onTap: () {},
            child: Container(
              height: 24,
              width: 24,
              child: Image.asset('assets/images/Search.png'),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              height: 24,
              width: 24,
              child: Image.asset('assets/images/More.png'),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          // height: MediaQuery.of(context).size.height,
          // width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            //main colmn
            child: FutureBuilder(
                future: ProductDetailsRepo().getProductDetails(id),
                builder: (BuildContext context,
                    AsyncSnapshot<ProductDetailsModel> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Shimmer.fromColors(
                        highlightColor: Colors.transparent,
                        baseColor: Colors.grey.shade200,
                        child: categoryShimmer(),
                      ),
                    );
                  }
                  if (snapshot.hasData) {
                    return Container(
                      height: MediaQuery.of(context).size.height,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network('${snapshot.data!.data.image}'),
                            //under image content
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 270,
                                      child: Text(
                                        snapshot.data!.data.name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 24,
                                      height: 24,
                                      child:
                                          Image.asset('assets/images/love.png'),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  height: 19,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 5,
                                    itemBuilder: (context, index) {
                                      return index == 4
                                          ? Container(
                                              height: 16,
                                              width: 16,
                                              child: Image.asset(
                                                'assets/images/S05tar.png',
                                                fit: BoxFit.fill,
                                              ),
                                            )
                                          : Container(
                                              height: 16,
                                              width: 16,
                                              child: Image.asset(
                                                'assets/images/S04tar.png',
                                                fit: BoxFit.fill,
                                              ),
                                            );
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Text(
                                  '\$${snapshot.data!.data.price}',
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xff40BFFF)),
                                )
                              ],
                            ),
                            const SizedBox(height: 24),
                            const Text(
                              'Select Size',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),

                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  //size of showes
                                  Container(
                                    height: 81,
                                    width: MediaQuery.of(context).size.width,
                                    child: ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      itemCount: sizes.length,
                                      itemBuilder: (context, index) {
                                        return CircleAvatar(
                                          radius: 50,
                                          backgroundColor:
                                              const Color(0xff40BFFF),
                                          child: InkWell(
                                            onTap: () {
                                              sizeSwitch = index;
                                              setState(() {});
                                            },
                                            child: CircleAvatar(
                                              radius:
                                                  index == sizeSwitch ? 38 : 46,
                                              backgroundColor: Colors.white,
                                              child: Text('${sizes[index]}'),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 24),
                            //colors to choose
                            const Text(
                              'Select Color',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 12),

                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Container(
                                child: Row(
                                  children: [
                                    //size of colos
                                    Container(
                                      height: 81,
                                      width: MediaQuery.of(context).size.width,
                                      child: ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        itemCount: sizes.length,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () {
                                              colorSwitch = index;
                                              setState(() {});
                                            },
                                            child: CircleAvatar(
                                              radius: index == colorSwitch
                                                  ? 38
                                                  : 46,
                                              backgroundColor: colors[index],
                                              child: CircleAvatar(
                                                radius: 15,
                                                backgroundColor:
                                                    index == colorSwitch
                                                        ? Colors.white
                                                        : colors[index],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            //shown row
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Shown:',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  textDirection: TextDirection.rtl,
                                  'Laser \nBlue/Anthracite\n/Watermelon/White',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            const SizedBox(height: 19),
                            //row of text style
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Style:',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  textDirection: TextDirection.rtl,
                                  'CD0113-400',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),

                            //describtion
                            const Text(
                              'The Nike Air Max 270 React ENG combines a full-length React foam midsole with a 270 Max Air unit for unrivaled comfort and a striking visual experience.',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 24),

                            //review product
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Review Product',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14),
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
                                ),
                              ],
                            ),

                            Row(
                              children: [
                                // stars feedbach
                                Container(
                                  height: 19,
                                  width: 130,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 5,
                                    itemBuilder: (context, index) {
                                      return index == 4
                                          ? Container(
                                              height: 16,
                                              width: 16,
                                              child: Image.asset(
                                                'assets/images/S05tar.png',
                                                fit: BoxFit.fill,
                                              ),
                                            )
                                          : Container(
                                              height: 16,
                                              width: 16,
                                              child: Image.asset(
                                                'assets/images/S04tar.png',
                                                fit: BoxFit.fill,
                                              ),
                                            );
                                    },
                                  ),
                                ),

                                const Row(
                                  children: [
                                    Text(
                                      '4.5',
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    SizedBox(width: 3),
                                    Text(
                                      '(5 Review)',
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            const SizedBox(
                              height: 20,
                            ),

                            //james laswson
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    height: 48,
                                    width: 48,
                                    child: Image.asset(
                                        'assets/images/ProfilePicture.png')),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'James Lawson',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    // stars feedbach

                                    Container(
                                      height: 19,
                                      width: 130,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: 5,
                                        itemBuilder: (context, index) {
                                          return index == 4
                                              ? Container(
                                                  height: 16,
                                                  width: 16,
                                                  child: Image.asset(
                                                    'assets/images/S05tar.png',
                                                    fit: BoxFit.fill,
                                                  ),
                                                )
                                              : Container(
                                                  height: 16,
                                                  width: 16,
                                                  child: Image.asset(
                                                    'assets/images/S04tar.png',
                                                    fit: BoxFit.fill,
                                                  ),
                                                );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            const Text(
                              'air max are always very comfortable fit, clean and just perfect in every way. just the box was too small and scrunched the sneakers up a little bit, not sure if the box was always this small but the 90s are and will always be one of my favorites.',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(height: 16),
                            //prodcuct images
                            Container(
                              height: 90,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data!.data.images.length,
                                itemBuilder: (context, index) {
                                  return Image.network(
                                    snapshot.data!.data.images[index],
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 16),

                            const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'December 10, 2016',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 23),
                            const Text(
                              'You Might Also Like',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(height: 12),

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
                                        border: Border.all(
                                            color: const Color(0xff9098B1))),
                                    padding: const EdgeInsets.all(16),
                                    width: 141,
                                    height: 238,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Image.asset(
                                            'assets/images/imageProduct.png'),
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
                            Center(
                              child: ElevatedButton(
                                  style: const ButtonStyle(
                                    shape: MaterialStatePropertyAll<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5)))),
                                      backgroundColor: MaterialStatePropertyAll(
                                          Color(0xff40BFFF)),
                                      fixedSize: MaterialStatePropertyAll(
                                          Size(343, 57))),
                                  onPressed: () {},
                                  child: const Text(
                                    'Add To Cart',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return Center(child: Text('Error'));
                }),
          ),
        ),
      ),
    );
  }
}
