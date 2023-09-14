import 'package:fatal_breath_frontend/providers/house.provider.dart';
import 'package:fatal_breath_frontend/screens/empty/home.empty.state.screen.dart';
import 'package:fatal_breath_frontend/screens/empty/house.empty.state.screen.dart';
import 'package:fatal_breath_frontend/screens/home/add.house.screen.dart';
import 'package:fatal_breath_frontend/utils/global.colors.dart';
import 'package:fatal_breath_frontend/utils/text.title.dart';
import 'package:fatal_breath_frontend/widgets/button.global.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      length: houses!.isEmpty ? 0 : houses!.length + 1,
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
                    margin: const EdgeInsets.only(left: 10, right: 10),
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
                      unselectedLabelColor: Colors.grey[500],
                      tabs: [
                        for (final house in houses!)
                          Tab(
                            text: house.name,
                          ),
                        const Tab(
                          // icon: Icon(Icons.add),
                          text: "Add house",
                        )
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
                    house.rooms != null && house.rooms!.isNotEmpty
                        ? SingleChildScrollView(
                            child: Padding(
                            padding: const EdgeInsets.only(bottom: 30),
                            child: Column(children: [
                              Container(
                                margin:
                                    const EdgeInsets.fromLTRB(20, 20, 20, 5),
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            const SizedBox(
                                                width: 60,
                                                child: Icon(
                                                  Icons.add_circle_outline,
                                                  size: 40,
                                                )
                                                // Image.asset(
                                                //   'assets/images/light_icon.png',
                                                //   scale: 1.2,
                                                // ),
                                                ),
                                            Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Text("Add Room",
                                                  style: GoogleFonts.poppins(
                                                    color: Colors.black,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w500,
                                                  )),
                                            ),
                                          ],
                                        )
                                      ]),
                                ),
                              ),
                              for (final room in house.rooms!)
                                Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(20, 20, 20, 0),
                                  height: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 60,
                                              child: Image.asset(
                                                // ignore: prefer_interpolation_to_compose_strings
                                                'assets/images/' +
                                                    room.type +
                                                    '.png',
                                                scale: 1.2,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(room.name,
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color: Colors.black,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      )),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text("Oxygen : 30%",
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color: Colors.black,
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ))
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          height: 25,
                                          width: 70,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(40),
                                            color: room.type == 'Kitchen'
                                                ? Colors.red
                                                : room.type == 'Bedroom'
                                                    ? Colors.orange
                                                    : Colors.green,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                spreadRadius: 2,
                                                blurRadius: 5,
                                                offset: const Offset(0, 3),
                                              ),
                                            ],
                                          ),
                                          child: Center(
                                            child: Text(
                                                room.type == 'Kitchen'
                                                    ? "Dangerous"
                                                    : room.type == 'Bedroom'
                                                        ? "Sensetive"
                                                        : "Normal",
                                                style: GoogleFonts.poppins(
                                                  color: Colors.white,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500,
                                                )),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              // Padding(
                              //   padding: const EdgeInsets.symmetric(
                              //       horizontal: 40, vertical: 20),
                              //   child: ButtonGlobal(
                              //       icon: Icons.add,
                              //       bgColor: GlobalColors.mainColor,
                              //       textColor: Colors.white,
                              //       onBtnPressed: () {
                              //         Get.to(
                              //             () => AddRoomScreen(houseId: house.id));
                              //       }),
                              // ),
                            ]),
                          ))
                        : HouseEmptyStateScreen(
                            houseId: house.id,
                          ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const TextTitle(text: "Add House"),
                          const SizedBox(height: 20),
                          ButtonGlobal(
                            bgColor: GlobalColors.mainColor,
                            textColor: Colors.white,
                            icon: Icons.add,
                            onBtnPressed: () {
                              Get.to(() => const AddHouseScreen());
                            },
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
