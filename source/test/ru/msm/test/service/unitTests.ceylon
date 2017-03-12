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