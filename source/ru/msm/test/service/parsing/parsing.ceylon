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