

abstract class Validators {

  static String emailValidator(String email) {

    String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    if (email.length == 0) {
      return null;
    } else if(!regExp.hasMatch(email)){
      return "Adresse Email invalide";
    }
    return null;

  }

  static String newPasswordValidator(String password) {

    if (password == null || password.isEmpty) return null;
    if (password.length < 6)
      return "Le mot de passe doit avoir au moins 6 caractères";
    if (!password.contains(RegExp("(?=.*[0-9])(?=.*[a-zA-Z])([a-zA-Z0-9]+)")))
      return "Le mot de passe doit avoir au moins une lettre et un chiffre";
    return null;

  }

  static String loginPasswordValidator(String password) => password.isNotEmpty ? null : "Mot de passe vide";

  static String phoneNumberValidator(String phone) {
    
    // TODO: Find a better regex to validate phone numbers
    RegExp regExp = RegExp(r'^0[0-9]{9}$');
    if (!regExp.hasMatch(phone)) {
      return "Numéro de téléphone non valide";
    }

    return null;

  }

  static String nameValidator(String name) => name.isEmpty ? "Ce champ est obligatoire" : null;

  static String passwordConfirmationValidator(String password, String passwordConfirmation) => 
    password == passwordConfirmation ? null : "Les mots de passes ne sont pas identiques";

  static String creditCardValidator(String cardNumber) {
    RegExp regExp = RegExp("^[0-9]{4} [0-9]{4} [0-9]{4} [0-9]{4}\$");
    return regExp.hasMatch(cardNumber) ? null : "Numéro de carte invalide";
  }

  static String expiryDateValidator(String expiryDate) {
    final dateComponents = expiryDate.split("/");
    if (dateComponents.length != 2 || dateComponents.where((c) => c.isEmpty).length > 0)
      return "Date de fin invalide";
    final expiryDateTime = DateTime(2000 + int.parse(dateComponents[1]), int.parse(dateComponents[0]));
    if (expiryDateTime.isBefore(DateTime.now())) {
      return "Carte expirée";
    }
    return null;
  }

  static String cvcValidator(String cvc) => cvc != null && cvc.length == 3 ? null : "le cvc doit comprendre 3 chiffres";

}