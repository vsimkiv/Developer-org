global class ContactPaginationController {
    @AuraEnabled 
    global static List<Contact> retrieveContacts() {
        return PaginationUtils.getOneBatch();
    }
}