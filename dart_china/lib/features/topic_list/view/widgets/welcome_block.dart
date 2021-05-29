part of 'widgets.dart';

class WelcomeBlock extends StatelessWidget {
  const WelcomeBlock({
    Key? key,
    required this.onSearchPressed,
  }) : super(key: key);

  final VoidCallback onSearchPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20),
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dart China',
                      style: TextStyle(
                        color: Colors.grey.shade100,
                        fontSize: 26,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(
                      width: 30,
                      height: 30,
                      margin: EdgeInsets.only(left: 5),
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: Image.asset(
                          'assets/icon/logo_dart.png',
                          width: 25,
                          height: 25,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                FittedBox(
                  child: Text(
                    '由爱好者建立，讨论 Dart、Flutter 的开放型技术社区',
                    style: TextStyle(
                      color: Color(0xFFadbcdf),
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // SizedBox.expand(),
          Align(
            // mainAxisAlignment: MainAxisAlignment.center,
            child: IconButton(
              splashRadius: kSplashRadius,
              iconSize: 30,
              color: Colors.grey.shade300,
              icon: Icon(Icons.search),
              onPressed: () => onSearchPressed.call(),
            ),
          )
        ],
      ),
    );
  }
}
