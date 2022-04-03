import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:mitane_frontend/application/auth/bloc/auth_bloc.dart';
import 'package:mitane_frontend/application/auth/events/auth_events.dart';
import 'package:mitane_frontend/application/auth/states/auth_state.dart';
import 'package:mitane_frontend/domain/auth/entity/auth_model.dart';
import 'package:mitane_frontend/presentation/pages/auth/Login_screen.dart';
import 'package:easy_localization/easy_localization.dart';

class SignUp extends StatefulWidget {
  SignUp();

  @override
  _FarmerSignUpState createState() => _FarmerSignUpState();
}

class _FarmerSignUpState extends State<SignUp> {
  final phoneController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();
  int _role = 1;
  Locale _language = Locale('am');

  bool obscureText = true;

  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            /*  Positioned(
              child: Bubble(
                height: 160.0,
                width: 160.0,
              ),
              top: -5,
              left: -160,
            ),
            Positioned(
              child: Bubble(
                height: 300.0,
                width: 300,
              ),
              top: 120,
              left: 180,
            ), */
            Positioned.fill(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IconButton(
                                onPressed: () => {Navigator.pop(context)},
                                icon: Icon(
                                  FontAwesomeIcons.arrowLeft,
                                  size: 20,
                                  color: Color(0xff222222),
                                )),
                            Column(
                              children: [
                                Container(
                                    width: 150,
                                    height: 100,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image:
                                                AssetImage("assets/METANE.png"),
                                            fit: BoxFit.contain))),
                                Text("Mitane_ App".tr(),
                                    style: TextStyle(
                                        fontSize: 28.0,
                                        color: Color(0xff04471a),
                                        fontWeight: FontWeight.w800)),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width - 150,
                                  child: Text(
                                      "Mitane_ is_ app_ for_ Famers_ Users_ and_ Traders_n_to_ facilitate_ Agriculture"
                                          .tr(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          color: Color(0xffc1c1c1),
                                          fontWeight: FontWeight.normal)),
                                )
                              ],
                            ),
                            SizedBox(
                              width: 50,
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 30),
                      Text('Create_ Account'.tr(),
                          style: TextStyle(
                              fontSize: 34,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff2e2e2e))),
                      SizedBox(height: 5),
                      Divider(
                        endIndent: 100,
                        indent: 100,
                      ),
                      Text('sign_ up_ to_ continue'.tr(),
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff919191))),
                      SizedBox(height: 25),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Language'.tr(),
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff919191))),
                            SizedBox(height: 8),
                            Material(
                              elevation: 2,
                              borderRadius: BorderRadius.circular(5),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: DropdownButton<Locale>(
                                  elevation: 2,
                                  value: _language,
                                  underline: Container(),
                                  onChanged: (Locale? val) {
                                    setState(() {
                                      _language = val!;
                                    });
                                    context.setLocale(val!);
                                  },
                                  items: [
                                    DropdownMenuItem(
                                      value: Locale('am'),
                                      child: Text("አማርኛ"),
                                    ),
                                    DropdownMenuItem(
                                      value: Locale('en'),
                                      child: Text("English"),
                                    ),
                                    DropdownMenuItem(
                                      value: Locale('om'),
                                      child: Text("Oromifa"),
                                    ),
                                  ],
                                  isExpanded: true,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Select_ Role'.tr(),
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff919191))),
                            SizedBox(height: 8),
                            Material(
                              elevation: 2,
                              borderRadius: BorderRadius.circular(5),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: DropdownButton(
                                  elevation: 2,
                                  value: _role,
                                  underline: Container(),
                                  items: [
                                    DropdownMenuItem(
                                      child: Text("Farmer".tr()),
                                      value: 1,
                                    ),
                                    DropdownMenuItem(
                                      child: Text("Trader".tr()),
                                      value: 3,
                                    ),
                                    /* DropdownMenuItem(
                                      child: Text("Product Trader"),
                                      value: 3,
                                    ),
                                    DropdownMenuItem(
                                      child: Text("Tool Trader"),
                                      value: 4,
                                    ), */
                                    DropdownMenuItem(
                                      child: Text("Users".tr()),
                                      value: 5,
                                    ),
                                  ],
                                  onChanged: (int? value) {
                                    setState(() {
                                      _role = value!;
                                    });
                                  },
                                  isExpanded: true,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Name'.tr(),
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff919191))),
                            SizedBox(height: 8),
                            Material(
                              elevation: 2,
                              borderRadius: BorderRadius.circular(5),
                              child: TextFormField(
                                controller: nameController,
                                decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: BorderSide.none,
                                    ),
                                    hintText: 'Name'.tr()),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Phone_ Number'.tr(),
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff919191))),
                            SizedBox(height: 8),
                            Material(
                              elevation: 2,
                              borderRadius: BorderRadius.circular(5),
                              child: TextFormField(
                                controller: phoneController,
                                keyboardType: TextInputType.phone,
                                textAlign: TextAlign.left,
                                validator: (String? val) {
                                  if (val == null || val.isEmpty) {
                                    return "Phone Number is Required";
                                  }
                                  if (!RegExp(r'^9\d{8,8}$').hasMatch(val))
                                    return "Phone Number is Invalid";
                                  return null;
                                },
                                decoration: InputDecoration(
                                  prefix: Text('+251 '),
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  hintText: '(###) ##-####',
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Password'.tr(),
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff919191))),
                            SizedBox(height: 8),
                            Material(
                              elevation: 2,
                              borderRadius: BorderRadius.circular(5),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: passwordController,
                                      obscuringCharacter: "*",
                                      obscureText: obscureText,
                                      maxLength: 4,
                                      maxLengthEnforcement: MaxLengthEnforcement
                                          .truncateAfterCompositionEnds,
                                      decoration: InputDecoration(
                                          fillColor: Colors.white,
                                          filled: true,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            borderSide: BorderSide.none,
                                          ),
                                          hintText: 'Password'.tr()),
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(obscureText
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                    onPressed: () {
                                      setState(() {
                                        obscureText = !obscureText;
                                      });
                                    },
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Confirm_ Password'.tr(),
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff919191))),
                            SizedBox(height: 8),
                            Material(
                              elevation: 2,
                              borderRadius: BorderRadius.circular(5),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: confirmController,
                                      obscuringCharacter: "*",
                                      obscureText: obscureText,
                                      maxLength: 4,
                                      maxLengthEnforcement: MaxLengthEnforcement
                                          .truncateAfterCompositionEnds,
                                      decoration: InputDecoration(
                                          fillColor: Colors.white,
                                          filled: true,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            borderSide: BorderSide.none,
                                          ),
                                          hintText: 'Confirm_ Password'.tr()),
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(obscureText
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                    onPressed: () {
                                      setState(() {
                                        obscureText = !obscureText;
                                      });
                                    },
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      BlocConsumer<AuthBloc, AuthState>(
                          builder: (context, state) {
                        if (state is Registering) {
                          return Center(
                              child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(),
                          ));
                        }

                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 10),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('ክፈት',
                                      style: TextStyle(
                                          fontSize: 26,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xff2e2e2e))),
                                  InkWell(
                                      onTap: () {
                                        if (!_formKey.currentState!.validate())
                                          return;
                                        final authBloc =
                                            context.read<AuthBloc>();
                                        authBloc.add(RegisterEvent(
                                            register: (Register(
                                                name: nameController.text,
                                                phone: "+251" +
                                                    phoneController.text,
                                                password:
                                                    passwordController.text,
                                                confirm: confirmController.text,
                                                role: _role.toString()))));
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 30, vertical: 20),
                                        decoration: BoxDecoration(
                                          color: Color(0xff0a6430),
                                          borderRadius:
                                              BorderRadius.circular(28),
                                        ),
                                        child: Icon(
                                          FontAwesomeIcons.arrowRight,
                                          size: 15,
                                          color: Colors.white,
                                        ),
                                      )),
                                ],
                              ),
                              if (state is RegisterError)
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.red),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  child: Text(state.errorMessage,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white)),
                                )
                            ],
                          ),
                        );
                      }, listener: (context, state) {
                        if (state is RegisterSuccess) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (_) => LoginScreen()),
                              (route) => false);
                        }
                      }),
                      SizedBox(
                        height: 25,
                      ),
                      RichText(
                        text: TextSpan(
                            text: 'Already_ have_ an_ account'.tr(),
                            style: TextStyle(
                              color: Color(0xff222222),
                              fontSize: 15,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                  text: ' Sign in',
                                  style: TextStyle(
                                      color: Color(0xff0a6430), fontSize: 15),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.pushNamed(context, '/login');
                                    })
                            ]),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
