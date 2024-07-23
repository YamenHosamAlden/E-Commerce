import 'package:ecommerce/Bloc/start_app_bloc/start_app_bloc.dart';
import 'package:ecommerce/Screens/Home/Widgets/app_bar_home_screen.dart';
import 'package:ecommerce/Screens/Home/Widgets/drawer_widget.dart';
import 'package:ecommerce/Screens/Home/Widgets/home_categories_list_widget.dart';
import 'package:ecommerce/Screens/Home/Widgets/list_of_best_rating_widget.dart';
import 'package:ecommerce/Screens/Home/Widgets/list_of_new_products.dart';
import 'package:ecommerce/Screens/Home/Widgets/promotions_slider_widget.dart';
import 'package:ecommerce/Screens/Home/Widgets/search_widget.dart';
import 'package:ecommerce/Widgets/custom_smart_refrecher_header_widget.dart';
import 'package:ecommerce/Widgets/error_message_widget.dart';
import 'package:ecommerce/Widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  late StartAppBloc startAppBloc;
  final RefreshController refreshController = RefreshController();

  @override
  void initState() {
    startAppBloc = BlocProvider.of<StartAppBloc>(context);
    startAppBloc.add(StartAppEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: appBarHomeScreenWidget(
        context,
        scaffoldKey: scaffoldKey,
        title: "Metjary",
      ),
      drawer: const DrawerWidget(),
      body: Column(
        children: [
           SearchWidget(
            homeScreen: true,
          ),
          Expanded(
            child: BlocBuilder<StartAppBloc, StartAppState>(
              builder: (context, state) {
                if (state is StartAppErrorState) {
                  return ErrorMessageWidget(
                    message: state.message,
                    onPressed: () {
                      startAppBloc.add(StartAppEvent());
                    },
                  );
                }
                if (state is StartAppInitial || state is StartAppLoadingState) {
                  return const LoadingWidget();
                }
                return SmartRefresher(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  controller: refreshController,
                  onRefresh: () {
                    startAppBloc.add(StartAppEvent());
                    refreshController.refreshCompleted();
                  },
                  header: const CustomSmartRefrecherHeaderWidget(),
                  child: ListView(
                    children: [
                      HomeCaregoriesListWidget(
                        categories: startAppBloc.startAppModel!.categories!,
                      ),
                      PromotionsSliderWidget(
                        promotion: startAppBloc.startAppModel!.promotion!,
                      ),
                      ListOfBestRatingWidget(
                        bestRating: startAppBloc.startAppModel!.bestRating!,
                      ),
                      ListOfNewProductsWidget(
                        newProducts: startAppBloc.startAppModel!.newProducts!,
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
