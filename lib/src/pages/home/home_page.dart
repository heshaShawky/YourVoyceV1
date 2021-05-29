// import 'dart:developer';

import 'package:flutter/material.dart';
// import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:yourvoyce/src/logic/authentication/authentication_bloc.dart';
import 'package:yourvoyce/src/logic/tabs/tabs_bloc.dart';

import '../../logic/webview/webview_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  InAppWebViewController _inAppWebViewController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      // create: (context) => TabsBloc(),
      providers: [
        BlocProvider(
          create: (context) => WebviewBloc(),
        ),
        BlocProvider(
          create: (context) => TabsBloc(),
        )
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          toolbarHeight: 0,
          centerTitle: false,
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.lightBlue
          ),
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
          brightness: Brightness.light,
          // title: Image.asset(
          //   'assets/images/logo.png',
          //   width: 100,
          //   fit: BoxFit.contain,
          // ),
          // actions: [
          //   IconButton(
          //     icon: Icon(Icons.person), 
          //     onPressed: () {

          //     }
          //   ),
          //   IconButton(
          //     icon: Icon(Icons.logout), 
          //     onPressed: () {

          //     }
          //   )
          // ],
        ),
        body: WillPopScope(
          onWillPop: () async {
            if (await _inAppWebViewController.canGoBack()) {
              final int currentIndex =
                  (await _inAppWebViewController.getCopyBackForwardList())
                      .currentIndex;
              final String prevLink =
                  (await _inAppWebViewController.getCopyBackForwardList())
                      .list[currentIndex - 2]
                      .url;

              await _inAppWebViewController.loadUrl(url: prevLink);
              return false;
            }

            return true;
          },
          child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
              // print(state);
              if ( state is AuthenticationUnauthenticated ) {
                // print('test');
                Navigator.of(context).pushReplacementNamed('intro');
              }
            },
            builder: (context, authState) {
              if (authState is AuthenticationAuthenticated) {
                return BlocBuilder<WebviewBloc, WebviewState>(
                  
                  builder: (context, state) {
                    return Stack(
                      children: [
                        Container(
                          child: InAppWebView(
                            initialUrl:"https://yourvoyce.com/?token=${authState.token}",
                            initialHeaders: {},
                            initialOptions: InAppWebViewGroupOptions(
                              crossPlatform: InAppWebViewOptions(
                                supportZoom: false,
                                cacheEnabled: true,
                                // clearCache: true
                              ),
                              android: AndroidInAppWebViewOptions(
                                cacheMode: AndroidCacheMode.LOAD_CACHE_ELSE_NETWORK,
                                allowFileAccess: true,
                                allowContentAccess: true,
                                allowFileAccessFromFileURLs: true,
                                allowUniversalAccessFromFileURLs: true
                              )
                            ),
                            onLoadError: (InAppWebViewController controller, String url, int code, String message) async {
                              // print(code);
                              await controller.stopLoading();

                              BlocProvider.of<WebviewBloc>(context).add(
                                WebviewErrorOccured()
                              );
                            },
                            onWebViewCreated: (InAppWebViewController controller) {
                              _inAppWebViewController = controller;
                            },
                            onLoadStart: (controller, url) {
                              // print("started $url");
                              int currentTabIndex = 0;

                              if ( url.contains('search') ) {
                                currentTabIndex = 1;
                              } else if ( url.contains('notification')) {
                                currentTabIndex = 2;
                              }

                              BlocProvider.of<TabsBloc>(context).add(
                                ChangeActiveTab(currentTabIndex)
                              );
                              
                              if (url == 'https://yourvoyce.com/' || url.contains('logout') ){
                                // Navigator.of(context).pushReplacementNamed('intro');
                                BlocProvider.of<AuthenticationBloc>(context).add(Logout());
                              }
                            },
                            onLoadStop: (controller, url) async {
                              
                            },
                            onProgressChanged: (controller, progress) {
                              // print(progress);
                              BlocProvider.of<WebviewBloc>(context)
                                ..add(WebviewStart(progress: progress / 100));
                            },
                          ),
                        ),
                        if (state is WebviewLoading)
                          AnimatedPositioned(
                            bottom: state is WebviewLoading ? 10 : -130,
                            left: 10,
                            child: Container(
                              width: 90,
                              height: 90,
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      padding: EdgeInsets.symmetric(horizontal: 10),
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2.0,
                                        valueColor: AlwaysStoppedAnimation<Color>(
                                            Colors.white),
                                      )),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text('Loading',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600
                                    )
                                  )
                                ],
                              ),
                            ),
                            duration: Duration(milliseconds: 1000)
                          ),
                        if ( state is WebviewError ) ...[
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.wifi_off,
                                    size: 120,
                                  ),
                                  Text(
                                    'Connection lost please check your internet connection and refresh',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  RaisedButton(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.refresh
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text('ٌRefresh'),
                                      ],
                                    ),
                                    onPressed: () async {
                                      // print(await _inAppWebViewController.getUrl());
                                     await  _inAppWebViewController.loadUrl(url: 'https://yourvoyce.com/members/home');
                                    }
                                  )
                                ],
                              ),

                            ),
                          )
                        ]
                      ],
                    );
                  },
                );
              }

              return Container();
            },
          ),
        ),
        bottomNavigationBar: BlocBuilder<TabsBloc, TabsState>(
          builder: (context, state) {
            return BottomNavigationBar(
              currentIndex: state is TabsInitial ? state.activeTabIndex : 0,
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
                BottomNavigationBarItem( icon: Icon(Icons.notifications), label: 'Notifications'),
                BottomNavigationBarItem( 
                  icon: Icon(
                    Icons.chat
                  ), 
                  label: 'Chat'
                ),
                BottomNavigationBarItem( icon: Icon(Icons.arrow_back), label: 'Back'),
              ],
              onTap: (index) async {
    
                if ( index != 4 )
                  BlocProvider.of<TabsBloc>(context).add(
                    ChangeActiveTab(index)
                  );
                
                if (index == 0) {
                  await _inAppWebViewController.loadUrl(
                      url: 'https://yourvoyce.com/');
                } else if (index == 1) {
                  await _inAppWebViewController.loadUrl(
                      url: 'https://yourvoyce.com/search');
                } else if (index == 2) {
                  await _inAppWebViewController.loadUrl(
                      url: 'https://yourvoyce.com/activity/notifications');
                } else if ( index == 3 ) {
                    await _inAppWebViewController.evaluateJavascript(
                      source: """
                        window.channelizeUI.openMessenger()
                      """
                    );
                } else if (index == 4) {
                  if (await _inAppWebViewController.canGoBack()) {
                    final int currentIndex = (await _inAppWebViewController.getCopyBackForwardList()).currentIndex;
                    final String prevLink =(await _inAppWebViewController.getCopyBackForwardList()).list[currentIndex - 2].url;

                    await _inAppWebViewController.loadUrl(url: prevLink);
                  }
                }
              },
            );
          },
        ),
      ),
    );
  }
}
