import 'package:flutter/material.dart';

import '../model/model_list_home.dart';
import '../page/page_order.dart';
import '../utils/tools.dart';

class FragmentHome extends StatefulWidget {
  const FragmentHome({super.key});

  @override
  State<FragmentHome> createState() => _FragmentHomeState();
}

class _FragmentHomeState extends State<FragmentHome> {
  final List<String> _dynamicChips = ['Popular', 'Recommended', 'New', 'Season Special'];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: Image(
                  image: const AssetImage('assets/banner_coffee.jpg'),
                  width: size.width,
                  height: size.height * 0.25,
                  fit: BoxFit.fill,
                  alignment: Alignment.center,
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.05,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: _dynamicChips.length,
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    width: size.width * 0.03,
                  );
                },
                itemBuilder: (BuildContext context, int index) => Chip(
                  padding: const EdgeInsets.all(10),
                  label: Text(
                    _dynamicChips[index],
                  ),
                  labelStyle: const TextStyle(
                    color: const Color(0xFFFFF4EA),
                  ),
                  backgroundColor: const Color(0xFF493628),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.star_border, color: Color(0xff493628)),
                      SizedBox(width: 4),
                      Text("Popular Items",
                          style: TextStyle(
                              color: Color(0xff493628),
                              fontWeight: FontWeight.bold
                          )
                      )
                    ],
                  ),
                  Text("See All",
                      style: TextStyle(
                          color: Color(0xff493628),
                          fontWeight: FontWeight.bold
                      )
                  )
                ],
              ),
            ),
            FutureBuilder<List<ModelListHome>>(
              future: ModelListHome.getListData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data!.isEmpty) {
                    return SizedBox(
                        width: size.height / 1.3,
                        height: size.width / 1.3,
                        child: const Center(
                            child: Text(
                              "Ups, tidak ada data!",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff1B100E),
                                  fontFamily: 'Chirp'),
                            )
                        )
                    );
                  }
                  else {
                    return SizedBox(
                      height: 340,
                      child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            double dPrice = double.parse(snapshot.data![index]
                                .price.toString()).ceilToDouble();
                            double dRp = 16200; //default 1$ to rupiah
                            double dTotal = dPrice * dRp;
                            return Stack(
                              alignment: Alignment.topLeft,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 10 / 2.0),
                                  child: SizedBox(
                                    width: 180,
                                    height: size.height,
                                    child: Card(
                                      margin: const EdgeInsets.all(10),
                                      clipBehavior: Clip.antiAlias,
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      color: Colors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.all(6),
                                        child: Column(
                                          children: [
                                            Container(
                                                width: size.width * 0.30,
                                                height: 180,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        snapshot.data![index].image_url.toString()
                                                    ),
                                                  ),
                                                )
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(bottom: 10),
                                              child: Text(snapshot.data![index].name.toString(),
                                                  style: const TextStyle(
                                                      color: Color(0xff1B100E),
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.bold
                                                  ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                snapshot.data![index].flavor_profile.toString()
                                                    .replaceAll('[', '').replaceAll(']', ''),
                                                  style: const TextStyle(
                                                      color: Color(0xff1B100E),
                                                      fontSize: 14),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 20),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(CurrencyFormat.convertToIdr(dTotal),
                                                      style: const TextStyle(
                                                          color: Color(0xff1B100E),
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.bold
                                                      )
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(context,
                                                          MaterialPageRoute(
                                                              builder: (context) {
                                                                return OrderPage(
                                                                    modelListHome: snapshot.data![index],
                                                                    dPrice: dTotal);
                                                              })
                                                      );
                                                    },
                                                    child: Container(
                                                        width: 30,
                                                        height: 30,
                                                        decoration:
                                                        const ShapeDecoration(
                                                            shape: CircleBorder(),
                                                            color: Color(0xFF493628)
                                                        ),
                                                        child: const ClipOval(
                                                          child: Icon(Icons.add_outlined,
                                                              color: Color(0xFFFFF4EA)
                                                          ),
                                                        )
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                    width: 50,
                                    height: 50,
                                    decoration:
                                    const ShapeDecoration(shape: CircleBorder(), color: Color(0xFF493628)),
                                    child: const ClipOval(
                                      child: Icon(Icons.favorite_border, color: Color(0xFFFFF4EA)),
                                    )
                                ),
                              ],
                            );
                          }),
                    );
                  }
                }
                else if (snapshot.connectionState == ConnectionState.none) {
                  return SizedBox(
                      width: size.height / 1.3,
                      height: size.width / 1.3,
                      child: Center(child: Text("${snapshot.error}")));
                } else {
                  return SizedBox(
                    width: size.height / 1.3,
                    height: size.width / 1.3,
                    child: const Center(
                      child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Color(0xffdbb166))
                      ),
                    ),
                  );
                }
              },
            ),
            const SizedBox(
                height: 20
            ),
            FutureBuilder<List<ModelListHome>>(
              future: ModelListHome.getListDataAsc(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data!.isEmpty) {
                    return SizedBox(
                        width: size.height / 1.3,
                        height: size.width / 1.3,
                        child: const Center(
                            child: Text(
                              "Ups, tidak ada data!",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff1B100E),
                                  fontFamily: 'Chirp'),
                            )
                        )
                    );
                  }
                  else {
                    return SizedBox(
                      height: 340,
                      child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            double dPrice = double.parse(snapshot.data![index]
                                .price.toString()).ceilToDouble();
                            double dRp = 16200;
                            double dTotal = dPrice * dRp;
                            return Stack(
                              alignment: Alignment.topLeft,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 10 / 2.0),
                                  child: SizedBox(
                                    width: 180,
                                    height: size.height,
                                    child: Card(
                                      margin: const EdgeInsets.all(10),
                                      clipBehavior: Clip.antiAlias,
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      color: Colors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.all(6),
                                        child: Column(
                                          children: [
                                            Container(
                                                width: size.width * 0.30,
                                                height: 180,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        snapshot.data![index].image_url.toString()
                                                    ),
                                                  ),
                                                )
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(bottom: 10),
                                              child: Text(snapshot.data![index].name.toString(),
                                                style: const TextStyle(
                                                    color: Color(0xff1B100E),
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                snapshot.data![index].flavor_profile.toString()
                                                    .replaceAll('[', '').replaceAll(']', ''),
                                                style: const TextStyle(
                                                    color: Color(0xff1B100E),
                                                    fontSize: 14),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 20),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(CurrencyFormat.convertToIdr(dTotal),
                                                      style: const TextStyle(
                                                          color: Color(0xff1B100E),
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.bold
                                                      )
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(context,
                                                          MaterialPageRoute(
                                                              builder: (context) {
                                                                return OrderPage(
                                                                    modelListHome: snapshot.data![index],
                                                                    dPrice: dTotal);
                                                              })
                                                      );
                                                    },
                                                    child: Container(
                                                        width: 30,
                                                        height: 30,
                                                        decoration:
                                                        const ShapeDecoration(
                                                            shape: CircleBorder(),
                                                            color: Color(0xFF493628)),
                                                        child: const ClipOval(
                                                          child: Icon(Icons.add_outlined,
                                                              color: Color(0xFFFFF4EA)
                                                          ),
                                                        )
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                    width: 50,
                                    height: 50,
                                    decoration:
                                    const ShapeDecoration(shape: CircleBorder(), color: Color(0xFF493628)),
                                    child: const ClipOval(
                                      child: Icon(Icons.favorite_border, color: Color(0xFFFFF4EA)),
                                    )
                                ),
                              ],
                            );
                          }),
                    );
                  }
                } else if (snapshot.connectionState == ConnectionState.none) {
                  return SizedBox(
                      width: size.height / 1.3,
                      height: size.width / 1.3,
                      child: Center(child: Text("${snapshot.error}")));
                } else {
                  return SizedBox(
                    width: size.height / 1.3,
                    height: size.width / 1.3,
                    child: const Center(
                      child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Color(0xffdbb166))
                      ),
                    ),
                  );
                }
              },
            ),
            const SizedBox(
                height: 100
            ),
          ],
        ),
      ),
    );
  }
}
