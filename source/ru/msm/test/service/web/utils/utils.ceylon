import ceylon.http.server {
    Response,
    Request
}
import ceylon.http.common {
    Header
}

shared void sendOk(Response resp, String str) {
    resp.status = 200;
    resp.addHeader(Header("Content-Type", "application/json" ));
    resp.writeString(str);
}

shared void sendUnauthorized(Response resp) {
    resp.status = 401;
    resp.writeString("Unauthorized");
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