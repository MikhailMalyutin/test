import ru.msm.test.service.data {
    Account,
    Url
}
import ceylon.collection {
    HashMap
}
HashMap<String, Account> idToAccountMap = HashMap<String, Account>();
HashMap<String, Url> shortToUrlMap = HashMap<String, Url>();

shared void addAccount(Account account) {
    idToAccountMap.put(account.accountId, account);
}

shared Account? getAccount(String accountId) {
    return idToAccountMap.get(accountId);
}

shared void registerShortUrl(String shortUrl, Url url) {
    shortToUrlMap.put(shortUrl, url);
}

shared Url getUrlForShort(String shortUrl) {
    value urlInfo = shortToUrlMap.get(shortUrl);
    assert(exists urlInfo);
    return urlInfo;
}