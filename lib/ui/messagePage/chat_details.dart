import 'package:flutter/material.dart';
import 'package:tele_tip/app_colors.dart';
import 'package:tele_tip/services/api_service.dart';

class MessageDetails extends StatefulWidget {
  const MessageDetails(
      {Key? key,
      required this.id,
      required this.duo,
      required this.userName,
      required this.image,
      required this.target})
      : super(key: key);

  final int id;
  final String duo;
  final String userName;
  final String image;
  final int target;

  @override
  _MessageDetailsState createState() => _MessageDetailsState();
}

class _MessageDetailsState extends State<MessageDetails> {
  final _controller = TextEditingController();
  String? message;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      backgroundColor: backgroundBeige,
      body: SafeArea(
        child: SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 7,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              color: newDarkRed,
                            ),
                          ),
                          Column(
                            children: [
                              Container(
                                width: 45.0,
                                height: 45.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  image: DecorationImage(
                                    image: NetworkImage(widget.image),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Text(
                                widget.userName,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                  color: newDarkRed,
                                  letterSpacing: 0.8,
                                  height: 1.25,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 30,
                          )
                        ],
                      ),
                    ),
                    Divider(
                      color: newDarkRed,
                    ),
                  ],
                ),
              ),
              allMessage(screenHeight - 220, keyboardHeight),
              Row(
                children: <Widget>[
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      onChanged: (onSavedVal) {
                        message = onSavedVal;
                      },
                      style: TextStyle(
                        fontSize: 14.0,
                        color: newDarkRed,
                        letterSpacing: 0.7000000000000001,
                        fontWeight: FontWeight.w600,
                        height: 1.43,
                      ),
                      cursorColor: newOrange,
                      decoration: InputDecoration(
                        hintText: 'Mesaj gönder',
                        hintStyle: TextStyle(
                          color: newDarkRed,
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: backgroundBeige,
                      backgroundColor: newDarkRed,
                    ),
                    onPressed: () async {
                      var isSend = await APIService.sendMessage(
                          target: widget.target,
                          source: widget.id,
                          message: message);
                      if (isSend) {
                        setState(() {
                          _controller.clear();
                        });
                        message = "";
                      } else {}
                    },
                    child: Row(
                      children: const [Icon(Icons.send)],
                    ),
                  )
                ],
              ),
              //const Line(),
            ],
          ),
        ),
      ),
    );
  }

  Widget allMessage(screen, keyboard) {
    return FutureBuilder(
        future: APIService.getDuoMessage(widget.duo),
        builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) =>
            snapshot.hasData
                ? SizedBox(
                    height: screen - keyboard,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, index) => Padding(
                          padding:
                              const EdgeInsets.only(left: 5, top: 5, bottom: 5),
                          child: widget.id == snapshot.data![index]['source']
                              ? source(snapshot.data![index]['message'])
                              : target(snapshot.data![index]['message'])),
                    ),
                  )
                : const Text("data"));
  }

  Widget source(String text) {
    return Container(
      margin: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.40,
          top: 5,
          right: 5,
          bottom: 5),
      padding: const EdgeInsets.all(19),
      width: 250,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
          bottomLeft: Radius.circular(15.0),
        ),
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: const Alignment(0.97, -1.0),
          colors: [newOrange, newDarkRed],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            offset: const Offset(0, 5.0),
            blurRadius: 14.0,
          ),
        ],
      ),
      child: Text(
        textAlign: TextAlign.right,
        text,
        style: const TextStyle(
          fontSize: 14.0,
          color: Colors.white,
          letterSpacing: 0.7000000000000001,
          fontWeight: FontWeight.w600,
          height: 1.43,
        ),
      ),
    );
  }

  Widget target(String text) {
    return Container(
      margin: EdgeInsets.only(
          right: MediaQuery.of(context).size.width * 0.40,
          top: 5,
          left: 5,
          bottom: 5),
      padding: const EdgeInsets.all(19),
      width: MediaQuery.of(context).size.width * 0.95,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
          bottomRight: Radius.circular(15.0),
        ),
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: const Alignment(0.97, -1.0),
          colors: [newDarkRed, newOrange],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            offset: const Offset(0, 7.0),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.7,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 14.0,
            color: Color(0xFFECF1FF),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
