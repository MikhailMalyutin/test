import ceylon.json {
    parse,
    JSONObject = Object
}
shared String parseAccountIdJSON(String json) {
    value parsed = parse(json);
    assert(is JSONObject parsed);
    return parsed.getString("AccountId");
}