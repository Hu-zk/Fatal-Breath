import 'package:fatal_breath_frontend/providers/house.provider.dart';
import 'package:fatal_breath_frontend/screens/empty/home.empty.state.screen.dart';
import 'package:fatal_breath_frontend/utils/global.colors.dart';
import 'package:fatal_breath_frontend/utils/text.note.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
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
            padding: const EdgeInsets.only(top: 13),
            child: Text(
              "Edit Members",
              style: GoogleFonts.poppins(
                color: GlobalColors.mainColor,
                fontSize: 24,
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
                    SingleChildScrollView(
                        child: Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: Column(children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(20, 20, 20, 5),
                          height: 50,
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search users...',
                              prefixIcon: Icon(
                                Icons.search,
                                color: GlobalColors.mainColor,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                            ),
                            onChanged: (value) {
                              // Handle the search logic here based on the input value (value).
                              // You can filter the list of rooms or perform other search operations.
                            },
                          ),
                        ),
                        if (house.members != null && house.members!.isNotEmpty)
                          for (final member in house.members!)
                            Container(
                              margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
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
                                                member.username +
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
                                              Text(member.name,
                                                  style: GoogleFonts.poppins(
                                                    color: Colors.black,
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w500,
                                                  )),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text("Oxygen : 30%",
                                                  style: GoogleFonts.poppins(
                                                    color: Colors.black,
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w400,
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
                                        borderRadius: BorderRadius.circular(40),
                                        color: member.name == 'Kitchen'
                                            ? Colors.red
                                            : member.name == 'Bedroom'
                                                ? Colors.orange
                                                : Colors.green,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 2,
                                            blurRadius: 5,
                                            offset: const Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: Text(
                                            member.name == 'Kitchen'
                                                ? "Dangerous"
                                                : member.name == 'Bedroom'
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
                            )
                        else
                          const TextNote(text: "No members in this house !")
                      ]),
                    ))
                ],
              ),
      ),
    );
  }
}
