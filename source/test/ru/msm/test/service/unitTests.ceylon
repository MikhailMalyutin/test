import ceylon.test {
    test,
    assertEquals,
    assertNotEquals
}
import ru.msm.test.service.utils {
    toShort,
    generatePassword
}
import ru.msm.test.service.config {
    defaultPasswordLenght
}
import ru.msm.test.service.conversion {
    parseLoginPassword
}
test
shared void itShouldProduceShortUrls() {
    value short
            = toShort("http://stackoverflow.com/questions/1567929/website-safe-dataaccess-architecture-question?rq=1");
    print(short);
    assertEquals(short, "http://localhost:8080/NGfUq0cMuYszcTy7e+dowA==");
}

test
shared void itShouldGenerateRandomPasswords() {
    value password
            = generatePassword();
    print(password);
    assertEquals(password.size, defaultPasswordLenght);
    assertNotEquals(password, generatePassword());
}

test
shared void itShouldParseBasicAuthHeader() {
    value login -> password = parseLoginPassword("Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==");
    assertEquals(login, "Aladdin");
    assertEquals(password, "open sesame");
}