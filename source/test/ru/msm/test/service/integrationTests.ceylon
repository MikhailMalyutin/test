import ceylon.json {
    JsonObject
}
import test.ru.msm.test.service.utils {
    getUrl,
    getit
}

shared void testAll() {
    value accountURI = getUrl(null, null, "account");
    value accountId = "myAccountId";
    value registerURI = getUrl(accountId, "12345", "register");
    print(registerURI);
    value passwordJSON = getit(accountURI, "{ \"AccountId\" : \"``accountId``\"}");
    print(passwordJSON);
    value content = getit(registerURI,
        JsonObject {
            "url" -> "http://stackoverflow.com/questions/1567929/website-safe-dataaccess-architecture-question?rq=1",
            "redirectType" -> 301}.pretty);
    print(content);
}