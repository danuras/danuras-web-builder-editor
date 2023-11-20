class ContactModel {
  late String whatsapp, whatsappMessage,  callNumber, address, email, infoContact, embededMapUrl, infoLocation, backgroundContact;
  ContactModel.fromJson(Map<String, dynamic> json){
    whatsapp = json['whatsapp'];
    whatsappMessage = json['whatsapp_message'];
    callNumber = json['call_number'];
    address = json['address'];
    email = json['email'];
    infoContact = json['info_contact'];
    infoLocation = json['info_location'];
    embededMapUrl = json['embeded_map_url'];
    backgroundContact = json['background_contact'];
  }
}