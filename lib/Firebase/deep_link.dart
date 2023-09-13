class DynamicLinkService {
  Future<void> initDynamicLinks() async {
    var dynamicLinks = FirebaseDynamicLinks.instance;
    var isLogin = await PrefManager.getBool(AppConstants.loggedIn);
    await Future.delayed(Duration(seconds: 3));
    var data = await FirebaseDynamicLinks.instance.getInitialLink();
    var deepLink = data?.link;
    print("${deepLink} deeplink");
    if (deepLink != null) {
      final queryParams = deepLink.queryParameters;
      final pathSegments = deepLink.pathSegments;

      //check queryParams and navigate screen
      
    } else {
      if (isLogin) {
       
          Get.offAllNamed(Routes.home, arguments: {'permission': 1});
        
      } else {
        Get.offNamed(Routes.intro, arguments: ["home"]);
      }
    }

    dynamicLinks.onLink.listen((dynamicLink) async {
      var deepLink = dynamicLink.link;
      print('DynamicLinks onLink listener $deepLink');
      if (deepLink != null) {
        final pathSegments = deepLink.pathSegments;
        final queryParams = deepLink.queryParameters;
        print("${deepLink} deeplink");
        if (deepLink != null) {
          final queryParams = deepLink.queryParameters;
          final pathSegments = deepLink.pathSegments;
         //check queryParams and navigate screen

        } else {
      if (isLogin) {
       
          Get.offAllNamed(Routes.home, arguments: {'permission': 1});
        
      } else {
        Get.offNamed(Routes.intro, arguments: ["home"]);
      }
      }
    }, onError: (error) {
      print('DynamicLinks onError $error');
    });
  }
}