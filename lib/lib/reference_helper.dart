class ReferenceHelper {
  static validateRef(String reference){
    reference= reference.replaceAll(" ", "");
    try{
      int.parse(reference);
    }catch(e){
      throw Exception("La référence doit être un nombre valide");
    }
    if (reference.length!=10) {
      throw Exception("La référence doit avoir 10 caractères");
    }
  }
}