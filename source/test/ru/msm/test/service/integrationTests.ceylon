import ceylon.json {
    JsonObject,
    parse
}
import test.ru.msm.test.service.utils {
    getUrl,
    getit,
    parsePassword
}

shared void testAll() {
    value accountURI = getUrl(null, null, "account");
    value accountId = "myAccountId1";
    value passwordJSON = getit(accountURI, "{ \"AccountId\" : \"``accountId``\"}");
    print(passwordJSON);
    value registerURI = getUrl(accountId, parsePassword(passwordJSON), "register");
    print(registerURI);
    value content = getit(registerURI,
        JsonObject {
            "url" -> "http://stackoverflow.com/questions/1567929/website-safe-dataaccess-architecture-question?rq=1",
            "redirectType" -> 302}.pretty);
    print(content);
}