class Contact {
  late String whatsapp, whatsappMessage,  callNumber, address, email, infoContact, embededMapUrl, infoLocation, backgroundContact;
  Contact.fromJson(Map<String, dynamic> json){
    whatsapp = json['whatsapp'];
    whatsappMessage = json['whatsapp_message'];
    callNumber = json['call_number'];
    address = json['address'];
    email = json['email'];
    infoContact = json['info_contact'];
    infoLocation = json['info_loction'];
    embededMapUrl = json['embeded_map_url'];
    backgroundContact = json['background_contact'];
  }
}