
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import '../controller/mobilio_controller.dart';
import '../domain/models/molibio_resuilt.dart';

class MobilioDetailScreen extends StatefulWidget {
  MolibioDatum e;

  MobilioDetailScreen({Key? key, required this.e}) : super(key: key);

  @override
  MobilioDetailScreenState createState() => MobilioDetailScreenState();
}

class MobilioDetailScreenState extends State<MobilioDetailScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        leading: const BackButton(
          color: Colors.white,
        ),
        centerTitle: true,
        title: Text(
          'Detail',
          style: TextStyle(fontFamily: 'Inter', fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        actions: [
        ],
      ),
      backgroundColor: Colors.white,
      body: Consumer<MobilioController>(builder: (context, controller, _) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                width: double.infinity,
                child: CachedNetworkImage(
                  imageUrl: widget.e.image,
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
              Text(
                widget.e.name,
                style: TextStyle(fontFamily: 'Inter', fontSize: 24, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                '${widget.e.price}',
                style: TextStyle(fontFamily: 'Inter', fontSize: 16, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 16,),
              Text(
                '${widget.e.detail}',
                style: TextStyle(fontFamily: 'Inter', fontSize: 16, fontWeight: FontWeight.w400),)

            ],
          ),
        );
      }),
    );
  }
}
