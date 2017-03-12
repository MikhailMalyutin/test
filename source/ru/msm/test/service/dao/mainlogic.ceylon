import ru.msm.test.service.data {
    Account,
    Url
}
import ru.msm.test.service.utils {
    generatePassword
}
import ru.msm.test.service.web.utils {
    RedirectCode
}
shared String|Exception openAccount(String accountId) {
    value prevAccount = getAccount(accountId);
    if (exists prevAccount) {
        return Exception("Account with ``accountId`` is exists");
    }
    value newAccount = Account(accountId, generatePassword());
    addAccount(newAccount);
    return newAccount.password;
}

shared Account authenticate(String accountId, String password) {
    value prevAccount = getAccount(accountId);
    assert (exists prevAccount);
    assert (prevAccount.password == password);
    return prevAccount;
}

shared String registerUrl(
        Account account,
        String url,
        RedirectCode redirectType) {
    return account.register(url, redirectType);
}

shared [<String -> Integer>*] getAccountStatistics(Account account) {
    return account.getUrlsInfo()
        .map((Url url) => url.url -> url.count)
        .sequence();
}