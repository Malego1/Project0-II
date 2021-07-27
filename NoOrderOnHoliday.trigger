trigger NoOrderOnHoliday on Order__c (before insert, before update) {
    Set<Date> allHolidays = new Set<Date>();
    for ( List<Holiday> daysOff : [SELECT ActivityDate FROM Holiday] ) {
        for (Holiday h : daysOff) {
            allHolidays.add(h.ActivityDate);
        }
    }
    
    for (Order__c order : Trigger.new) {
        Boolean checkDate = ( trigger.isInsert || trigger.oldMap.get(order.Id).CreatedDate != order.CreatedDate );
        if (checkDate && order.CreatedDate != NULL) {
            if ( allHolidays.contains(order.CreatedDate) ) {
                order.CreatedDate.addError('Orders can not be created on holidays.');
            }
        }
    }
}

// Trigger 2 - don't create orders if today is a holiday ~~~~~ before insert, before update