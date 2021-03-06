import java.lang {
    JString = String
}
import java.security {
    MessageDigest
}
import java.util {
    Base64,
    UUID
}
import ru.msm.test.service.config {
    defaultPasswordLenght
}
shared String generatePassword() {
    value uuid = UUID.randomUUID().string;
    value pass = toMD5Base64(uuid).substring(0, defaultPasswordLenght);
    return pass;
}

shared String toShort(String url) {
    value md5b64 = toMD5Base64(url);
    return "/``md5b64``";
}

String toMD5Base64(String str) {
    value jstr = JString(str);
    MessageDigest md = MessageDigest.getInstance("MD5");
    value thedigest = md.digest(jstr.getBytes("UTF-8"));
    return Base64.encoder.encodeToString(thedigest);
}

shared String decodeBase64Str(String base64) {
    return JString(Base64.decoder.decode(base64), "UTF-8").string;
}

shared String encodeToBase64(String str) {
    value jstr = JString(str);
    return Base64.encoder.encodeToString(jstr.getBytes("UTF-8"));
}