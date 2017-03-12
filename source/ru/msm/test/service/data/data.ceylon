import java.util.concurrent.atomic {
    AtomicInteger
}
import ceylon.collection {
    HashMap
}
import ru.msm.test.service.utils {
    toShort
}

shared class Url(shared String url, shared String shortUrl) {
    AtomicInteger countAtomic = AtomicInteger();
    shared Integer count => countAtomic.get();
}

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