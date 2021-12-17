import 'package:bufi_remake/core/sharedpreferences/storage_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InfoUser extends StatefulWidget {
  InfoUser({Key? key}) : super(key: key);

  @override
  _InfoUserState createState() => _InfoUserState();
}

class _InfoUserState extends State<InfoUser> {
  String nombre = '';
  String? email = '';
  String? imagen = '';
  @override
  void initState() {
    data();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: ScreenUtil().setWidth(80),
            height: ScreenUtil().setHeight(80),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: CachedNetworkImage(
                imageUrl: '$imagen',
                placeholder: (context, url) => Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/svg/bufi.svg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(24),
          ),
          Text(
            '$nombre',
            style: TextStyle(
              color: Colors.white,
              fontSize: ScreenUtil().setSp(18),
              fontWeight: FontWeight.w600,
              letterSpacing: -0.017,
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(14),
          ),
          Text(
            '$email',
            style: TextStyle(
              color: Colors.white,
              fontSize: ScreenUtil().setSp(14),
              fontWeight: FontWeight.w400,
              letterSpacing: -0.017,
            ),
          ),
        ],
      ),
    );
  }

  void data() async {
    String? nomb = await StorageManager.readData('personName');
    String? surn = await StorageManager.readData('personSurname');
    String? ema = await StorageManager.readData('userEmail');
    String? img = await StorageManager.readData('userImage');
    if (nomb!.length > 0) {
      var nombres = nomb.split(' ');
      print(nombres[0]);
      nombre = '${nombres[0]} $surn';
      email = ema;
      imagen = img;
      setState(() {});
    }
  }
}
