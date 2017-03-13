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
    Header,
    get
}
import ru.msm.test.service.conversion {
    getBasicAuthHeader
}
import ceylon.json {
    parse,
    JsonObject = Object
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

shared String getit(Uri uri, String? json = null) {
    value method = if (exists json) then post else get;
    value password = uri.authority.password;
    value login = uri.authority.user;
    value initialHeaders =
            if (exists login, exists password)
            then [Header("Authorization", getBasicAuthHeader(login, password))]
            else [];
    Request request = Request {
        method = method;
        uri = uri;
        data = json;
        dataContentType = "application/json";
        initialHeaders = initialHeaders;
    };
    Response response = request.execute();
    return response.contents;
}

shared String parsePassword(String json) {
    value jsonObj = parse(json);
    assert(is JsonObject jsonObj);
    return jsonObj.getString("password");
}