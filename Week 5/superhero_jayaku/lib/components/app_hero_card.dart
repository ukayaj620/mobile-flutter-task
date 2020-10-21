import 'package:flutter/material.dart';

class HeroCard extends StatelessWidget {

  HeroCard({
    this.imageUrl,
    this.heroName,
    this.getData,
  });

  final String imageUrl;
  final String heroName;
  final Function getData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        FocusScope.of(context).unfocus();
        getData(this.heroName, this.imageUrl);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        padding: EdgeInsets.symmetric(vertical: 12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              spreadRadius: 0,
              blurRadius: 4, // changes position of shadow
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            CircleAvatar(
              backgroundImage: NetworkImage(
                imageUrl,
              ),
              radius: 100.0,
            ),
            SizedBox(height: 12.0),
            Text(
              heroName,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Quicksand',
                fontSize: 32.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}