global class MathService {
    
    global class AccountWrapper {
        webservice String name;
        webservice String type;
    }
    
    static webservice String createAccount(AccountWrapper acc) {
        Account a = new Account();
        a.name = acc.name;
        insert a;
        return a.Id;
    }
    
    static webservice Decimal add(Decimal a, Decimal b) {
        return a + b;
    }
}