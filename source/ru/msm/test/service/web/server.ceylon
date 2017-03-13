import ru.msm.test.service.dao {
    openAccount,
    authenticate,
    registerUrl,
    getAccountStatistics,
    getUrlForShort
}
import ceylon.http.server {
    Request,
    Response,
    newServer,
    Endpoint,
    startsWith,
    equals
}
import ru.msm.test.service.data {
    Account
}
import ceylon.http.common {
    post,
    get
}
import ceylon.io {
    SocketAddress
}
import ru.msm.test.service.config {
    serverName,
    serverPort
}
import ru.msm.test.service {
    log
}
import ru.msm.test.service.web.utils {
    wrapLogErrors,
    sendOk,
    sendUnauthorized,
    getLogin,
    getPassword,
    sendRedirect
}
import ru.msm.test.service.conversion {
    parseUrlJSON,
    parseRedirectTypeJSON,
    getShortURLJson,
    getStatisticsJSON,
    parseAccountIdJSON,
    getJSon
}

void processAccount(Request req, Response resp) {
    log.debug("processAccount");
    value accountId = parseAccountIdJSON(req.read());
    value passwordOrException = openAccount(accountId);
    value json = getJSon(passwordOrException);
    sendOk(resp, json);
}

void processRegister(Request req, Response resp) {
    try {
        value account = authorize(req);
        value json = req.read();
        value url = parseUrlJSON(json);
        value redirectType = parseRedirectTypeJSON(json);
        value shortUrl = registerUrl(account, url, redirectType);
        sendOk(resp, getShortURLJson(shortUrl));
    } catch (Throwable ex) {
        log.error(ex.message, ex);
        throw ex;
    }
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

void processStatistic(Request req, Response resp) {
    value account = authorize(req);
    value accountId = req.pathParameter("AccountId");
    assert (exists accountId);
    value statisticsInfo = getAccountStatistics(account);
    sendOk(resp, getStatisticsJSON(statisticsInfo));
}

void processRedirect(Request req, Response resp) {
    log.debug("redirect");
    value shortUrl = req.uri;
    value url = getUrlForShort(shortUrl);
    url.incrementCount();
    sendRedirect(resp, url.url, url.redirectType);
}

Account authorize(Request req) {
    String login = getLogin(req);
    String password = getPassword(req);
    return authenticate(login, password);
}

shared void startHttpServer() {
    value server = newServer {
        Endpoint {
            path = equals("/account");
            wrapLogErrors(processAccount);
            acceptMethod = [post];
        },
        Endpoint {
            path = equals("/register");
            wrapLogErrors(processRegister);
            acceptMethod = [post];
        },
        Endpoint {
            path = startsWith("/statistic");
            wrapLogErrors(processRegister);
            acceptMethod = [get];
        },
        Endpoint {
            path = startsWith("/");
            wrapLogErrors(processRedirect);
            acceptMethod = [get];
        }
    };
    server.start(SocketAddress(serverName, serverPort));
}