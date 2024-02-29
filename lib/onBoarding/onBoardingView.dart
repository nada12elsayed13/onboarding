import 'package:flutter/material.dart';
import 'package:onboarding/onBoarding/color.dart';
import 'package:onboarding/onBoarding/home.dart';
import 'package:onboarding/onBoarding/onBoaringItem.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final controller = OnboardingItems();
  final pageController = PageController();

  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        child: isLastPage? getStarted() : Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

          
            Positioned(
                    top: 50,
                    right: 20,
                    child:TextButton(onPressed: ()=>pageController.jumpToPage(controller.items.length-1),child: const Text("Skip",style: TextStyle(color: Colors.white),),),),
            

          
            
            SmoothPageIndicator(
                controller: pageController,
                count: controller.items.length,
                onDotClicked: (index)=> pageController.animateToPage(index,
                    duration: const Duration(milliseconds: 600), curve: Curves.easeIn),
                effect: const WormEffect(
                  dotHeight: 12,
                  dotWidth: 12,
                  activeDotColor: primaryColor,
                ),
            ),

            // Button
            Positioned(
                    bottom: 60.0,
                    child: OutlinedButton(onPressed: ()=>pageController.nextPage(
                    duration: const Duration(milliseconds: 600), curve: Curves.easeIn), child: Container(
                      padding:const EdgeInsets.all(20.0),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child:const Icon(Icons.arrow_forward_ios),
                    ),
                    style:ElevatedButton.styleFrom(
                      side: const BorderSide(color: Colors.black26),
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(20),
                      onPrimary:Color(0xffffffff),
                    ) ,)),


          ],
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: PageView.builder(
            onPageChanged: (index)=> setState(()=> isLastPage = controller.items.length-1 == index),
            itemCount: controller.items.length,
            controller: pageController,
            itemBuilder: (context,index){
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(controller.items[index].image),
                  const SizedBox(height: 15),
                  Text(controller.items[index].title,
                    style: const TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                  const SizedBox(height: 15),
                  Text(controller.items[index].descriptions,
                      style: const TextStyle(color: Colors.grey,fontSize: 17), textAlign: TextAlign.center),
                ],
              );

        }),
      ),
    );
  }

  

 Widget getStarted(){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: primaryColor
      ),
      width: MediaQuery.of(context).size.width * .9,
      height: 55,
      child: TextButton(
          onPressed: ()async{
            final pres = await SharedPreferences.getInstance();
            pres.setBool("onboarding", true);

            
            if(!mounted)return;
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));
          },
          child: const Text("Get started",style: TextStyle(color: Colors.white),)),
    );
}
}