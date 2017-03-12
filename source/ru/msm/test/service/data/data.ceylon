import java.util.concurrent.atomic {
    AtomicInteger
}
import ceylon.collection {
    HashMap
}
import ru.msm.test.service.utils {
    toShort
}
import ru.msm.test.service.dao {
    registerShortUrl
}
import ru.msm.test.service.web.utils {
    HttpCode
}

shared class Url(shared String url, shared String shortUrl, shared HttpCode redirectType) {
    AtomicInteger countAtomic = AtomicInteger();
    shared Integer count => countAtomic.get();
    shared void incrementCount() {
        countAtomic.incrementAndGet();
    }
}

shared class Account(shared String accountId, shared String password) {
    HashMap<String, Url> urlToInfoMap = HashMap<String, Url>();

    shared String register(String url, HttpCode redirectType) {
        value shortUrl = toShort(url);
        value newUrl = Url(url, shortUrl, redirectType);
        urlToInfoMap.put(url, newUrl);
        registerShortUrl(shortUrl, newUrl);
        return newUrl.shortUrl;
    }

    shared {Url*} getUrlsInfo() {
        return urlToInfoMap.items;
    }
}