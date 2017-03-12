import ceylon.http.server {
    Response,
    Request
}
import ceylon.http.common {
    Header
}
import ru.msm.test.service {
    log
}

shared abstract class HttpCode(shared Integer code) of ok | unauthorized | movedPermanently | found {}
shared object found extends HttpCode(302) {}
shared object movedPermanently extends HttpCode(301) {}
shared object unauthorized extends HttpCode(401) {}
shared object ok extends HttpCode(200) {}

shared void sendOk(Response resp, String str) {
    resp.status = ok.code;
    resp.addHeader(Header("Content-Type", "application/json" ));
    resp.writeString(str);
}

shared void sendUnauthorized(Response resp) {
    resp.status = unauthorized.code;
    resp.writeString("Unauthorized");
}

shared void sendRedirect(Response resp, String url, HttpCode redirectStatus) {
    resp.status = redirectStatus.code;
    resp.writeString(url);
}

shared Anything(Request, Response) wrapLogErrors(Anything(Request, Response) fn) {
    void f(Request req, Response resp) {
        try {
            fn(req, resp);
        } catch (Throwable ex) {

            throw ex;
        }
    }
    return f;
}

shared String getLogin(Request req) {
    log.debug("getLogin: ``req.queryString``");
    log.debug("Auth headers: ``req.header("Authorization") else ""``");
    return "myAccountId";
} //TODO

shared String getPassword(Request req) => "12345"; //TODO