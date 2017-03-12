import ceylon.json {
    parse,
    JSONObject = Object
}
import ru.msm.test.service {
    log
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

shared Integer parseRedirectTypeJSON(String json) {
    log.debug(json);
    value parsed = parse(json);
    assert(is JSONObject parsed);
    return parsed.getIntegerOrNull("redirectType") else 302;
}