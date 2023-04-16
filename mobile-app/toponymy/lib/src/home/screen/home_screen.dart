import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toponymy/src/navigation/model/app_state_manager.dart';
import 'package:toponymy/src/maps/maps.dart';

class HomeScreen extends StatelessWidget {
  final int currentTab;
  const HomeScreen({Key? key,required this.currentTab}) : super(key: key);

  static MaterialPage page(int currentTab) {
    return MaterialPage(
      child: HomeScreen(currentTab: currentTab),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: _buildAppBar(context),
        preferredSize: AppBar().preferredSize,
      ),
      body: IndexedStack(
        index:currentTab,
        children: [
          MapsScreen(),
          _buildListPlaces(context),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text("Tambah", style: Theme.of(context).textTheme.button,),
        onPressed: () {
        Provider.of<PlacesBloc>(context, listen: false).add(LoadPlaces());
      },),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.only(left: 24, right: 24),
        child: Stack(children: [
          Center(
              child: Text(
            "Toponymy",
            style: Theme.of(context).textTheme.bodyText1,
          ))
        ]),
      ),
    );
  }

  
  static Color skyWhite = const Color.fromRGBO(255, 255, 255, 1);
  Widget _buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentTab,
      type: BottomNavigationBarType.fixed,
      elevation: 1,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      unselectedItemColor: Theme.of(context).colorScheme.outline,
      selectedFontSize: 12.0,
      //selectedItemColor: Theme.of(context).colorScheme.outline,
      onTap: (index) {
        Provider.of<AppStateManager>(context, listen:false).goToTab(index);
      },
      items: const<BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon( 
            Icons.location_on_outlined,
              //color: Theme.of(context).colorScheme.outline,
              size: 24.0,
            ),
            label: "Explore"),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.bookmark_add_outlined,
              //color: Theme.of(context).colorScheme.outline,
            ),
            label: "Saved"),
      ],
    );
  }

  Widget _buildListPlaces(BuildContext context) {
    return const Center(child: Text("Saved Feature"));
  }
}
