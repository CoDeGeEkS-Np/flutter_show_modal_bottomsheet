import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: DialogExample(),
  ));
}

Future<T> showBottomDialog<T>({
  @required BuildContext context,
  String title,
  String content,
  Widget titleWidget,
  Widget contentWidget,
  List<Widget> actions,
  bool allowBackNavigation = false,
  bool showCloseButton = false,
  Function onClose,
}) {
  assert(title != null || titleWidget != null,
      'title and titleWidget must not both be null');
  assert(content != null || contentWidget != null,
      'content and contentWidget must not both be null');

  final theme = Theme.of(context);

  return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      isDismissible: allowBackNavigation,
      builder: (context) => WillPopScope(
            onWillPop: () async => allowBackNavigation,
            child: Stack(children: <Widget>[
              Padding(
                padding:
                    //EdgeInsets.all(8),
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                child: Stack(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        titleWidget ??
                            Text(
                              title,
                              textAlign: TextAlign.left,
                              style: Theme.of(context).textTheme.headline5,
                            ),
                        SizedBox(height: 16),
                        contentWidget ??
                            Text(
                              content,
                              textAlign: TextAlign.left,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(height: 1.5),
                            ),
                        SizedBox(height: 20),
                        ButtonBar(
                          children: [
                            RaisedButton(
                              child: Text('YES, GO AHEAD'),
                              onPressed: () {},
                            ),
                            FlatButton(
                              child: Text('SKIP'),
                              onPressed: () {},
                            )
                          ],
                        )
                        // // if (showCloseButton)
                        // //   Align(
                        // //     alignment: Alignment.topRight,
                        // //     child: IconButton(
                        // //       icon: Icon(Icons.close),
                        // //       onPressed:
                        // //           onClose ?? () => Navigator.pop(context),
                        // //     ),
                        // //   )
                        // // else
                        // OutlineButton(
                        //   child: Text('GOT IT!'),
                        //   borderSide: BorderSide(color: theme.primaryColor),
                        //   onPressed: () {
                        //     Navigator.of(context).pop();
                        //   },
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
            ]),
          ));
}

class DialogExample extends StatelessWidget {
  void _showDialog(BuildContext context) {
    showBottomDialog(
      context: context,
      showCloseButton: true,
      allowBackNavigation: true,
      title: 'Do you wish to purchase add-ons?',
      content:
          'Add-ons help you save some extra money when you purchase them along with our original products. Plus, they help your chances of winning as well.',
      actions: [],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: RaisedButton(
          child: Text('Show Dialog'),
          onPressed: () => _showDialog(context),
        ),
      ),
    );
  }
}
