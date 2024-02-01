import 'package:flutter/material.dart';
import 'package:untitled2/models/coffeModel.dart';

class CoffeeList extends StatefulWidget {
  const CoffeeList({super.key});

  @override
  State<CoffeeList> createState() => _CoffeeListState();
}

class _CoffeeListState extends State<CoffeeList> {
  final _pageCoffeeController=PageController(
      viewportFraction: 0.4
  );
  double currentPage=0.0;
  void coffeeScrollListener(){
    setState(() {
      currentPage= _pageCoffeeController.page!;
    });
  }
  @override
  void initState(){
    _pageCoffeeController.addListener(coffeeScrollListener);
    super.initState();
  }
  @override
  void dispose(){
    _pageCoffeeController.removeListener(coffeeScrollListener);
    _pageCoffeeController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: -300,
            height: MediaQuery.sizeOf(context).height/1.3,
            child: PageView.builder(
                controller: _pageCoffeeController,
                itemCount: coffees.length+1,
                scrollDirection: Axis.vertical,
                itemBuilder: (context,index){
                  if(index==0){
                    return const SizedBox.shrink();
                  }
                  final coffee=coffees[index-1];
                  final result= currentPage-index +1;
                  final value= -0.45*result+1;
                  final opacity=value.clamp(0.0, 1.0);
                  print(result);
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 100.0),
                    child: Transform(
                        alignment: Alignment.bottomCenter,
                        transform: Matrix4.identity()..setEntry(3, 2, 0.001)..translate(0.0,
                            MediaQuery.of(context).size.height/2.4*(1-value).abs())..scale(value),
                        child: Opacity(
                            opacity: opacity,
                            child: Image.asset(coffee.image,))),
                  );
                }),
          ),
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              height: 100,
              child: Container(color: Colors.red,)),
        ],
      ),
    );
  }
}

