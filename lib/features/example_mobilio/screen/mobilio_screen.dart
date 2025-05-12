import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import '../controller/mobilio_controller.dart';
import '../domain/models/molibio_resuilt.dart';
import 'mobilio_detail_screen.dart';

class MobilioScreen extends StatefulWidget {
  const MobilioScreen({Key? key}) : super(key: key);

  @override
  MobilioScreenState createState() => MobilioScreenState();
}

class MobilioScreenState extends State<MobilioScreen> {
  TextEditingController _controller = TextEditingController();
  Timer? _debounce;
  ScrollController _scrollController = ScrollController();
  double? position;
  bool isLoadMore = false;
  String mQuery = '';

  @override
  void initState() {
    final controller = Provider.of<MobilioController>(context, listen: false);
    controller.getProducts();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onSearchChanged(String query) {
    setState(() {
      mQuery = query;
    });
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      if (query.isNotEmpty) {
        Provider.of<MobilioController>(context, listen: false).updateSearch(query);
      }else {
        Provider.of<MobilioController>(context, listen: false).updateSearch('');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Container(
          padding: EdgeInsets.only(left: 16),
          height: 35,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: "Find...",
                    hintStyle: TextStyle(fontSize: 14, color: Colors.black26),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                    isDense: true,
                  ),
                  onChanged: _onSearchChanged,
                  style: TextStyle(fontFamily: "Inter", fontSize: 16),
                ),
              ),
              mQuery.isNotEmpty
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          _controller.text = '';
                          mQuery = '';
                        });
                        Provider.of<MobilioController>(context, listen: false)
                            .updateSearch('');
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.clear,
                            color: Colors.black45,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                        ],
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Consumer<MobilioController>(builder: (context, controller, _) {
        return SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              SizedBox(
                height: 16,
              ),
              Column(
                children: controller.filteredMobilios!.map((e) => mobilioItem(e)).toList(),
              ),
            ],
          ),
        );
      }),
    );
    ;
  }

  Widget mobilioItem(MolibioDatum e) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) =>
                    MobilioDetailScreen(e: e)))
            .then((value) {});
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15), // Adjust the radius as needed
          ),
          clipBehavior: Clip.antiAlias,
          elevation: 5.0,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 100,
                  width: 100,
                  child: CachedNetworkImage(
                    imageUrl: e.image,
                    placeholder: (context, url) => Container(
                      color: Colors.transparent,
                      height: 100,
                      width: 100,
                      child: SpinKitFadingCircle(
                        color: Colors.greenAccent,
                        size: 30,
                      ),
                    ),
                    errorWidget: (context, url, error) => new Icon(Icons.error),
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${e.name}',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        '\$${e.price.toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        '${e.detail}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
