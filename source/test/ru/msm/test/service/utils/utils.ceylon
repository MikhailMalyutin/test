import ceylon.uri {
    PathSegment,
    Path,
    Uri,
    Authority
}
import ceylon.http.client {
    Response,
    Request
}
import ru.msm.test.service.config {
    serverPort,
    serverName
}
import ceylon.http.common {
    post,
    Header
}
shared Uri getUrl(String? login, String? password, String* paths) {
    value uri = Uri {
        scheme = "http";
        authority = Authority {
            host = serverName;
            user = login;
            password = password;
            port = serverPort;
        };
        path = Path {
            segments = [PathSegment("")].chain(paths.map( (n) => PathSegment(n) )).sequence();
        };
    };
    return uri;
}

shared String getit(Uri uri, String json) {
    Request request = Request {
        method = post;
        uri = uri;
        data = json;
        dataContentType = "application/json";
        initialHeaders = [Header("Authorization", "Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==")];
    };
    Response response = request.execute();
    return response.contents;
}