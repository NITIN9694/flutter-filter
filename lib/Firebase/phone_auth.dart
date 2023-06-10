//pub
//firebase_auth: ^4.2.4
//firebase_core: ^2.4.1

final FirebaseAuth auth = FirebaseAuth.instance;


//fitrbsdr phone auth
signInWithPhoneNumber() async {
  await auth.verifyPhoneNumber(
    phoneNumber: countryCode.value + mobileNumString.value,
    timeout: const Duration(seconds: 30),
    verificationCompleted: (PhoneAuthCredential credential) async {
      try {
        otpFieldController.set(credential.smsCode.toString().split(''));
        isValidOtp();
        if (auth.currentUser == null) {
          await auth.signInWithCredential(credential);
        }
      } on Exception catch (e) {
        \
        handleException(e);
      }
    },
    verificationFailed: (FirebaseAuthException e) {
      
      handleException(e);
    },
    codeSent: (String verificationId, int? resendToken) async {
      
      verifyId.value = verificationId;
      
     print( "verification code sent successfully  $verificationId");

  
      /* Utils.successSnackBar('otp sent');*/
    },
    codeAutoRetrievalTimeout: (String verificationId) {
      
      verifyId.value = verificationId;
      print('codeAutoRetrievalVerificationId:---$verificationId');
    },
  );
}


///resend otp
resendOtp() async {
  auth.verifyPhoneNumber(
    phoneNumber: countryCode.value + mobileNumString.value,
    timeout: const Duration(seconds: 30),
    verificationCompleted: (PhoneAuthCredential credential) async {
      print('completed:---$credential');
      if (auth.currentUser == null) {
        await auth.signInWithCredential(credential);
      }
    },
    verificationFailed: (FirebaseAuthException e) {
      handleException(e);
    },
    codeSent: (String verificationId, int? resendToken) {
      print('codeSentVerificationId:---$verificationId');

      print("OTP Sent");
    },
    codeAutoRetrievalTimeout: (String verificationId) {
      print('codeAutoRetrievalVerificationId:---$verificationId');
    },
  );
}



/*--------Exception Handel-------------*/
void handleException(Exception e) {
  print(e);
  if (e is FirebaseAuthException) {
    switch (e.code) {
      case "invalid-phone-number":
        {
         print ("invalid_phone_number");
          break;
        }
      case "quota-exceeded":
        {
         print("quota_exceeded");

          break;
        }
      case "too-many-requests":
        {
         print("too-many-requests");

          break;
        }
      case "user-disabled":
        {
         print( "user_disabled");
          break;
        }
      case "operation-not-allowed":
        {
         print( "operation_not_allowed");

          break;
        }
      case "network-request-failed":
        {
           print( "network-request-failed");

          break;
        }
      case "invalid-verification-code":
        {
          print("invalid-verification-code");
          break;
        }
      default:
        {
         print( "error_default");
        }
    }
  } else {
   print( "error_default");
  }
}


///check otp is valid or not
isValidOtp() async {
  if (otpNumber.isEmpty && otpNumber.value.length < 6) {
    
   print(message: "please enter min 6 digit otp");
  } else {
    PhoneAuthCredential _credential = PhoneAuthProvider.credential(
        verificationId: verifyId.value, smsCode: otpNumber.value);
    await auth.signInWithCredential(_credential).then((user) async {
    }).catchError((error) {
      print(error);
      handleException(error);
    });
  }
}
