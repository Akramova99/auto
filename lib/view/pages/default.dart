//UI da bosgan javoblani eslab qolish va natija page
//togri bosa ozi otadigan bosin
// if (state is ThemedQuestionLoaded2) {
//   Logger().i("Seen");

//   return DefaultTabController(
//     // Use a UniqueKey to force rebuild when the state changes
//     key: UniqueKey(),
//     length: state.allLessons.data.length,
//     child: Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: Row(
//           children: [
//             GestureDetector(
//               child: const Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 30.0),
//                 child: MakeBox(text: " Testni yakunlash "),
//               ),
//               onTap: () {
//                 Navigator.pop(context);
//               },
//             ),
//             DropdownButtonHideUnderline(
//               child: DropdownButton(
//                 iconSize: 35,
//                 value: myValue,
//                 items: items.map(buildDropdownItem).toList(),
//                 onChanged: (value) => setState(() {
//                   myValue = value!;
//                 }),
//               ),
//             ),
//           ],
//         ),
//         centerTitle: true,
//       ),
//       body: Container(
//         decoration: const BoxDecoration(
//           image: DecorationImage(
//             fit: BoxFit.cover,
//             image: AssetImage("assets/images/img.png"),
//           ),
//         ),
//         child: Stack(
//           children: [
//             BackdropFilter(
//               filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white.withOpacity(0.3),
//                   gradient: const LinearGradient(
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomCenter,
//                     colors: [Colors.white60, Colors.white],
//                   ),
//                 ),
//               ),
//             ),
//             ListView(
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     Container(
//                       margin: const EdgeInsets.only(top: 17),
//                       width: 327,
//                       child: TabBar(
//                         tabAlignment: TabAlignment.start,
//                         dividerColor: Colors.transparent,
//                         indicatorColor: Colors.white,
//                         isScrollable: true,
//                         labelColor: Colors.black,
//                         unselectedLabelColor: Colors.white,
//                         tabs: List<Widget>.generate(
//                           state.allLessons.data.length,
//                           (index) {
//                             return BlocBuilder<TabIndexCubit, TabIndexState>(
//                               builder: (context, state) {
//                                 Logger().d("index $index");

//                                 final isRight = state is TabIndexInitial
//                                     ? state.tabStates[index]
//                                     : null;

//                                 return Tab(
//                                   child: TabElement(
//                                     tabItem: (index + 1).toString(),
//                                     isRight: isRight,
//                                   ),
//                                 );
//                               },
//                             );
//                           },
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 24),
//                     SizedBox(
//                       height: 3000,
//                       child: TabBarView(
//                         children: List<Widget>.generate(
//                           state.allLessons.data.length,
//                           (index) {
//                             return BlocBuilder<ThemedQuestionsCubit,
//                                 ThemedQuestionsState>(
//                               builder: (context, state) {
//                                 Logger().d(state);
//                                 if (state is ThemedQuestionError) {
//                                   Logger().e(state.message);
//                                 }

//                                 if (state is ThemedQuestionLoading) {
//                                   Logger().d("bajarildi");
//                                   return const Column(
//                                     children: [
//                                       SizedBox(height: 50),
//                                       SizedBox(
//                                         height: 40,
//                                         width: 40,
//                                         child: CircularProgressIndicator(
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                     ],
//                                   );
//                                 }

//                                 if (state is ThemedQuestionLoaded2) {
//                                   Logger().i("KO'rindi");
//                                   return Column(
//                                     children: [
//                                       Answers(
//                                         myIndex: index,
//                                         questions: state.allLessons.data,
//                                       ),
//                                     ],
//                                   );
//                                 }

//                                 return const Scaffold(
//                                   body: Center(
//                                     child: Text("Something went wrong"),
//                                   ),
//                                 );
//                               },
//                             );
//                           },
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }


////////////////////   if (state is ThemedQuestionLoaded2) {
        //   return DefaultTabController(
        //     length: state.allLessons.data.length,
        //     child: Scaffold(
        //       appBar: AppBar(
        //         automaticallyImplyLeading: false,
        //         title: Row(
        //           children: [
        //             GestureDetector(
        //               child: const Padding(
        //                 padding: EdgeInsets.symmetric(horizontal: 30.0),
        //                 child: MakeBox(text: "  Testni yakunlash  "),
        //               ),
        //               onTap: () {
        //                 Navigator.pop(context);
        //               },
        //             ),
        //             DropdownButtonHideUnderline(
        //               child: DropdownButton(
        //                   iconSize: 35,
        //                   value: myValue,
        //                   items: items.map(buildDropdownItem).toList(),
        //                   onChanged: (value) => setState(() {
        //                         myValue = value!;
        //                       })),
        //             )
        //           ],
        //         ),
        //         centerTitle: true,
        //       ),
        //       body: Container(
        //         decoration: const BoxDecoration(
        //             image: DecorationImage(
        //                 fit: BoxFit.cover,
        //                 image: AssetImage("assets/images/img.png"))),
        //         child: Stack(
        //           children: [
        //             BackdropFilter(
        //               filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        //               child: Container(
        //                 decoration: BoxDecoration(
        //                   color: Colors.white.withOpacity(0.3),
        //                   gradient: const LinearGradient(
        //                       begin: Alignment.topLeft,
        //                       end: Alignment.bottomCenter,
        //                       colors: [Colors.white60, Colors.white]),
        //                 ),
        //               ),
        //             ),
        //             ListView(
        //               children: [
        //                 Column(
        //                   children: [
        //                     Column(
        //                       crossAxisAlignment: CrossAxisAlignment.stretch,
        //                       children: [
        //                         Container(
        //                             margin: const EdgeInsets.only(
        //                               top: 17,
        //                             ),
        //                             width: 327,
        //                             child: TabBar(
        //                               tabAlignment: TabAlignment.start,
        //                               dividerColor: Colors.transparent,
        //                               indicatorColor: Colors.white,
        //                               isScrollable: true,
        //                               labelColor: Colors.black,
        //                               unselectedLabelColor: Colors.white,
        //                               tabs: List<Widget>.generate(
        //                                   state.allLessons.data.length,
        //                                   (index) {
        //                                 return BlocBuilder<TabIndexCubit,
        //                                     TabIndexState>(
        //                                   builder: (context, state) {
        //                                     Logger().d("index $index");
                                           

        //                                     final isRight =
        //                                         state is TabIndexInitial
        //                                             ? state.tabStates[index]
        //                                             : null;

        //                                     return Tab(
        //                                       child: TabElement(
        //                                         tabItem:(index+1) 
        //                                             .toString(),
        //                                         isRight: isRight,
        //                                       ),
        //                                     );
        //                                   },
        //                                 );
        //                               }),
        //                             )),
        //                         const SizedBox(height: 24),
        //                         SizedBox(
        //                           height: 3000,
        //                           child: TabBarView(
        //                             children: List<Widget>.generate(
        //                                 state.allLessons.data.length, (index) {
        //                               return BlocBuilder<ThemedQuestionsCubit,
        //                                   ThemedQuestionsState>(
        //                                 builder: (context, state) {
        //                                   Logger().d(state);
        //                                   if (state is ThemedQuestionError) {
        //                                     Logger().e(state.message);
        //                                   }

        //                                   if (state is ThemedQuestionLoading) {
        //                                     //  cubit.parsingBiletTest(1);
        //                                     Logger().d(
        //                                         "bajarildi"); // Pass the id (1 in this case)
        //                                     return const Column(
        //                                       children: [
        //                                         SizedBox(height: 50),
        //                                         SizedBox(
        //                                             height: 40,
        //                                             width: 40,
        //                                             child:
        //                                                 CircularProgressIndicator(
        //                                               color: Colors.white,
        //                                             )),
        //                                       ],
        //                                     );
        //                                   }

        //                                   if (state is ThemedQuestionLoaded2) {
        //                                     Logger().i("KO'rindi");
        //                                     return Column(
        //                                       children: [
        //                                         Answers(
        //                                           myIndex: index,
        //                                           questions:
        //                                               state.allLessons.data,
        //                                         )
        //                                       ],
        //                                     );
        //                                   }

        //                                   return const Scaffold(
        //                                     body: Center(
        //                                       child:
        //                                           Text("Something went wrong"),
        //                                     ),
        //                                   );
        //                                 },
        //                               );
        //                             }),
        //                           ),
        //                         )
        //                       ],
        //                     )
        //                   ],
        //                 )
        //               ],
        //             )
        //           ],
        //         ),
        //       ),
        //     ),
        //   );
        // }