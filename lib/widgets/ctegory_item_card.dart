import 'package:flutter/material.dart';
import 'package:lafyuu_e_commerce/model/category_model.dart';

class CategoryItemCard extends StatelessWidget {
  final List<Datum> listOfProducts;
  const CategoryItemCard({
    super.key, required this.listOfProducts,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: const Color(0xff9098B1))),
      padding: const EdgeInsets.all(16),
      width: 200,
      height: 282,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/imageProduct2.png',
            width: 133,
            height: 133,
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
            height: 8,
          ),
          //discounded price
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                '\$299,43',
                style: TextStyle(
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Stack(
                // alignment: Alignment.center,
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
              const Text(
                '24% Off',
                style: TextStyle(
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
    );

  }
}
