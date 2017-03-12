import ceylon.json {
    parse,
    JSONObject = Object
}
shared String parseAccountIdJSON(String json) {
    print(json);
    value parsed = parse(json);
    assert(is JSONObject parsed);
    return parsed.getString("AccountId");
}

shared String parseUrlJSON(String json) {
    print(json);
    value parsed = parse(json);
    assert(is JSONObject parsed);
    return parsed.getString("url");
}

shared Integer parseRedirectTypeJSON(String json) {
    print(json);
    value parsed = parse(json);
    assert(is JSONObject parsed);
    return parsed.getIntegerOrNull("redirectType") else 302;
}