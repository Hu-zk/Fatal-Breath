import 'package:fatal_breath_frontend/providers/house.provider.dart';
import 'package:fatal_breath_frontend/screens/empty/home.empty.state.screen.dart';
import 'package:fatal_breath_frontend/utils/global.colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List? houses;

  @override
  void initState() {
    super.initState();
    Provider.of<HouseProvider>(context, listen: false).getAdminHouses();
  }

  @override
  Widget build(BuildContext context) {
    houses = Provider.of<HouseProvider>(context).getHouses ?? [];
    return DefaultTabController(
      length: houses!.isEmpty ? 0 : houses!.length,
      child: Scaffold(
        backgroundColor: GlobalColors.bgColor,
        appBar: AppBar(
          backgroundColor: GlobalColors.bgColor,
          elevation: 0,
          centerTitle: true,
          leadingWidth: 65,
          toolbarHeight: 80,
          leading: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Image.asset(
              'assets/images/light_icon.png',
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              "Home",
              style: GoogleFonts.poppins(
                color: GlobalColors.mainColor,
                fontSize: 26,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          bottom: houses!.isEmpty
              ? null
              : PreferredSize(
                  preferredSize: const Size.fromHeight(70),
                  child: Container(
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: GlobalColors.mainColor,
                    ),
                    child: TabBar(
                      isScrollable: true,
                      indicator: null,
                      indicatorColor: Colors.transparent,
                      physics: const BouncingScrollPhysics(),
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.grey[400],
                      tabs: [
                        for (final house in houses!)
                          Tab(
                            text: house.name,
                          ),
                      ],
                    ),
                  ),
                ),
        ),
        body: houses!.isEmpty
            ? const HomeEmptyStateScreen()
            : TabBarView(
                physics: const BouncingScrollPhysics(),
                children: [
                  for (final house in houses!)
                    Center(
                      child: Text('Content for ${house.name} Goes Here'),
                    ),
                ],
              ),
      ),
    );
  }
}
