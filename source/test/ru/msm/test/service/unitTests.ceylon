import ceylon.test {
    test
}
import ru.msm.test.service.utils {
    toShort,
    generatePassword
}
test
shared void itShouldProduceShortUrls() {
    value short
            = toShort("http://stackoverflow.com/questions/1567929/website-safe-dataaccess-architecture-question?rq=1");
    print(short);
}

test
shared void itShouldGenerateRandomPasswords() {
    value password
            = generatePassword();
    print(password);
}