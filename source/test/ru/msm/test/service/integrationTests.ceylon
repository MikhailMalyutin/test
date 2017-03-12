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
    value accountURI = getUrl("account");
    value registerURI = getUrl("register");
    value passwordJSON = getit(accountURI, """{ "AccountId" : "myAccountId"}""");
    print(passwordJSON);
    value content = getit(registerURI,
        """ {
             url: 'http://stackoverflow.com/questions/1567929/website-safe-dataaccess-architecture-question?rq=1',
             redirectType : 301
            }""");
    print(content);
}