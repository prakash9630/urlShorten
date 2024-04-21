import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_shortener/components/custom_textfield.dart';
import 'package:url_shortener/components/submit_button.dart';
import 'package:url_shortener/const/app_colors.dart';
import 'package:url_shortener/const/text_styles.dart';
import 'package:url_shortener/link_shortner/repo/link_shorten_repo.dart';

class LinkShortScreen extends StatefulWidget {
  const LinkShortScreen({Key? key}) : super(key: key);

  @override
  State<LinkShortScreen> createState() => _LinkShortScreenState();
}

class _LinkShortScreenState extends State<LinkShortScreen> {
  final TextEditingController _controller= TextEditingController();
  final GlobalKey<FormState> _key=GlobalKey();
  ShortLinkRepo repo=ShortLinkRepo();
  String? shortUrl="";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Url Shortner"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 200,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: const BoxDecoration(
              color: AppColors.appColor,
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),bottomLeft:Radius.circular(20)),
            ),
            child: Center(
              child: Form(
                key: _key,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                     CustomNewTextField(labelText: "",
                     controller: _controller,
                     hintText: "long link",),
                    const SizedBox(height: 15,),
                    CustomButton(buttonText: "Shorten Url",
                        onPressed: () async {
                      if(_key.currentState!.validate()){
                       shortUrl=await repo.shortenUrl(_controller.text);
                       setState(() {
                       });

                      }
                    })


                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20,),
          Expanded(child: Column(
            children: [
              if(shortUrl!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: QrImageView(
                  data: shortUrl!,
                  version: QrVersions.auto,
                  size: 200.0,
                ),
              ),
              InkWell(
                onTap: () async {
                },
                  child: Text(shortUrl!,style: w4f14(AppColors.appColor),))

            ],
          ))



        ],
      ),
    // This trailing comma makes auto-formatting nicer for build methods.
    );

  }
}
