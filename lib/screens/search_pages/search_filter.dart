import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:e_commerce/models/search_model.dart';

import 'package:e_commerce/style/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

import '../../controllers/search_page_controller.dart';
import '../../widgets/button.dart';
import '../../widgets/fixed_title_app_bar.dart';
import 'package:get/get.dart';

class FilterSearch extends StatefulWidget {
  FilterSearch({super.key});
  static String id = "/FilterSearch";
  final searchPageinputController c = Get.put(searchPageinputController());

  @override
  State<FilterSearch> createState() => _FilterSearchState();
}

class _FilterSearchState extends State<FilterSearch> {
  final IconData icon = Icons.ac_unit_rounded;
  final List<String> soortby = [
    "Best Match",
    "Time: ending soonest",
    "Time: newly listed",
    "Price + Shipping: lowest first",
    "Price + Shipping: highest first",
    "Distance: nearest first"
  ];
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Unfocuser(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom > 100
                        ? MediaQuery.of(context).viewInsets.bottom + 20
                        : (MediaQuery.of(context).viewInsets.bottom + 80)),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 140),
                      PriceRangeSlider(),
                      wrabBuilder(widget.c.condition),
                      wrabBuilder(widget.c.buyingFormat),
                      wrabBuilder(widget.c.itemLocation),
                      wrabBuilder(widget.c.showOnly),
                    ],
                  ),
                ),
              ),
              const FixedTitleAppBar(
                pageTitle: "Filter Search",
                icon1: Icons.close,
              ),
              Positioned(
                bottom: 15,
                child: Material(
                  child: CustomButon(
                    text: "Apply",
                    onTap: () {
                      Get.back();
                    },
                    width: width - 32,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Column wrabBuilder(SearchPtternns patt) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 24,
        ),
        Text(
          'Price Range',
          style: const MyStyles().headingH5(MyColors.neutralDark),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: patt.searchPatters.map((i) {
            return InkWell(
              onTap: () {
                i.last = !i.last;
                setState(() {});
              },
              child: Container(
                decoration: BoxDecoration(
                    color: i.last
                        ? MyColors.neutralLight
                        : MyColors.backgroundWhite,
                    // color: Color(0xFF40BFFF),
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color:
                          i.last ? Colors.transparent : MyColors.neutralLight,
                    )),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Item ${i.first}',
                    style: i.last
                        ? const MyStyles()
                            .captionLargeBold(MyColors.primaryBlue)
                        : const MyStyles()
                            .captionLargeRegular(MyColors.neutralGrey),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
// var formatter = TextInputFormatter("00");

class PriceRangeSlider extends StatefulWidget {
  PriceRangeSlider({super.key});
  final searchPageinputController c = Get.put(searchPageinputController());

  @override
  State<PriceRangeSlider> createState() => _PriceRangeSliderState();
}

class _PriceRangeSliderState extends State<PriceRangeSlider> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'Price Range',
          style: const MyStyles().headingH5(MyColors.neutralDark),
        ),
        const SizedBox(
          height: 12,
        ),
        Form(
          key: _formKey,
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  inputFormatters: <TextInputFormatter>[widget.c.formatter1],

                  keyboardType: TextInputType.number,
                  textAlignVertical: TextAlignVertical.top,
                  style: const MyStyles().formtextfill(MyColors.neutralGrey),
                  scrollPadding: const EdgeInsets.all(0),
                  // onChanged: onchanged,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(10),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: MyColors.neutralGrey,
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: MyColors.primaryBlue,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(
                        color: MyColors.primaryRed,
                      ),
                    ),
                    errorStyle: const MyStyles().headingH6(MyColors.primaryRed),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(
                        color: MyColors.primaryRed,
                      ),
                    ),
                    // prefixText: "\$",
                    hintText: "Enter Value",
                    hintStyle:
                        const MyStyles().formtextnormal(MyColors.neutralGrey),
                  ),
                  onChanged: (value) {
                    // print(widget.c.formatter1.getUnformattedValue());
                    // print(widget.c.formatter1.getUnformattedValue().runtimeType);
                    var val = widget.c.formatter1.getUnformattedValue();
                    if (val < 0) {
                      widget.c.rangeValueMin = 0;
                    } else if (val > 100000) {
                      widget.c.rangeValueMin = 100000;
                      widget.c.ramgeValueMax = 100000;
                      widget.c.maxcont.text =
                          widget.c.formatter1.format("100000");
                    } else if (val > widget.c.ramgeValueMax) {
                      widget.c.maxcont.text =
                          widget.c.formatter1.format(val.toString());
                      widget.c.ramgeValueMax = val.toDouble();
                      widget.c.rangeValueMin = val.toDouble();
                    } else {
                      widget.c.rangeValueMin = val.toDouble();
                    }

                    setState(() {});
                  },
                  onEditingComplete: () {
                    if (widget.c.formatter1.getUnformattedValue() == 0) {
                      widget.c.mincont.text = widget.c.formatter1.format("0");
                      widget.c.rangeValueMin = 0;
                    } else if (widget.c.formatter1.getUnformattedValue() >=
                        100000) {
                      widget.c.mincont.text =
                          widget.c.formatter1.format("100000");
                      widget.c.rangeValueMin = 100000;
                    }
                    FocusScope.of(context).unfocus();
                  },
                  controller: widget.c.mincont,
                  // focusNode: searchFocus,
                  onFieldSubmitted: (String value) {},
                ),
              ),
              const SizedBox(
                width: 13,
              ),
              Expanded(
                child: TextFormField(
                  keyboardType: TextInputType.number,

                  inputFormatters: [widget.c.formatter2],
                  onChanged: (value) {
                    var val = widget.c.formatter2.getUnformattedValue();
                    if (val < 0) {
                      widget.c.rangeValueMin = 0;
                      widget.c.ramgeValueMax = 0;
                      widget.c.mincont.text = widget.c.formatter2.format("0");
                    } else if (val > 100000) {
                      //  widget.c.maxcont.text = 100000.toString();
                      widget.c.ramgeValueMax = 100000;
                    } else if (val < widget.c.rangeValueMin) {
                      widget.c.mincont.text =
                          widget.c.formatter2.format(val.toString());
                      widget.c.rangeValueMin = val.toDouble();
                      widget.c.ramgeValueMax = val.toDouble();
                    } else {
                      widget.c.ramgeValueMax = val.toDouble();
                    }

                    setState(() {});
                  },
                  textAlignVertical: TextAlignVertical.top,
                  style: const MyStyles().formtextfill(MyColors.neutralGrey),
                  scrollPadding: const EdgeInsets.all(0),
                  // onChanged: onchanged,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(10),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: MyColors.neutralGrey,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(
                        color: MyColors.primaryRed,
                      ),
                    ),
                    errorStyle: const MyStyles().headingH6(MyColors.primaryRed),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(
                        color: MyColors.primaryRed,
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: MyColors.primaryBlue,
                      ),
                    ),
                    hintText: "Enter Value",
                    hintStyle:
                        const MyStyles().formtextnormal(MyColors.neutralGrey),
                  ),
                  onEditingComplete: () {
                    if (widget.c.formatter2.getUnformattedValue() == 0) {
                      widget.c.maxcont.text =
                          widget.c.formatter2.format("100000");
                      widget.c.ramgeValueMax = 100000;
                    } else if (widget.c.formatter2.getUnformattedValue() >=
                        100000) {
                      widget.c.maxcont.text =
                          widget.c.formatter2.format("100000");
                      widget.c.ramgeValueMax = 100000;
                    } else {
                      widget.c.ramgeValueMax =
                          widget.c.formatter2.getUnformattedValue().toDouble();
                    }
                    FocusScope.of(context).unfocus();
                  },
                  controller: widget.c.maxcont,
                  // focusNode: searchFocus,
                  onFieldSubmitted: (String value) {},
                ),
              )
            ],
          ),
        ),
        RangeSlider(
          activeColor: MyColors.primaryBlue,
          inactiveColor: MyColors.neutralLight,
          values: RangeValues(widget.c.rangeValueMin, widget.c.ramgeValueMax),
          max: 100000,
          divisions: 10000,
          labels: RangeLabels(
            widget.c.rangeValueMin.round().toString(),
            widget.c.ramgeValueMax.round().toString(),
          ),
          onChanged: (RangeValues values) {
            setState(() {
              // widget.c.currentRangeValues = values;
              widget.c.rangeValueMin = values.start;
              widget.c.ramgeValueMax = values.end;
              widget.c.mincont.text =
                  widget.c.formatter1.format(values.start.round().toString());
              widget.c.maxcont.text =
                  widget.c.formatter2.format(values.end.round().toString());
            });
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'MIN',
              style: const MyStyles().captionLargeBold(MyColors.neutralGrey),
            ),
            Text('MAX',
                style: const MyStyles().captionLargeBold(MyColors.neutralGrey)),
          ],
        )
      ],
    );
  }
}
