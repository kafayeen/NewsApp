import 'package:flutter/material.dart';
import 'package:newsapp/domain/entites/newsapp_entites.dart';
import 'package:newsapp/presentation/controller/new_cubit.dart';
import 'package:newsapp/presentation/screens/webview.dart';

//https://newsapi.org/
//v2/everything
//q=apple&apiKey=a7ba871b67214025915dc7ab566f86e8
Widget item(NewsAppEntites article, context, index) {
  return InkWell(
    onTap: () {
      Appcubit.get(context).changeDetectItem(index);
      navigator(context, Web(url: article.url));
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        color: Appcubit.get(context).detectItem == index &&
                Appcubit.get(context).isDesktop == true
            ? Colors.grey[400]
            : null,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(article.urlToImage),
                  ),
                  borderRadius: BorderRadius.circular(10)),
              width: 150,
              height: 150,
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
                child: SizedBox(
              height: 150,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      article.title,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  Text(
                    article.publishedAt,
                    style: Theme.of(context).textTheme.bodyMedium,
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    ),
  );
}

void navigator(BuildContext context, Widget route) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => route));
}

Widget defaultField(
    {required BuildContext context,
    required String labelText,
    IconData? icon,
    required TextInputType type,
    required TextEditingController controller,
    Function(String)? onchange,
    bool read = false,
    Color? color,
    required String? Function(String?) functionValidator}) {
  return TextFormField(
    cursorColor: Appcubit.get(context).mode ? Colors.black : Colors.white,
    readOnly: read,
    style: TextStyle(
        color: Appcubit.get(context).mode ? Colors.black : Colors.white,
        fontSize: 18),
    onChanged: onchange,
    keyboardType: type,
    controller: controller,
    validator: functionValidator,
    decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
            borderSide: Appcubit.get(context).mode
                ? const BorderSide(color: Colors.black)
                : const BorderSide(color: Colors.white)),
        labelText: labelText,
        labelStyle: TextStyle(
            color: Appcubit.get(context).mode ? Colors.black : Colors.white),
        prefixIcon: Icon(
          icon,
          color: Appcubit.get(context).mode ? Colors.black : Colors.white,
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: Appcubit.get(context).mode
                ? const BorderSide(color: Colors.black)
                : const BorderSide(color: Colors.white))),
  );
}
