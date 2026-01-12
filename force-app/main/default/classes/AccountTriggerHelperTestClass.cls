@isTest
public class AccountTriggerHelperTestClass {
  @testSetup 
  Public static void methodName() {
   	 String addError = 'You cannot Delete the account record';
      Account a = new Account();
     a.Name = 'Chirag';
     a.AccountSource='Partner Referral';
     a.Account_Region__c='dfgh';
     a.Type = 'Installation Partner'; 
     a.CopyBillingToShipping__c = true;
     a.Website = 'KnowledgeGainer.com'; 
     a.Number_of_Locations__c = 1;
     a.Phone = '1234';
     insert a;
      Account a1 = new Account();
      a1.Name = 'Chirag';
      a1.AccountSource='Partner Referral';
      a1.Account_Region__c='dfgh';
      try{
          insert a1;
          
      }Catch(Exception e){
        //System.debug('Create a duplicate Account'); 
        System.assertEquals('You cannot Delete the account record',addError); 
      }
     Contact conObj = new Contact(AccountId = a.id,FirstName ='Test',LastName ='Contact',Email ='Test@gmail.com');
     insert conObj;
  }
    @IsTest
    Static void AccountCreation(){
    Account acc = [SELECT Id ,Name FROM Account WHERE Name = 'Mr.Chirag' LIMIT 1];
        try{
          delete acc;  
        }
        Catch(Exception e){
            System.debug('You cannot Delete the account record');
            System.assertEquals('Mr.Chirag',acc.Name,'You cannot Delete the account record');
        }
    }
    
    @isTest
    static void UpdateAccount(){
      Account acc2 = [SELECT Name,Type FROM Account WHERE Type = 'Installation Partner' LIMIT 1];
        acc2.Name = '2';
        Update acc2;
        System.assertEquals('Installation Partner',acc2.Type,'You have Update the value of Type');
    }
    @isTest
    Static void DeleteContact(){
        Contact con=[SELECT Id, FirstName,LastName FROM Contact WHERE LastName='Contact'];
        try{
            delete con;
        }
        catch(Exception e){
            //System.debug('Delete Contact');
            System.assertEquals('TestContact',con.Name,'You have Delete the Contact');
        }
    }
    @isTest
    static void UpdateWebsite(){
        Account acc3 = [SELECT Name, Website, Phone FROM Account WHERE Website = 'KnowledgeGainer.com' LIMIT 1];
        acc3.Phone = '156879';
        acc3.Name = 'piyush';
        Update acc3;
        System.assertEquals('KnowledgeGainer.com',acc3.Website,'You have Update the Phone with website automatically');
    }
}