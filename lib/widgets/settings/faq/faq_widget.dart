import 'package:flutter/material.dart';
import 'package:pressy_client/utils/style/app_theme.dart';


class FaqWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorPalette.orange),
        title: Text("Comment ça marche"),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi justo '
          'metus, tempus vitae cursus tincidunt, scelerisque eget eros. Donec et '
          'turpis sit amet sem rhoncus tincidunt. Donec egestas blandit diam. '
          'Praesent at pharetra odio, at interdum elit. Vestibulum lacinia '
          'sollicitudin turpis, commodo volutpat urna malesuada vel. Donec viverra '
          'ullamcorper felis, consectetur finibus libero malesuada in. Pellentesque '
          'condimentum varius urna. Fusce cursus risus leo, volutpat congue ipsum '
          'viverra ac. Maecenas tempus nisi nibh, non sodales felis placerat in. '
          'Suspendisse quis ligula vitae neque vulputate imperdiet. Sed non libero '
          'gravida ligula commodo ultricies. Vestibulum velit lacus, iaculis at '
          'vulputate in, commodo sed est. Vivamus ultrices bibendum risus, ac '
          'pharetra mi posuere eu. Curabitur a urna sit amet est vulputate egestas. '
          'Pellentesque rutrum, mauris non pulvinar convallis, arcu sem placerat nulla,'
          'nec commodo diam elit bibendum ligula. Orci varius natoque penatibus '
          'et magnis dis parturient montes, nascetur ridiculus mus. Ut nulla nibh, '
          'egestas at pretium a, ornare ut augue. Vivamus vel metus quis metus '
          'imperdiet blandit. Fusce mattis varius rutrum. Maecenas augue ante, '
          'accumsan a augue in, consequat feugiat velit. Donec sagittis leo sed '
          'mauris placerat mattis. Praesent vitae augue elit. Pellentesque sit '
          'amet varius tellus. In nec enim velit. Cras venenatis magna vitae est '
          'viverra, et suscipit lorem finibus. Suspendisse ullamcorper tortor '
          'euismod laoreet convallis. Suspendisse potenti. Proin lobortis finibus '
          'tempus. Sed sagittis tristique eleifend. Vivamus tincidunt nec nunc '
          'blandit ornare. Integer ultrices nibh nec risus bibendum ullamcorper. '
          'Pellentesque habitant morbi tristique senectus et netus et malesuada '
          'fames ac turpis egestas. In neque neque, sollicitudin non molestie eu, '
          'aliquet et elit. Suspendisse gravida, ante eu imperdiet lobortis, mi '
          'dolor rhoncus nunc, at pulvinar diam turpis nec mi. Etiam tincidunt '
          'lectus a nunc vestibulum, varius condimentum tellus eleifend. Ut faucibus '
          'metus vitae consequat vestibulum. Proin vitae tempus nisl, et consequat '
          'risus. Nam facilisis elementum enim volutpat sodales. Pellentesque habitant '
          'morbi tristique senectus et netus et malesuada fames ac turpis egestas. '
          'Praesent quis imperdiet ante. Mauris vitae consectetur lacus. Sed '
          'facilisis ligula urna, vel pretium tellus euismod in. Etiam eleifend '
          'nisi vel nisi maximus mollis. Duis leo risus, sollicitudin sed '
          'viverra pellentesque, egestas eu massa. Sed in facilisis felis.'
        ),
      ),
    );
  }

}