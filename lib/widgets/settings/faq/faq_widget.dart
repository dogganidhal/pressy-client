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
          "Commandez via l'application Pressy en 1min :\n\n"

          "Choisissez le créneau horaire qui vous convient, Express 24h ou Standard 48h ainsi que l'adresse à laquelle vous serez collecté et livré.\n"
          "Sélectionnez vos articles afin d'obtenir un devis ou commandé directement, la facture vous sera envoyé lors de votre livraison. \n\n"

          "L'avantage du service Express :\n\n"

          "Beneficier d'un service de livraison ultra rapide en choisissant l'option Express pour 8.90 euros. \n"
          "En seulement 24h (jour ouvré) votre ligne vous est livré.\n"

          "Pour une livraison classique en 48h sélectionné la livraison standard. Ce service est gratuit. \n\n"


          "Confiez vos vêtements à notre chauffeur\n\n"

          "Notre chauffeur collecte le linge à domicile au créneau qui lui aura été indiqué. \n\n\n"


          "Votre linge vous est livré fraîchement nettoyé\n"

          "24h après notre passage vos vêtements vous sont livrés nettoyés et repassés ! \n"
          "Remboursement et SAV :\n"

          "Une insatisfaction ? Contactez le SAV dans les 14 jours qui suivent votre livraison. Celui-ci s'attechera à repondre votre demande. (remboursement possible au cours des 14 jours). \n\n"

          "Type de nettoyage : Pressing/linge au kilos :\n\n"

          "La prestation de type pressing comprend le nettoyage a sec ainsi que le repassage de votre vêtement. Le tarif est calculé à la pièce. \n"
          "Tandis que le linge au kilos correspond au lavage en machine a lavé, le tarif est calculé au poid. \n\n"

          "En cas d'absence :\n\n"

          "Si vous êtes absent et de non réponse par téléphone, votre chauffeur patientera 7 minutes suite à quoi un prélèvement de 5euros si il n'a aucun retour. \n"
          "Vous pouvez a tout moment prevenir le SAV afin de notifier votre absence et discuter d'une horaire de livraison légèrement différente si cela est possible..\n"
        ),
      ),
    );
  }

}