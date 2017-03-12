import ceylon.uri {
    Uri,
    Path,
    PathSegment,
    Authority
}
import ceylon.http.client {
    Request,
    Response
}
import ceylon.http.common {
    post,
    Header
}
import ceylon.json {
    JsonObject
}
import ceylon.test {
    test
}
import ru.msm.test.service.utils {
    toShort,
    generatePassword
}
import ru.msm.test.service.config {
    serverName,
    serverPort
}
Uri getUrl(String? login, String? password, String* paths) {
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

String getit(Uri uri, String json) {
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

test
shared void itShouldProduceShortUrls() {
    value short
            = toShort("http://stackoverflow.com/questions/1567929/website-safe-dataaccess-architecture-question?rq=1");
    print(short);
}

test
shared void itShouldGenerateRandomPasswords() {
    value password
            = generatePassword();
    print(password);
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