class SecretModel {
  late final String ClientPersonalSecret;
  late final String ClientPersonalId;
  late final String ClientPasswordSecret;
  late final String ClientPasswordId;
 
  SecretModel(
      {required this.ClientPasswordSecret,
      required this.ClientPasswordId,
      required this.ClientPersonalSecret,
      required this.ClientPersonalId,
     });
}
