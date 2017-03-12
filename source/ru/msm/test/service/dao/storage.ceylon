import ru.msm.test.service.data {
    Account
}
import ceylon.collection {
    HashMap
}
HashMap<String, Account> idToAccountMap = HashMap<String, Account>();

shared void addAccount(Account account) {
    idToAccountMap.put(account.accountId, account);
}

shared Account? getAccount(String accountId) {
    return idToAccountMap.get(accountId);
}