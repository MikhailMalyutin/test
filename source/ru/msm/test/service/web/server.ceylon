import ru.msm.test.service.parsing {
    parseAccountIdJSON,
    getJSon,
    parseUrlJSON,
    parseRedirectTypeJSON,
    getShortURLJson,
    getStatisticsJSON
}
import ru.msm.test.service.dao {
    openAccount,
    authenticate,
    registerUrl,
    getAccountStatistics
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
    Header,
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

void processAccount(Request req, Response resp) {
    print("processAccount");
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
        ex.printStackTrace();
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
    print("redirect");
}

String getLogin(Request req) {
    print("getLogin: ``req.queryString``");
    print("Auth headers: ``req.header("Authorization") else ""``");
    return "myAccountId";
} //TODO
String getPassword(Request req) => "12345"; //TODO

Account authorize(Request req) {
    String login = getLogin(req);
    String password = getPassword(req);
    return authenticate(login, password);
}

void sendOk(Response resp, String str) {
    resp.status = 200;
    resp.addHeader(Header("Content-Type", "application/json" ));
    resp.writeString(str);
}

void sendUnauthorized(Response resp) {
    resp.status = 401;
    resp.writeString("Unauthorized");
}

shared void startHttpServer() {
    value server = newServer {
        Endpoint {
            path = equals("/account");
            processAccount;
            acceptMethod = [post];
        },
        Endpoint {
            path = equals("/register");
            processRegister;
            acceptMethod = [post];
        },
        Endpoint {
            path = startsWith("/statistic");
            processRegister;
            acceptMethod = [get];
        },
        Endpoint {
            path = startsWith("/");
            processRedirect;
            acceptMethod = [get];
        }
    };
    server.start(SocketAddress(serverName, serverPort));
}