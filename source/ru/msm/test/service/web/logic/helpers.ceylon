import ru.msm.test.service.data {
    Account
}
import ru.msm.test.service {
    log
}
import ru.msm.test.service.dao {
    openAccount,
    registerUrl,
    authenticate,
    getUrlForShort,
    getAccountStatistics
}
import ru.msm.test.service.web.utils {
    sendRedirect,
    sendOk,
    getPassword,
    getLogin,
    sendUnauthorized
}
import ru.msm.test.service.conversion {
    getJSon,
    parseRedirectTypeJSON,
    parseUrlJSON,
    parseAccountIdJSON,
    getStatisticsJSON,
    getShortURLJson
}
import ceylon.http.server {
    Request,
    Response
}
shared void processAccount(Request req, Response resp) {
    log.debug("processAccount");
    value accountId = parseAccountIdJSON(req.read());
    value passwordOrException = openAccount(accountId);
    value json = getJSon(passwordOrException);
    sendOk(resp, json);
}

shared void processRegister(Request req, Response resp) {
    value account = authorize(req);
    value json = req.read();
    value url = parseUrlJSON(json);
    value redirectType = parseRedirectTypeJSON(json);
    value shortUrl = registerUrl(account, url, redirectType);
    sendOk(resp, getShortURLJson(shortUrl));
}

shared void processStatistic(Request req, Response resp) {
    value account = authorize(req);
    //TODO
    //req.pathParameter("AccountId");
    value statisticsInfo = getAccountStatistics(account);
    sendOk(resp, getStatisticsJSON(statisticsInfo));
}

shared void processRedirect(Request req, Response resp) {
    log.debug("redirect");
    value shortUrl = req.uri;
    value url = getUrlForShort(shortUrl);
    url.incrementCount();
    sendRedirect(resp, url.url, url.redirectType);
}

Anything(Request, Response) wrapAuth(String(Account) fn) {
    void f(Request req, Response resp) {
        try {
            Account a = authorize(req);
            sendOk(resp, fn(a));
        } catch (Throwable ex) {
            sendUnauthorized(resp);
        }
    }
    return f;
}

Account authorize(Request req) {
    String login = getLogin(req);
    String password = getPassword(req);
    return authenticate(login, password);
}