import 'dart:async';

import 'package:coffee_shop/page/page_success.dart';
import 'package:flutter/material.dart';

import '../model/model_list_home.dart';
import '../utils/tools.dart';

StreamController<int> streamController = StreamController<int>.broadcast();

class OrderPage extends StatefulWidget {
  final ModelListHome modelListHome;
  final double dPrice;
  const OrderPage({super.key, required this.modelListHome, required this.dPrice});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {

  List<bool> isSelected = [false, false, false];
  List priceList = [20000, 35000, 45000];
  List menuList = ['Small', 'Medium', 'Large'];
  int? dTotal = 20000;
  double? dPrice;
  String menuName = 'Small';
  bool? checkTG = false;
  ModelListHome? modelListHome;

  @override
  void initState() {
    super.initState();
    modelListHome = widget.modelListHome;
    dPrice = widget.dPrice;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8f8f8),
      appBar: AppBar(
        backgroundColor: const Color(0xfff8f8f8),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
              Icons.arrow_back_ios,
              color: Color(0xff1B100E)
          ),
          onPressed: () => Navigator.pop(context)
        ),
        title: const Text(
          'Coffee Details',
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xff1B100E)
          ),
        ),
      ),
      body: Column(
        children: [
          Center(
            child: Column(
              children: [
                Image.network(
                  modelListHome!.image_url.toString(),
                ),
                Text(
                    modelListHome!.name.toString(),
                    style: const TextStyle(
                        fontSize: 24
                    )
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  modelListHome!.description.toString(),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'SIZE:',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                LayoutBuilder(
                  builder: (context, constraints) =>
                      ToggleButtons(
                        constraints: BoxConstraints.expand(width: constraints.maxWidth / 3.038),
                        isSelected: isSelected,
                        selectedColor: Colors.white,
                        focusColor: const Color(0xff1B100E),
                        fillColor: const Color(0xffA57939),
                        disabledColor: Colors.transparent,
                        selectedBorderColor: const Color(0xffA57939),
                        borderColor: const Color(0xffA57939),
                        borderRadius: BorderRadius.circular(6),
                        children: const [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Text('S', style: TextStyle(fontSize: 18)),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Text('M', style: TextStyle(fontSize: 18)),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Text('L', style: TextStyle(fontSize: 18)),
                          ),
                        ],
                        onPressed: (int newIndex) {
                          setState(() {
                            for (int index = 0; index < isSelected.length; index++) {
                              if (index == newIndex) {
                                isSelected[index] = true;
                                checkTG = true;
                              } else {
                                isSelected[index] = false;
                              }
                            }

                            if (newIndex == 0) {
                              dTotal = priceList[0] + dPrice!.toInt();
                              menuName = menuList[0];
                            } else if (newIndex == 1) {
                              dTotal = priceList[1] + dPrice!.toInt();
                              menuName = menuList[1];
                            } else if (newIndex == 2) {
                              dTotal = priceList[2] + dPrice!.toInt();
                              menuName = menuList[2];
                            }
                          });
                        },
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 35,
          ),
          SizedBox(
            width: 300,
            height: 55,
            child: ElevatedButton(
              style: ButtonStyle(
                  foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
                  backgroundColor: WidgetStateProperty.all<Color>(const Color(0xff1B100E),),
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                          side: const BorderSide(color: Color(0xff1B100E))
                      )
                  )
              ),
              onPressed: () {
                if (checkTG == false) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: Colors.white,
                        ),
                        SizedBox(width: 10),
                        Text('Ups, choose size!',
                            style: TextStyle(
                                color: Colors.white)
                        ),
                      ],
                    ),
                    backgroundColor: Colors.red,
                    shape: StadiumBorder(),
                    behavior: SnackBarBehavior.floating,
                  ));
                }
                else {
                  showModalBottomSheet(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    context: context,
                    builder: (context) {
                      return Container(
                        height: 350,
                        padding: const EdgeInsets.only(
                          top: 20,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  '$menuName ${modelListHome!.name}',
                                  style: const TextStyle(fontSize: 15),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  CurrencyFormat.convertToIdr(dTotal),
                                  style: const TextStyle(fontSize: 15),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Container(
                                width: 315,
                                height: 35,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: const Color(0xFFFFF4EA)),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.money_off,
                                          size: 18,
                                          color: Colors.red,
                                        ),
                                        Text(
                                          ' Free Delivery',
                                          style: TextStyle(fontSize: 12),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.access_time,
                                          size: 18,
                                          color: Colors.red,
                                        ),
                                        Text(
                                          ' 20-30',
                                          style: TextStyle(fontSize: 12),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          size: 18,
                                          color: Colors.red,
                                        ),
                                        Text(
                                          ' 4.8  ',
                                          style: TextStyle(fontSize: 12),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              const Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Description',
                                  )
                              ),
                              Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                      modelListHome!.description.toString()
                                  )
                              ),
                              const SizedBox(
                                height: 28,
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: SizedBox(
                                  width: 300,
                                  height: 55,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                        foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
                                        backgroundColor: WidgetStateProperty.all<Color>(const Color(0xff1B100E),),
                                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(50),
                                                side: const BorderSide(color: Color(0xff1B100E))
                                            )
                                        )
                                    ),
                                    onPressed: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                            return PageSuccess(
                                              strSize: menuName,
                                              strPrice: CurrencyFormat.convertToIdr(dTotal),
                                              strDesc: modelListHome!.description.toString(),
                                              strName: modelListHome!.name.toString(),
                                              strDate: formatDateTime(DateTime.now()),
                                              strImage: modelListHome!.image_url.toString(),
                                            );
                                          })
                                      );
                                    },
                                    child: const Text(
                                      'CHECKOUT',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
              child: const Text(
                'CHECKOUT NOW',
                style: TextStyle(fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}