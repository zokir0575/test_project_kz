
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_task_kz/features/common/widgets/cached_image.dart';
import 'package:test_task_kz/features/navigation/domain/entities/navbar.dart';

class NavItemWidget extends StatefulWidget {
  const NavItemWidget({
    Key? key,
    this.avatar,
    required this.navBar,
    required this.currentIndex,
  }) : super(key: key);

  final int currentIndex;
  final String? avatar;
  final NavBar navBar;

  @override
  State<NavItemWidget> createState() => _NavItemWidgetState();
}

class _NavItemWidgetState extends State<NavItemWidget> {
  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.only(bottom: 4),
        width: double.maxFinite,
        child: Column(
          children: [
            if (widget.avatar == null) ...{
              Center(
                  child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  decoration: widget.currentIndex == widget.navBar.id
                      ? BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.purple .withOpacity(0.6),
                                blurRadius: 40,
                                spreadRadius: 0.5,
                                blurStyle: BlurStyle.normal,
                                offset: const Offset(0, 5))
                          ],
                        )
                      : null,
                  child: SvgPicture.asset(
                    widget.navBar.icon,
                    height: 24,
                    width: 24,
                    color: widget.currentIndex == widget.navBar.id ? Colors.purple : Colors.black,
                  ),
                ),
              )),
            } else ...{
              Container(
                height: 32,
                width: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border:
                      Border.all(color: widget.currentIndex == widget.navBar.id ? Colors.red : Colors.grey, width: 2),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: CachedImage(
                    imageUrl: widget.avatar!,
                  ),
                ),
              ),
            },
            const SizedBox(
              height: 4,
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: Text(widget.navBar.title ,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  style: widget.currentIndex == widget.navBar.id
                      ? Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.purple)
                      : Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w400, color: Colors.black)),
            ),
          ],
        ),
      );
}
