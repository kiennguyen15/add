import 'package:avatar_glow/avatar_glow.dart';
import 'package:connection/ui/SubPageDsHp.dart';
import 'package:connection/ui/SubPageDsLop.dart';
import 'package:connection/ui/SubPageProfile.dart';
import 'package:connection/ui/SubPageTimKiem.dart';
import 'package:connection/ui/SubPageTinTuc.dart';
import 'package:connection/ui/SubpageDangXuat.dart';
import 'package:connection/ui/SubpageDiemDanh.dart';
import 'package:connection/ui/page_login.dart';
import 'package:flutter/material.dart';
import 'package:connection/providers/mainviewmodel.dart';
import 'package:connection/providers/menubarviewmodel.dart';
import 'package:connection/ui/AppConstant.dart';
import 'package:provider/provider.dart';
import 'package:connection/models/profile.dart';

import 'page_dklop.dart';

class PageMain extends StatelessWidget {
  static String routename = '/';
  PageMain({super.key});
  final List<String> menuTitles = [
    "Tin Tức",
    "Profile",
    "Điểm Danh",
    "Tìm Kiếm",
    "Danh Sách Lớp",
    "Danh Sách Học Phần",
    "Đăng xuất"
  ];

  final menuBar = MenuItemlist();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final viewmodel = Provider.of<MainViewModel>(context);
    Profile profile = Profile();
    if (profile.token == "") {
      return PageLogin();
    }
    if (profile.student.mssv == "") {
      return PageDangKyLop();
    }
    Widget body = SubPageTinTuc();
    if (viewmodel.activemenu == SubPageProfile.idpage) {
      body = SubPageProfile();
    } else if (viewmodel.activemenu == SubPageProfile.idpage) {
      body = SubPageProfile();
    } else if (viewmodel.activemenu == SubPageTimKiem.idpage) {
      body = SubPageTimKiem();
    } else if (viewmodel.activemenu == SubPageDiemDanh.idpage) {
      body = SubPageDiemDanh();
    } else if (viewmodel.activemenu == SubPageDsLop.idpage) {
      body = SubPageDsLop();
    } else if (viewmodel.activemenu == SubPageDsHP.idpage) {
      body = SubPageDsHP();
    } else if (viewmodel.activemenu == SubPageDangXuat.idpage) {
      body = SubPageDangXuat();
    }
    menuBar.initialize(menuTitles);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        leading: GestureDetector(
          onTap: () => viewmodel.toggleMenu(),
          child: Icon(
            Icons.menu,
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
          child: Stack(
        children: [
          Consumer<MenuBarViewModel>(
            builder: (context, menuBarModel, child) {
              return Container(
                color: Colors.deepPurple[300],
                child: Center(
                  child: body,
                ),
              );
            },
          ),
          viewmodel.menustaturs == 1
              ? Consumer<MenuBarViewModel>(
                  builder: (context, menuBarModel, child) {
                    return GestureDetector(
                        onPanUpdate: (details) {
                          menuBarModel.setOffset(details.localPosition);
                        },
                        onPanEnd: (details) {
                          menuBarModel.setOffset(Offset(0, 0));
                          viewmodel.closeMenu();
                        },
                        child: Stack(
                          children: [CustomeMenuSizeBar(size: size), menuBar],
                        ));
                  },
                )
              : Container(),
        ],
      )),
    );
  }
}

// "Tin Tức",
//     "Profile",
//     "Điểm Danh",
//     "Danh Sách Lớp",
//     "Danh Sách Học Phần"

class MenuItemlist extends StatelessWidget {
  MenuItemlist({
    super.key,
  });

  final List<MenuBarItem> menuBarItems = [];
  void initialize(List<String> menuTitles) {
    menuBarItems.clear();
    for (int i = 0; i < menuTitles.length; i++) {
      menuBarItems.add(MenuBarItem(
        idpage: i,
        containnerkey: GlobalKey(),
        titles: menuTitles[i],
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          height: size.height * 0.20,
          width: size.width * 0.65,
          child: Center(
            child: AvatarGlow(
              duration: Duration(milliseconds: 2000),
              repeat: true,
              showTwoGlows: true,
              repeatPauseDuration: Duration(microseconds: 100),
              endRadius: size.height * 0.3,
              glowColor: AppConstant.appbarcolor,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(size.height),
                child: SizedBox(
                  height: size.height * 0.16,
                  width: size.width * 0.22,
                  child: Image.network(
                    Profile().user.avatar,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
          height: 2,
          width: size.width * 0.65,
          color: AppConstant.appbarcolor,
        ),
        SizedBox(
          height: 15,
        ),
        SizedBox(
          height: size.height * 0.6,
          width: size.width * 0.65,
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: menuBarItems.length,
              itemBuilder: (content, index) {
                return menuBarItems[index];
              },
            ),
          ),
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class MenuBarItem extends StatelessWidget {
  MenuBarItem({
    super.key,
    required this.titles,
    required this.containnerkey,
    required this.idpage,
  });
  final int idpage;
  final String titles;
  final GlobalKey containnerkey;
  TextStyle style = AppConstant.textbody;

  void onPanmove(Offset offset) {
    if (offset.dy == 0) {
      style = AppConstant.textbody;
    }
    if (containnerkey.currentContext != null) {
      RenderBox box =
          containnerkey.currentContext!.findRenderObject() as RenderBox;
      Offset position = box.localToGlobal(Offset.zero);
      if (offset.dy < position.dy - 40 && offset.dy > position.dy - 80) {
        style = AppConstant.textbodyfocus;
        MainViewModel().activemenu = idpage;
      } else {
        style = AppConstant.textbody;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final menuBarModel = Provider.of<MenuBarViewModel>(context);
    onPanmove(menuBarModel.offset);

    return GestureDetector(
      onTap: () => MainViewModel().setActiveMenu(idpage),
      child: Container(
        key: containnerkey,
        alignment: Alignment.centerLeft,
        height: 40,
        child: Text(
          titles,
          style: style,
        ),
      ),
    );
  }
}

class CustomeMenuSizeBar extends StatelessWidget {
  const CustomeMenuSizeBar({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    final sizeBarModel = Provider.of<MenuBarViewModel>(context);
    final size = MediaQuery.of(context).size;
    return CustomPaint(
      size: Size(size.width * .65, size.height),
      painter: DrawerCustomPaint(offset: sizeBarModel.offset),
    );
  }
}

class DrawerCustomPaint extends CustomPainter {
  final Offset offset;

  DrawerCustomPaint({super.repaint, required this.offset});
  double generatePointX(double width) {
    double kq = 0;
    if (offset.dx == 0) {
      kq = width;
    } else if (offset.dx < width) {
      kq = width + 75;
    } else {
      kq = offset.dx;
    }
    return kq;
  }

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    // path.lineTo(size.width, size.height);
    path.quadraticBezierTo(
        generatePointX(size.width), offset.dy, size.width, size.height);
    path.lineTo(0, size.height);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    // throw UnimplementedError();
    return true;
  }
}
