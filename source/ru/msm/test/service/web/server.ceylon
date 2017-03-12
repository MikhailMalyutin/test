import net.gyokuro.core {
    get,
    Application,
    post
}
import ru.msm.test.service.parsing {
    parseAccountIdJSON
}
import ru.msm.test.service.dao {
    openAccount,
    authenticate
}
import ceylon.http.server {
    Request,
    Response
}
import ru.msm.test.service.data {
    Account
}
import ceylon.http.common {
    Header
}

void processAccount(Request req, Response resp) {
    value accountId = parseAccountIdJSON(req.string);
    value res = openAccount(accountId);
}

void processRegister(Request req, Response resp) {
    value accountId = parseAccountIdJSON(req.string);
    value res = openAccount(accountId);
}

void processStatistic(Request req, Response resp) {
    value accountId = parseAccountIdJSON(req.string);
    value res = openAccount(accountId);
}

String getLogin(Request req) => nothing;
String getPassword(Request req) => nothing;

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

shared void startHttpServer() {
    post("/account", processAccount);
    post("/register", (req, resp) => "Hello, world!");
    get("/statistic/:AccountId", (req, resp) => "Hello, world!");
    Application().run();
}