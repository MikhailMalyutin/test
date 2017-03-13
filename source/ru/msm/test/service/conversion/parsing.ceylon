import ceylon.json {
    parse,
    JSONObject = Object
}
import ru.msm.test.service {
    log
}
import ru.msm.test.service.web.utils {
    found,
    movedPermanently,
    RedirectCode
}
import ru.msm.test.service.utils {
    decodeBase64Str
}
shared String parseAccountIdJSON(String json) {
    log.debug(json);
    value parsed = parse(json);
    assert(is JSONObject parsed);
    return parsed.getString("AccountId");
}

shared String parseUrlJSON(String json) {
    log.debug(json);
    value parsed = parse(json);
    assert(is JSONObject parsed);
    return parsed.getString("url");
}

shared String -> String parseLoginPassword(String authorizationHeader) {
    value base64 = authorizationHeader.replace("Basic ", "");
    value encoded = decodeBase64Str(base64);
    value splitted = encoded.split(':'.equals);
    value login = splitted.first;
    value password = splitted.rest.first;
    assert(exists password);
    return login -> password;
}

shared RedirectCode parseRedirectTypeJSON(String json) {
    log.debug(json);
    value parsed = parse(json);
    assert(is JSONObject parsed);
    value redirectType = parsed.getIntegerOrNull("redirectType") else found.code;
    if (redirectType == movedPermanently.code) {
        return movedPermanently;
    }
    assert (redirectType == found.code);
    return found;
}