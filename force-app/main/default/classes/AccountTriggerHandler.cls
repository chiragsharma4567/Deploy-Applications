public class AccountTriggerHandler {
    public static void beforeInsert(List<Account>triggerNew,Map<Id,Account>triggerNewMap, List<Account>triggerOld, Map<Id,Account>triggerOldMap){
       AccountTriggerHelper.addPrefixAsMr(triggerNew,triggerNewMap,triggerOld,triggerOldMap);
       AccountTriggerHelper.DupliAccount(triggerNew,triggerNewMap,triggerOld,triggerOldMap);
       AccountTriggerHelper.CopyAddress(triggerNew,triggerNewMap,triggerOld,triggerOldMap);
       AccountTriggerHelper.UpdateField(triggerNew,triggerNewMap,triggerOld,triggerOldMap);
       AccountTriggerHelper.UpdateField3(triggerNew,triggerNewMap,triggerOld,triggerOldMap);
       
    }
   
    public static void beforeUpdate(List<Account>triggerNew,Map<Id,Account>triggerNewMap, List<Account>triggerOld, Map<Id,Account>triggerOldMap){
      AccountTriggerHelper.DupliAccount(triggerNew,triggerNewMap,triggerOld,triggerOldMap);
      AccountTriggerHelper.CopyAddress(triggerNew,triggerNewMap,triggerOld,triggerOldMap);
       AccountTriggerHelper.UpdatePhone(triggerNew,triggerNewMap,triggerOld,triggerOldMap);
       AccountTriggerHelper.UpdateField3(triggerNew,triggerNewMap,triggerOld,triggerOldMap);
       AccountTriggerHelper.UpdateWebsite(triggerNew,triggerNewMap,triggerOld,triggerOldMap);
    }
    public static void beforeDelete(List<Account>triggerNew,Map<Id,ACcount>triggerNewMap, List<Account>triggerOld, Map<Id,ACcount>triggerOldMap){
        AccountTriggerHelper.DeleteAccount(triggerNew,triggerNewMap,triggerOld,triggerOldMap);
    }
    public static void afterInsert(List<Account>triggerNew,Map<Id,Account>triggerNewMap, List<Account>triggerOld, Map<Id,Account>triggerOldMap){
        AccountTriggerHelper.createContactByAccount(triggerNew,triggerNewMap,triggerOld,triggerOldMap);
        AccountTriggerHelper.CreateContactonAccount(triggerNew,triggerNewMap,triggerOld,triggerOldMap);
        AccountTriggerHelper.CreateContact(triggerNew,triggerNewMap,triggerOld,triggerOldMap);
    }
    public static void afterUpdate(List<Account>triggerNew,Map<Id,Account>triggerNewMap, List<Account>triggerOld, Map<Id,Account>triggerOldMap){
        AccountTriggerHelper.createContactByAccount(triggerNew,triggerNewMap,triggerOld,triggerOldMap);
        AccountTriggerHelper.UpdateFieldType(triggerNew,triggerNewMap,triggerOld,triggerOldMap);
        AccountTriggerHelper.Updateaccount(triggerNew,triggerNewMap,triggerOld,triggerOldMap);
        
    }
    public static void afterDelete(List<Account>triggerNew,Map<Id,Account>triggerNewMap, List<Account>triggerOld, Map<Id,Account>triggerOldMap){
       
    }
    public static void afterUndelete(List<Account>triggerNew,Map<Id,Account>triggerNewMap, List<Account>triggerOld, Map<Id,Account>triggerOldMap){
       
    }
}