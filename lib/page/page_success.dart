import 'package:coffee_shop/page/page_home.dart';
import 'package:flutter/material.dart';

import '../database/db_helper.dart';
import '../model/model_database.dart';

class PageSuccess extends StatefulWidget {
  final String strSize;
  final String strPrice;
  final String strDesc;
  final String strName;
  final String strDate;
  final String strImage;

  const PageSuccess({super.key, required this.strSize,
    required this.strPrice, required this.strDesc,
    required this.strName, required this.strDate, required this.strImage});

  @override
  State<PageSuccess> createState() => _PageSuccessState();
}

class _PageSuccessState extends State<PageSuccess> {
  late DatabaseHelper dbHelper;
  String? strSize;
  String? strPrice;
  String? strDesc;
  String? strName;
  String? strDate;
  String? strImage;

  @override
  void initState() {
    super.initState();
    dbHelper = DatabaseHelper.instance;
    strSize = widget.strSize;
    strPrice = widget.strPrice;
    strDesc = widget.strDesc;
    strName = widget.strName;
    strDate = widget.strDate;
    strImage = widget.strImage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8f8f8),
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 70),
            child: Column(
              children: [
                Image.network(
                  strImage.toString(),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Yay, the order is in progress for delivery ',
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 200,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    height: 55,
                    width: 260,
                    child: ElevatedButton(
                      onPressed: () async {
                        await dbHelper.create(ModelDatabase(
                          nama: strName,
                          size: strSize,
                          ket: strDesc,
                          jml_uang: strPrice,
                          tgl_order: strDate,
                          image_url: strImage
                        ));
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                              return const HomePage();
                            })
                        );
                      },
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
                      child: const Text(
                        'CLOSE',
                        style: TextStyle(fontSize: 20)
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
}
