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
Uri getUrl(String* paths) {
    value uri = Uri {
        scheme = "http";
        authority = Authority {
            host = "0.0.0.0";
            port = 8080;
        };
        path = Path {
            segments = [PathSegment("")].chain(paths.map( (n) => PathSegment(n) )).sequence();
        };
    };
    return uri;
}

shared void testAll() {
    String getit(Uri uri, String json) {
        Request request = Request {
            method = post;
            uri = uri;
            data = json;
        };
        Response response = request.execute();
        return response.contents;
    }

    value uri = getUrl("account");
    print(uri);
    value content = getit(uri, """{ "AccountId" : "myAccountId1"}""");
    print(content);
}