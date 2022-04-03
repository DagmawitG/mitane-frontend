import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mitane_frontend/presentation/animation/FadeAnimation.dart';
import 'package:mitane_frontend/presentation/pages/auth/Login_screen.dart';
import 'package:mitane_frontend/presentation/pages/auth/sign_up_page.dart';
import 'package:easy_localization/easy_localization.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  FadeAnimation(
                    1,
                    Text.rich(
                      TextSpan(
                        style: TextStyle(
                          fontFamily: 'Oxygen',
                          fontSize: 28,
                          color: const Color(0xff222222),
                          letterSpacing: 0.812,
                          height: 1.0714285714285714,
                        ),
                        children: [
                          TextSpan(
                            text: 'Welcome_ to'.tr(),
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          /* TextSpan(
                            text: ' ',
                            style: TextStyle(
                              color: const Color(0xff00b7f1),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(
                            text: 'ምጣኔ',
                            style: TextStyle(
                              color: Colors.green[400],
                              fontWeight: FontWeight.w700,
                            ),
                          ), */
                        ],
                      ),
                      textHeightBehavior:
                          TextHeightBehavior(applyHeightToFirstAscent: false),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  FadeAnimation(
                    1.2,
                    Text(
                      'Your_ Only_ Agricultural_ Solution'.tr(),
                      style: TextStyle(
                        fontFamily: 'Ubuntu',
                        fontSize: 12,
                        color: const Color(0xff222222),
                        letterSpacing: 0.5760000000000001,
                        fontWeight: FontWeight.w300,
                        height: 2.5,
                      ),
                      textHeightBehavior:
                          TextHeightBehavior(applyHeightToFirstAscent: false),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              FadeAnimation(
                  1.4,
                  Container(
                    height: MediaQuery.of(context).size.height / 3,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                'assets/images/welcom_screen_image.png'))),
                  )),
              Column(
                children: <Widget>[
                  SizedBox(
                    height: 35,
                  ),
                  Text.rich(
                    TextSpan(
                      style: TextStyle(
                        fontFamily: 'Ubuntu',
                        fontSize: 13,
                        color: const Color(0xff222222),
                        height: 1.5384615384615385,
                      ),
                      children: [
                        TextSpan(
                          text: 'Read_ our'.tr(),
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              //Navigator.pushNamed(context, '/register');
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: Text('privacy_ policy'.tr()),
                                  content: const Text(
                                      'ምጣኔ የግብርና ምርቶችን ከአምራች ገበሬው እስከ ሸማች ተጠቃሚ ያለውን የገበያ ሰንሰለት  ለማቀላጠፍ  የሚረዳ መተግበሪያ ነው  እንዲሁም ምርት እና ምርታማነትን ለመጨመር ለማስቻል የሚረዱ የግብርና ግብዓቶችን  እና ማሽነሪዎችን መረጃዎች በቀላሉ ለማግኘት ያስችላል ። በመሆኑም በዚህ አይነተኛ አማራጭ ተጠቅሞ ምርቱን ለመሸጥ የሚፈልግ ማንኛውም ግለሰብም ሆነ ድርጅት ምርቱን ከሸጠ የሸጠበትን አጠቃላይ ዋጋ  ከ2% እስከ 5% ለምጣኔ ድርጅት ኮሚሽን መክፈል እንዳለበት ህግ ያስገድዳል።'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('እሺ'),
                                    ),
                                  ],
                                ),
                              );
                            },
                          text: 'privacy_ policy'.tr(),
                          style: TextStyle(
                            color: Colors.green[200],
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        TextSpan(
                          text: 'እና',
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              //Navigator.pushNamed(context, '/register');
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text('የአገልግሎት ውል'),
                                  content: const Text(
                                      'ምጣኔ የግብርና ምርቶችን ከአምራች ገበሬው እስከ ሸማች ተጠቃሚ ያለውን የገበያ ሰንሰለት  ለማቀላጠፍ  የሚረዳ መተግበሪያ ነው  እንዲሁም ምርት እና ምርታማነትን ለመጨመር ለማስቻል የሚረዱ የግብርና ግብዓቶችን  እና ማሽነሪዎችን መረጃዎች በቀላሉ ለማግኘት ያስችላል ። በመሆኑም በዚህ አይነተኛ አማራጭ ተጠቅሞ ምርቱን ለመሸጥ የሚፈልግ ማንኛውም ግለሰብም ሆነ ድርጅት ምርቱን ከሸጠ የሸጠበትን አጠቃላይ ዋጋ  ከ2% እስከ 5% ለምጣኔ ድርጅት ኮሚሽን መክፈል እንዳለበት ህግ ያስገድዳል።'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('እሺ'),
                                    ),
                                  ],
                                ),
                              );
                            },
                          text: 'የአገልግሎት ውል!',
                          style: TextStyle(
                            color: Colors.green[200],
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        TextSpan(
                          text: 'ለመመራት እስማማለሁ',
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                    textHeightBehavior:
                        TextHeightBehavior(applyHeightToFirstAscent: false),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  FadeAnimation(
                    1.5,
                    InkWell(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (_) => LoginScreen()),
                              (route) => false);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 20),
                          decoration: BoxDecoration(
                            color: Color(0xff0a6430),
                            borderRadius: BorderRadius.circular(28),
                          ),
                          child: Text('Accept_ and_ Continue'.tr(),
                              style: TextStyle(color: Colors.white)),
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  FadeAnimation(
                      1.6,
                      GestureDetector(
                        onTap: () => {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => SignUp()))
                        },
                        child: Container(
                          padding: EdgeInsets.only(top: 3, left: 3),
                          child: Text.rich(
                            TextSpan(
                              style: TextStyle(
                                fontFamily: 'Ubuntu',
                                fontSize: 15,
                                color: const Color(0xff222222),
                              ),
                              children: [
                                TextSpan(
                                  text: 'Are_ you_ a_ Farmer'.tr(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                TextSpan(
                                  text: 'ነጋዴ አልያም ሸማች',
                                  style: TextStyle(
                                    color: Colors.green[200],
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                TextSpan(
                                  text: '?',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            ),
                            textHeightBehavior: TextHeightBehavior(
                                applyHeightToFirstAscent: false),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
