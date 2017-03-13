import ceylon.json {
    JsonObject
}
import ru.msm.test.service.utils {
    encodeToBase64
}
import ru.msm.test.service.config {
    serverPort,
    serverName
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

shared String getBasicAuthHeader(String login, String password) {
    value stringToEncode = "``login``:``password``";
    value base64 = encodeToBase64(stringToEncode);
    return "Basic ``base64``";
}

shared String getShortURLJson(String shortUrl) {
    return JsonObject {
        "shortUrl" -> "http://``serverName``:``serverPort````shortUrl``"
    }.pretty;
}

shared String getStatisticsJSON([<String -> Integer>*] statistics) {
    return JsonObject(statistics).pretty;
}