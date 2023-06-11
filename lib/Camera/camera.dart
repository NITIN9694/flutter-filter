///pub   camera: ^0.10.0


  late CameraController cameraController;
  late List<CameraDescription> cameras;
  Rx<CameraLensDirection> selectedCamera = CameraLensDirection.back.obs;
  Rx<FlashMode> flashMode = FlashMode.off.obs;

  Future<void> initialize() async {
    cameras = await availableCameras();
    cameraController = CameraController(
      cameras[0], // Select the first available camera
      ResolutionPreset.high,
    );
    await cameraController.initialize();
  }


  Future<void> flipCamera() async {
    final lensDirection = selectedCamera.value;
    CameraLensDirection newDirection;
    if (lensDirection == CameraLensDirection.back) {
      newDirection = CameraLensDirection.front;
    } else {
      newDirection = CameraLensDirection.back;
    }
    selectedCamera.value = newDirection;
    final newCamera = cameras.firstWhere((camera) => camera.lensDirection == newDirection);
    await cameraController.stopImageStream();
    await cameraController.dispose();
    cameraController = CameraController(
      newCamera,
      ResolutionPreset.high,
    );
    await cameraController.initialize();
  }

  Future<void> toggleFlash() async {
    final newFlashMode = flashMode.value == FlashMode.off ? FlashMode.auto : FlashMode.off;
    flashMode.value = newFlashMode;
    await cameraController.setFlashMode(newFlashMode);
  }

  Future<void> takePicture(String filePath) async {
    // Same as before
  }

  @override
  void onClose() {
    cameraController.dispose();
    super.onClose();
  }
