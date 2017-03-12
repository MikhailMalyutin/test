import ceylon.uri {
    Uri,
    Path,
    PathSegment,
    Authority
}
import ceylon.http.client {
    Request,
    Response,
    get
}
import ceylon.http.common {
    post
}
import ceylon.json {
    JsonObject,
    parse
}
Uri getUrl(String? login, String? password, String* paths) {
    value uri = Uri {
        scheme = "http";
        authority = Authority {
            host = "0.0.0.0";
            user = login;
            password = password;
            port = 8080;
        };
        path = Path {
            segments = [PathSegment("")].chain(paths.map( (n) => PathSegment(n) )).sequence();
        };
    };
    return uri;
}

String getit(Uri uri, String json) {
    Request request = Request {
        method = post;
        uri = uri;
        data = json;
    };
    Response response = request.execute();
    return response.contents;
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