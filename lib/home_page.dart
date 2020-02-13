import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:fdap/api/apiCall.dart';
import 'package:fdap/wig/foodWidget.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  final _containers = UnmodifiableListView<Widget>([
    TheFoodMenuPage(),
    Container(child: Center(child: Text('Wishlist',
    style: TextStyle(
      fontSize: 35,
      color: Colors.grey,
      fontWeight: FontWeight.w600
    ),
    ))),
  ]);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _containers.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          bottom: TabBar(
              indicatorColor: Colors.transparent,
              labelColor: Colors.pinkAccent,
              isScrollable: true,
              labelPadding: EdgeInsets.only(right: 45.0),
              unselectedLabelColor: Colors.grey,
            tabs: <Widget>[
              Tab(child: Text('Your Menu',
                  style: TextStyle(
                    fontSize: 20
                  ),
                  )),
              Tab(child: Text('Wishlist',
                  style: TextStyle(
                    fontSize: 20
                  ),
                  )),
            ],
          ),
           elevation: 0.0,
          leading: IconButton(icon: Icon(Icons.arrow_back),color: Color(0xFF545D68), onPressed: (){}),
          title: Text('UNI Reso Cafe', style: TextStyle(
            fontFamily: 'Varela',fontSize: 20.0,color: Color(0xFF545D68)
          ),),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.shopping_cart),color: Color(0xFF545D68), onPressed: (){}),
          ],
        ),
        body: TabBarView(
          children: _containers,
        ),
      ),
    );
  }
}

class TheFoodMenuPage extends StatefulWidget {
  @override
  _TheFoodMenuPageState createState() => _TheFoodMenuPageState();
}

class _TheFoodMenuPageState extends State<TheFoodMenuPage> {
  Future<List<DishMenu>> _dishMenuList;

  @override
  void initState() {
    _dishMenuList = _fetchDishMenuList();
    super.initState();
  }

  Future<List<DishMenu>> _fetchDishMenuList() async {
    return MyFoodService().load(DishMenu.all);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<DishMenu>>(
      future: _dishMenuList,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return _theLoader();
        else if (snapshot.hasError)
          return _buildError(snapshot.error.toString());
        else
          return _myFoodMenuList(snapshot.data);
      },
    );
  }

  Widget _theLoader() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildError(String err) {
    return Center(
      child: Text("$err",
      style: TextStyle(
       color: Colors.grey,
       fontWeight: FontWeight.bold,
      ),
      ),
    );
  }

  Widget _myFoodMenuList(List<DishMenu> menuList) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GridView.builder(
          itemCount: menuList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemBuilder: (context, index) {
            return _myFoodMenu(menuList[index]);
          },
        );
      },
    );
  }

  Widget _myFoodMenu(DishMenu dishMenu) {
    return  Container(
        padding: EdgeInsets.fromLTRB(10, 10, 1, 1),
                      height: 200,
                      width: double.maxFinite,
     child: GridTile(

          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8)
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () {
              Navigator.push(context,
                MaterialPageRoute(
                  builder: (context) => FoodListPage(
                    foodList: dishMenu.categoryDishes,
                    category: dishMenu.menuCategory,
                  ),
                ),
              );
            },
            child: Container(
              child: Center( child:Text(dishMenu.menuCategory,
              style: const TextStyle(
                fontSize: 15.0,
                color: Color(0xFF545D68),
                fontWeight: FontWeight.w600
              ),))
            ),
            )
          )
          
        ),);
  }
}
