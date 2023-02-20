class SearchPtternns {
  List<List> searchPatters;

  SearchPtternns({
    required this.searchPatters,
  });

  factory SearchPtternns.fromJson(List jsondata) {
    // var mapp = jsondata.values.toList();
    var mylist = jsondata.map((e) => [e, false]).toList();

    return SearchPtternns(searchPatters: mylist);
  }
}

class SearchPatternsUsed {
  static List condition = ["New", "Used", "Not Specified"];
  static List buyingFormat = [
    "All Listings",
    "Accepts Offers",
    "Auction",
    "Buy It Now",
    "Classified",
  ];
  static List itemLocation = ["US Only", "North America", "Europe", "Asia"];
  static List showOnly = [
    "Free Returns",
    "Returns Accepted",
    "Authorized Seller",
    "Completed Items",
    "Sold Items",
    "Deals & Savings",
    "Sale Items",
    "Listed as Lots",
    "Search in Description",
    "Benefits charity",
    "Authenticity Verified"
  ];
}
