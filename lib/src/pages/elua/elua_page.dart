import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import '../../logic/authentication/authentication_bloc.dart';

class EluaPage extends StatelessWidget {

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Html(
          data: """
          <h2>End-User License Agreement (EULA) of YourVoyce, Inc.</h2>

<p>This End-User License Agreement ("EULA") is a legal agreement between you and YourVoyce, Inc.</p>

<p>This EULA governs your acquisition and use of our YourVoyce, Inc. software ("Software") directly from YourVoyce, Inc. or indirectly through a YourVoyce, Inc. authorized reseller or distributor (a "Reseller").</p>

<p>Please read this EULA carefully before completing the installation process and using the YourVoyce, Inc. software. It provides a license to use the YourVoyce, Inc. software and contains warranty information and liability disclaimers.</p>

<p>If you register for a free trial of the YourVoyce, Inc. software, this EULA  will also govern that trial. By clicking "accept" or installing and/or using the YourVoyce, Inc. software, you are confirming your acceptance of the Software and agreeing to become bound by the terms of this EULA agreement.</p>

<p>If you are entering into this EULA  on behalf of a company or other legal entity, you represent that you have the authority to bind such entity and its affiliates to these terms and conditions. If you do not have such authority or if you do not agree with the terms and conditions of this EULA agreement, do not install or use the Software, and you must not accept this EULA agreement.</p>

<p>This EULA  shall apply only to the Software supplied by YourVoyce, Inc. herewith regardless of whether other software is referred to or described herein. The terms also apply to any YourVoyce, Inc. updates, supplements, Internet-based services, and support services for the Software, unless other terms accompany those items on delivery. If so, those terms apply.</p>

<h3>License Grant</h3>

<p>YourVoyce, Inc. hereby grants you a personal, non-transferable, non-exclusive licence to use the YourVoyce, Inc. software on your devices in accordance with the terms of this EULA agreement.</p>

<p>You are permitted to load the YourVoyce, Inc. software (for example a PC, laptop, mobile or tablet) under your control. You are responsible for ensuring your device meets the minimum requirements of the YourVoyce, Inc. software.</p>

<p>You are not permitted to:</p>

<ul>
<li>Edit, alter, modify, adapt, translate or otherwise change the whole or any part of the Software nor permit the whole or any part of the Software to be combined with or become incorporated in any other software, nor decompile, disassemble or reverse engineer the Software or attempt to do any such things</li>
<li>Reproduce, copy, distribute, resell or otherwise use the Software for any commercial purpose</li>
<li>Allow any third party to use the Software on behalf of or for the benefit of any third party</li>
<li>Use the Software in any way which breaches any applicable local, national or international law</li>
<li>use the Software for any purpose that YourVoyce, Inc. considers is a breach of this EULA </li>
</ul>

<h3>Intellectual Property and Ownership</h3>

<p>YourVoyce, Inc. shall at all times retain ownership of the Software as originally downloaded by you and all subsequent downloads of the Software by you. The Software (and the copyright, and other intellectual property rights of whatever nature in the Software, including any modifications made thereto) are and shall remain the property of YourVoyce, Inc..</p>

<p>YourVoyce, Inc. reserves the right to grant licences to use the Software to third parties.</p>

<h3>Termination</h3>

<p>This EULA is effective from the date you first use the Software and shall continue until terminated. You may terminate it at any time upon written notice to YourVoyce, Inc..</p>

<p>It will also terminate immediately if you fail to comply with any term of this EULA. Upon such termination, the licenses granted by this EULA agreement will immediately terminate and you agree to stop all access and use of the Software. The provisions that by their nature continue and survive will survive any termination of this EULA agreement.</p>

<h3>Governing Law</h3>

<p>This EULA  and any dispute arising out of or in connection with this EULA, shall be governed by and construed in accordance with the laws of the state of Illinois located in the United States of America.</p>
          """,
          style: {
            "*": Style(
              fontFamily: "Roboto",
              wordSpacing: 1,
              lineHeight: 1.2
            )
          },
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: RaisedButton(
                  
                  color: Theme.of(context).buttonTheme.colorScheme.primary,
                  onPressed: () {
                    BlocProvider.of<AuthenticationBloc>(context).add(
                      AcceptELUA()
                    );
                    // Navigator.pushReplacementNamed(context, 'home');
                  },
                  child: Text(
                    'Accept',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary
                    ),
                  ),
                ),
              ),
              Expanded(
                child: RaisedButton(
                  
                  color: Theme.of(context).buttonTheme.colorScheme.error,
                  onPressed: () {
                    if (Platform.isAndroid) {
                      SystemNavigator.pop();
                    } else if (Platform.isIOS) {
                      exit(0);
                    }
                  },
                  child: Text(
                    'Decline',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onError
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}