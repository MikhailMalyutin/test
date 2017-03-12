import java.lang {
    JString = String
}
import java.security {
    MessageDigest
}
import ceylon.buffer.base {
    base64StringStandard
}
import java.util {
    Base64
}
shared String generatePassword() => "12345"; //TODO
shared String toShort(String url) {
    value jstr = JString(url);
    MessageDigest md = MessageDigest.getInstance("MD5");
    value thedigest = md.digest(jstr.getBytes("UTF-8"));
    return Base64.encoder.encodeToString(thedigest);
}