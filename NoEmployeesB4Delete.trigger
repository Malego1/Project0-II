trigger NoEmployeesB4Delete on Store__c (before delete) {
    
	Set<Store__c> trigger3 = new Set<Store__c> ([SELECT Id FROM Store__c]);
    
    for(Store__c store : trigger.old) {
        Set<Employee__c> pt2 = new Set<Employee__c> ([SELECT Store__c FROM Employee__c WHERE Store__c IN : Trigger.old]);
        
        if ( trigger.oldMap.get(trigger3.Id) == trigger.oldMap.get(pt2.Id) ) {
                 store.addError('This Store still has employees and can not be deleted.');
            }
    }
}

// Trigger 3 - don't delete a store until all it's employees are gone ~~~~~ before delete