import ceylon.json {
    JsonObject
}
String getResultJson(Boolean success, String description, String? password) {
    return JsonObject {
        "success" -> success.string,
        "description" -> description,
        "password" -> password
    }.pretty;
}

shared String getJSon(String|Exception data) {
    value success = if (is String data) then true else false;
    value description = if (is String data) then "Your account is opened" else data.message;
    value password = if (is String data) then data else null;
    return getResultJson(success, description, password);
}

shared String getShortURLJson(String shortUrl) {
    return JsonObject {
        "shortUrl" -> shortUrl
    }.pretty;
}

shared String getStatisticsJSON([<String -> Integer>*] statistics) {
    return JsonObject(statistics).pretty;
}