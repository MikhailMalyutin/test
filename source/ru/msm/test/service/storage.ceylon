import ceylon.collection {
    HashMap
}
import java.util.concurrent.atomic {
    AtomicInteger
}

String toShort(String url) => "";

shared class Account(shared String accountId, shared String password) {
    HashMap<String, Url> urlToInfoMap = HashMap<String, Url>();

    shared String register(String url) {
        value shortUrl = toShort(url);
        value newUrl = Url(url, shortUrl);
        urlToInfoMap.put(url, newUrl);
        return newUrl.shortUrl;
    }

    shared {Url*} getUrlsInfo() {
        return urlToInfoMap.items;
    }
}

shared class Url(shared String url, shared String shortUrl) {
    shared AtomicInteger count = AtomicInteger();
}

HashMap<String, Account> idToAccountMap = HashMap<String, Account>();

shared Account? getAccount(String accountId) {
    return idToAccountMap.get(accountId);
}

shared void addAccount(Account account) {
    idToAccountMap.put(account.accountId, account);
}
