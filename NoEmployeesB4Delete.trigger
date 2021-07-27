trigger NoEmployeesB4Delete on Store__c (before delete) {
	List<Employee__c> trigger3 = new List<Employee__c> ([SELECT Name, Store__c FROM Employee__c]);
    for(Store__c store : Trigger.new) {
        if (store.Store__c != 'null') {
              store.addError('This Store still has employees and can not be deleted.');
        }
    }
}

// Trigger 3 - don't delete a store until all it's employees are gone ~~~~~ before delete