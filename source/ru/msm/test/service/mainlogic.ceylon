String generatePassword() => "12345";

shared String|Exception openAccount(String accountId) {
    value prevAccount = getAccount(accountId);
    if (exists prevAccount) {
        return Exception("Account with ``accountId`` is exists");
    }
    value newAccount = Account(accountId, generatePassword());
    addAccount(newAccount);
    return newAccount.password;
}

Account authenticate(String accountId, String password) {
    value prevAccount = getAccount(accountId);
    assert (exists prevAccount);
    assert (prevAccount.password == password);
    return prevAccount;
}

shared String registerUrl(String accountId, String password, String url, Integer redirectType = 302) {
    value account = authenticate(accountId, password);
    return account.register(url);
}

shared [<String -> Integer>*] getAccountStatistics(String accountId, String password) {
    value account = authenticate(accountId, password);
    return account.getUrlsInfo().map((Url element) => element.url -> element.count.get()).sequence();
}