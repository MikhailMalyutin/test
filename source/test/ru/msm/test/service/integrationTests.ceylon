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

    value uri = Uri {
        scheme = "http";
        authority = Authority {
            host = "0.0.0.0";
            port = 8080;
        };
        path = Path {
            segments = [PathSegment(""),PathSegment("account")];
        };
    };
    print(uri);
    value content = getit(uri, """{ "AccountId" : "myAccountId"}""");
    print(content);
}