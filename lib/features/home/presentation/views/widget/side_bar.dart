import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:prepai/Core/Routes/App_Routes.dart';
import 'package:prepai/features/home/presentation/controllers/riverpods/logout_riverpod.dart';
import '../../../../../Core/utils/assets.dart';
import '../../../../../Core/utils/constants.dart';
import 'menu_item.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xff001A3F),
            ),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 21.0),
                  child: CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.white,
                  ),
                ),
                SizedBox(width: 15),
                Text(
                  'User Name',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => context.go(AppRouter.kHomePage),
            child: const MenuItem(
              imagePath: AppAssets.homeIcon,
              title: AppConsts.home,
            ),
          ),
          GestureDetector(
            onTap: () => context.go(AppRouter.kProfile),
            child: MenuItem(
              imagePath: AppAssets.personIcon,
              title: AppConsts.profileHintText,
            ),
          ),
          GestureDetector(
            onTap: () => context.go(AppRouter.kFavourites),
            child: MenuItem(
              imagePath: AppAssets.favouriteIcon,
              title: AppConsts.favorite,
            ),
          ),
          SizedBox(height: 20.0),
          Divider(endIndent: 25, indent: 25),
          SizedBox(height: 20.0),
          Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
            final logoutState = ref.watch(logoutStateProvider);
            final logoutNotifier = ref.read(logoutStateProvider.notifier);
            return GestureDetector(
              onTap: () async {
                await logoutNotifier.logout();
                if (context.mounted && logoutState is! AsyncError) {
                  context
                      .go(AppRouter.kLogin); 
                }
              },
              child: MenuItem(
                imagePath: AppAssets.logoutIcon,
                title: AppConsts.logout,
              ),
            );
          }),
        ],
      ),
    );
  }
}
