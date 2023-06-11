

//  google_maps_flutter: ^2.2.2
 // geolocator: ^9.0.0
 // geocoding: ^2.0.5

  var marksData = <MarksData>[].obs;
   GoogleMapController? mapController;

  
  var userLatLng = const LatLng(0.0, 0.0).obs;
  var isMapVisible = false.obs;
  RxSet<Marker> markers = RxSet();
  var polygon = <Polygon>[].obs;
  var polyLine = <Polyline>[].obs;
  var zoomValue = 16.0;
  var isLoading = false.obs;


//Marker Create Funcation
  void onMapCreated(GoogleMapController _cntlr) async {
    mapController = _cntlr;
    isMapVisible.value = true;
  }


  //camera move or position
onCameraMove(CameraPosition newPosition) {
    if (mapController != null) {
      mapController!.animateCamera(CameraUpdate.newLatLng(
          LatLng(newPosition.target.latitude, newPosition.target.longitude)));
      userLatLng.value =
          LatLng(newPosition.target.latitude, newPosition.target.longitude);
    }


//google map marker add function
  markAdd(){
    markers.add(
      Marker(
        markerId: MarkerId('1'),
        position: LatLng(27.588954, 76.617919),
        infoWindow: InfoWindow(
            title: 'title',
            onTap: () {}
            })),);
    
   }


//location permision and current lat long
  Future<void> _getCurrentPosition() async {
    isLoading.value = false;
    final hasPermission = await _handleLocationPermission();
    print(hasPermission);
    if (!hasPermission) {
      return;
    } else {
      print(userLatLng.value);
      await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high)
          .then(
        (Position position) async {
          userLatLng.value = LatLng(position.latitude, position.longitude);
          var address = await getAddressFromLatLong(
              position.latitude, position.longitude);

          /*presentAddressController.text =
              '${address[0].name} ${address[0].subLocality} ${address[0].locality} ${address[0].locality} ${address[0].administrativeArea} ${address[0].postalCode}';
        */
        },
      ).catchError((e) {
        isLoading.value = false;
        debugPrint(e);
      });
    }
  }


//handel exception for location permision
  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print(
              'Location services are disabled. Please enable the services');
      return false;
    }
    permission = await Geolocator.checkPermission();
    print('permission');
    print(permission);
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print( 'Location permissions are denied');
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      print(
              'Location permissions are permanently denied, we cannot request permissions.');
      return false;
    }
    return true;
  }


//google map view 
GoogleMap(
   zoomGesturesEnabled: true,
   zoomControlsEnabled: true,
   indoorViewEnabled: false,
   myLocationEnabled: true,
   myLocationButtonEnabled: false,
   markers: markers,
   initialCameraPosition: CameraPosition(
                      target: controller.userLatLng.value,
                      zoom: controller.zoomValue),
                         mapType: MapType.normal,
                  onMapCreated: controller.onMapCreated,
                  onCameraMove: (cameraPosition) {
                     onCameraMove(cameraPosition);
                  },
                ),
              )),
            ),

  