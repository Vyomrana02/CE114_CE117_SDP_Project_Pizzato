import 'package:ce114_ce117_sdp_project/Decider.dart';
import 'package:ce114_ce117_sdp_project/Provider/Authentication.dart';
import 'package:ce114_ce117_sdp_project/Views/Homepage.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class Login extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Colors.white24),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [
                    0.2,
                    0.45,
                    0.6,
                    0.9
                  ],
                      colors: [
                    Color(0xff200B4B),
                    Color(0xff201F22),
                    Color(0xff1A1031),
                    Color(0xff19181F),
                  ])),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 600,
              child: Lottie.asset('animation/chef.json'),
            ),
            Positioned(
              top: 420.0,
              left: 10.0,
              child: SizedBox(
                height: 200,
                width: 200,
                child: RichText(
                  text: const TextSpan(
                      text: 'Pizzato\n',
                      style: TextStyle(
                          color: Colors.greenAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 46.0),
                      children: [
                        TextSpan(
                          text: 'At Your\n',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 40.0),
                        ),
                        TextSpan(
                          text: 'Service',
                          style: TextStyle(
                              color: Colors.redAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 40.0),
                        ),
                      ]),
                ),
              ),
            ),
            Positioned(
              top: 600,
              left: 20,
              child: SizedBox(
                //width: 400,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        loginSheet(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 23, vertical: 12),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        width: 100,
                        height: 50,
                        child: const Text(
                          'Login',
                          style: TextStyle(
                              color: Colors.greenAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        signInSheet(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 23, vertical: 12),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        width: 100,
                        height: 50,
                        child: const Text(
                          'SignIn',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 19.0),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            PageTransition(
                                child: Decider(),
                                type: PageTransitionType.leftToRightWithFade));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 23, vertical: 12),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        width: 100,
                        height: 50,
                        child: const Text(
                          'Home',
                          style: TextStyle(
                              color: Colors.redAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 820.0,
              left: 20.0,
              right: 20.0,
              child: Container(
                width: 400.0,
                constraints: const BoxConstraints(maxHeight: 200),
                child: Column(
                  children: const [
                    Text(
                      "By continuing you agree Pizzato's Terms of",
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    Text(
                      "Services & Privacy Policy",
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  loginSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: Container(
              height: 500,
              width: 400,
              decoration: BoxDecoration(
                  color: const Color(0xFF191531),
                  borderRadius: BorderRadius.circular(30)),
              child: Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        decoration: const InputDecoration(
                            hintText: 'Enter email',
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        controller: emailController,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        obscureText: true,
                        decoration: const InputDecoration(
                            hintText: 'Enter password',
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        controller: passwordController,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MaterialButton(
                        color: Colors.lightGreenAccent,
                        child: const Text(
                          'Login',
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () => Provider.of<Authentication>(context,
                                listen: false)
                            .loginIntoAccount(
                                emailController.text, passwordController.text)
                            .whenComplete(() {
                          if (Provider.of<Authentication>(context,
                                      listen: false)
                                  .getErrorMessage ==
                              '') {
                            Navigator.pushReplacement(
                                context,
                                PageTransition(
                                    child: uid == null ? Login() : HomeScreen(),
                                    type: PageTransitionType.leftToRight));
                          }
                          if (Provider.of<Authentication>(context,
                                      listen: false)
                                  .getErrorMessage !=
                              '') {
                            Navigator.pushReplacement(
                                context,
                                PageTransition(
                                    child: Login(),
                                    type: PageTransitionType.leftToRight));
                            errorMessage = '';
                          }
                        }),
                      ),
                    ),
                    Text(
                      Provider.of<Authentication>(context, listen: false)
                          .getErrorMessage,
                      style: const TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  signInSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: Container(
              height: 500,
              width: 400,
              decoration: BoxDecoration(
                  color: const Color(0xFF191531),
                  borderRadius: BorderRadius.circular(30)),
              child: Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        decoration: const InputDecoration(
                            hintText: 'Enter email',
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        controller: emailController,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        obscureText: true,
                        decoration: const InputDecoration(
                            hintText: 'Enter password',
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        controller: passwordController,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MaterialButton(
                        color: Colors.lightGreenAccent,
                        child: const Text(
                          'SignIn',
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () => Provider.of<Authentication>(context,
                                listen: false)
                            .createNewAccount(
                                emailController.text, passwordController.text)
                            .whenComplete(() {
                          if (Provider.of<Authentication>(context,
                                      listen: false)
                                  .getErrorMessage ==
                              '') {
                            Navigator.pushReplacement(
                                context,
                                PageTransition(
                                    child: HomeScreen(),
                                    type: PageTransitionType.leftToRight));
                          } else if (Provider.of<Authentication>(context,
                                      listen: false)
                                  .getErrorMessage !=
                              '') {
                            Navigator.pushReplacement(
                                context,
                                PageTransition(
                                    child: Login(),
                                    type: PageTransitionType.leftToRight));
                            errorMessage = '';
                          }
                        }),
                      ),
                    ),
                    Text(
                      Provider.of<Authentication>(context, listen: false)
                          .getErrorMessage,
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
