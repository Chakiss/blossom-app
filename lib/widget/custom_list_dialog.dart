import 'package:blossom_clinic/blossom_theme.dart';
import 'package:flutter/material.dart';

class CustomListDialog extends StatelessWidget {

  Function(String value) listener;
  List<String> data;

  CustomListDialog(this.data, this.listener);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 100),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5)),
          border: Border.all(color: BlossomTheme.darkPink),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 4, bottom: 6),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      listener(data[index]);
                      Navigator.pop(context);
                    },
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(data[index]),
                        ),
                        if (index < data.length - 1)
                          Divider(
                                color: BlossomTheme.darkPink,
                              ) ??
                              null
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
