trigger AccountForCustomer on Customer__c (after insert, after update) {
	List<Account> trigger1 = new List<Account>();
    for (Customer__c a : [SELECT Name FROM Customer__c WHERE Name IN :Trigger.New]) {
                         trigger1.add( new Account(Name = a.name) );
    }
    
    if( trigger1.size() > 0) {
        insert trigger1;
        System.debug('Success!');
    }
}

// Trigger 1 - creating a customer object adds an account for them   ~~~~ after insert