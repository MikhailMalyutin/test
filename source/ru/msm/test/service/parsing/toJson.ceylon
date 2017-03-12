import ceylon.json {
    JsonObject
}
String getResultJson(Boolean success, String description, String password) {
    return JsonObject {
        "success" -> success.string,
        "description" -> description,
        "password" -> password
    }.pretty;
}

String getShortURLJson(String shortUrl) {
    return JsonObject {
        "shortUrl" -> shortUrl
    }.pretty;
}

String getStatisticsJSON([<String -> Integer>*] statistics) {
    return JsonObject(statistics).pretty;
}