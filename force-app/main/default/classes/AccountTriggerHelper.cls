public class AccountTriggerHelper {
    public static void addPrefixAsMr(List<Account>triggerNew,Map<Id,ACcount>triggerNewMap, List<Account>triggerOld, Map<Id,ACcount>triggerOldMap){
        for(Account a : triggerNew){
            a.Name = 'Mr.'+ a.Name;
        }
    }
    public static void createContactByAccount(List<Account> triggerNew, Map<Id,Account> triggerNewMap, List<Account> triggerOld, Map<Id,Account> triggerOldMap){
     Set<Id> accountIds = new Set<Id>();
     List<Contact> contactListToInsert = new List<Contact>();
     for(Account a : triggerNew)
     {
         accountIds.add(a.Id);
     }
     List<Account> accList = [SELECT Id, Name FROM Account WHERE Id IN :accountIds];
     if(accList != Null){
         for(Account a : accList){
             Contact c = new Contact(LastName = 'ContactByAccount', AccountId =a.Id);
             contactListToInsert.add(c);
         }
         if(!contactListToInsert.isEmpty()){
            insert contactListToInsert;
         }
     }
 }
    //2
    Public static void DeleteAccount(List<Account> triggerNew,Map<Id,account> trigggerNewMap,List<Account>triggerOld,Map<Id,Account>triggerOldmap)
        {
             For(Account acc:triggerOld)
            {
              acc.adderror('You Cannot Delete the Account Record');
             }
        }
    //3
     Public Static void DupliAccount(List<Account> triggerNew, Map<Id,Account> triggerNewMap, List<Account> triggerOld, Map<Id,Account> triggerOldMap){
        List<Account> dup = [Select id, Name from Account];
                 
         for(Account a:TriggerNew){
            for(Account a1:dup){
                 if(a.Name==a1.Name){
                 a.Name.addError('You can not Create a Duplicate Account');
                 }
              }
            }   
    }
     Public static void UpdateFieldType(List<Account>triggerNew,Map<Id,Account>triggerNewMap,List<Account>triggerOld,Map<Id,Account>triggerOldMap)
    {
        List<Contact> ContactsToDelete = new List<Contact>();
        for (Account acct : TriggerNew) {
        Account oldAcct = TriggerOldMap.get(acct.Id);
        if (acct.Type == 'Installation Partner' && OldAcct.Type != 'Installation Partner') 
        {
         List<Contact> ConList= [SELECT Id FROM Contact WHERE AccountId =:acct.Id];
            ContactsToDelete.addAll(ConList);
        }
    }
        if(!ContactsToDelete.isEmpty()) {
        delete ContactsToDelete;
    }
}
    //6
    Public static void CreateContact(List<Account>triggerNew,Map<Id,Account>triggerNewMap,List<Account>triggerOld,Map<Id,Account>triggerOldMap)
    {
        List<Contact> listContact = new list<Contact>();
        Map<Id,decimal> MapAcc = new Map<Id,decimal>();
        for(Account acc : triggerNew){
            MapAcc.Put(acc.id,acc.Number_of_Locations__c);
        }
        if(MapAcc.Size()>0 && MapAcc!=null)
        {
            for(Id accid : mapAcc.Keyset()){
            for(Integer i=0;I < MapAcc.get(accId);i++)
            {
                Contact newContact=new Contact();
                newContact.accountId=accId;
                newContact.lastname='Coantact'+i;
                listContact.add(newContact);
            }
        }
    }
    if(listContact.size()>0 && listContact!=null)
    {
        insert listContact;
    }
       // insert listContact;
}
    //7
    Public static void CopyAddress(List<Account> triggerNew,Map<Id,Account>triggerNewMap,List<Account>triggerOld,Map<Id,Account>triggerOldMap){
        List<Account> accList = new List<Account>();
        for(Account acc : triggerNew){
            If(acc.CopyBillingToShipping__c == TRUE){
               acc.ShippingCity = acc.BillingCity; 
               acc.ShippingStreet = acc.BillingStreet;
               acc.ShippingPostalCode = acc.BillingPostalCode;
                acc.ShippingCountry =  acc.BillingCountry;
                acc.ShippingState   = acc.BillingState;
            }
        }
}
    //8
    Public static void CreateContactonAccount(List<Account>triggerNew,Map<Id,Account>triggerNewMap,List<Account>triggerOld,Map<Id,Account>triggerOldMap){
        //set<Id> ConL=new Set<Id>();
        List<Contact> ContactListToInsert = new List<Contact>();
        for(Account a : triggerNew){
            //AccountIds.add(a.Id);
            for(Integer i=0;i<=2;i++){
                 Contact Con = new Contact();
            Con.FirstName='Chirag';
            Con.LastName='Sharma';
            	Con.AccountId = a.Id;
            ContactListToInsert.add(Con);
            }
            }
        If(!ContactListToInsert.isEmpty())
         Insert ContactListToInsert;
    }
    //9
    Public static void UpdateField(List<Account>triggerNew,Map<Id,Account>triggerNewMap,List<Account>triggerOld,Map<Id,Account>triggerOldMap){
        List<Account> acclist = new List<Account>();
        For(Account acc : triggerNew)
        {
            If(acc.Hello__c!='World')
            {
                acc.Hello__c='World';
               accList.add(acc);
            }
        }
     }
    //10
    Public static void Updateaccount(List<Account> triggerNew,Map<Id,Account>triggerNewMap,List<Account>triggerOld,Map<Id,Account>triggerOldMap){
        List<Messaging.SingleEmailMessage> emailsToSend = new List<Messaging.SingleEmailMessage>();
        set<Id> accountIdset = new set<Id>();
         For(Account acc : triggerNew){
            if(acc.OwnerId != null){
                accountIdset.add(acc.Id); 
            }
        }
        List<Contact> ConList = [SELECT Id, Name, AccountId,LastModifiedDate,Account.Name, Account.LastModifiedDate FROM Contact WHERE AccountId IN : accountIdset];  
         for (Account acc : TriggerOld) {
          Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            email.setToAddresses(new String[] {[SELECT Email FROM User WHERE Id = :acc.OwnerId LIMIT 1].Email });
            email.setSubject('Account Updated with Modified Contacts');
            String emailBody = 'An account has been updated with the following contacts:\n\n';
            emailBody += 'Account Name: ' + acc.Name + '\n';
            emailBody += 'Account Id: ' + acc.Id + '\n';
            emailBody += 'Modified Contacts: ';
            Boolean Found = False;
            for (Contact c : ConList) {
                If(c.AccountId == acc.Id && c.LastModifiedDate > acc.LastModifiedDate){
                emailBody += '- ' + c.Name + '\n';
                 //Found = False;  
            }
            }
            email.setPlainTextBody(emailBody);
            emailsToSend.add(email);
            } 
           if (!emailsToSend.isEmpty()) {
            System.debug(emailsToSend);
          //Messaging(emailsToSend);
   }
}
    //11
    Public static void UpdatePhone(List<Account> triggerNew,Map<Id,Account>triggerNewMap,List<Account> triggerOld, Map<Id,Account> triggerOldMap){
        List<Account> accList = new List<Account>();
          for(Account acc : triggerNew)
          {
              if(acc.Phone == Null){
                  acc.Phone = '012345';
                  accList.add(acc);
                  System.debug(acc);
              }
          }
}
 
        Public static void UpdateWebsite(List<Account>triggerNew,Map<Id,Account>triggerNewMap,List<Account>triggerOld,Map<Id,Account>triggerOldMap){
        List<Account> UpdateAccount = new List<Account>();
        For(Account acc : triggerNew)
        {
            Account a  = triggerOldMap.get(acc.Id);
            if(a.Phone != acc.Phone){
                acc.Website= 'KnowledgeGainer.com';
                UpdateAccount.add(acc);
            }
        }
    }
    
    //12
    Public static void UpdateField3(List<Account>triggerNew,Map<Id,Account>triggerNewMap,List<Account>triggerOld,Map<Id,Account>triggerOldMap){
        set<Id> setAccOwner = new set<Id>();
        for(Account acc:triggerNew)
        {
            setAccOwner.add(Acc.OwnerId);
        }
        Map<Id,User> user_Map = new Map<Id,User>([SELECT Name FROM User WHERE Id IN: setAccOwner]);
        for(Account acc:triggerNew){
            User usr = user_Map.get(Acc.OwnerId);
            Acc.Sales_Rep__c = usr.Name;
        }
     }
}