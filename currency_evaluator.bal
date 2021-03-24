import ballerina/io;

configurable string & readonly apiKey = ?;

public function main() {
    io:println("Invoking currency converter");
    Currency comparisonCurrency = LKR;
    Currency[] inputCurrencyList = [EUR, USD, CHF, KYD, GIP, GBP, JOD, OMR, BHD, KWD];

    future<decimal> f1 = start rate(inputCurrencyList[0], comparisonCurrency, apiKey);
    future<decimal> f2 = start rate(inputCurrencyList[1], comparisonCurrency, apiKey);
    future<decimal> f3 = start rate(inputCurrencyList[2], comparisonCurrency, apiKey);
    future<decimal> f4 = start rate(inputCurrencyList[3], comparisonCurrency, apiKey);
    future<decimal> f5 = start rate(inputCurrencyList[4], comparisonCurrency, apiKey);
    future<decimal> f6 = start rate(inputCurrencyList[5], comparisonCurrency, apiKey);
    future<decimal> f7 = start rate(inputCurrencyList[6], comparisonCurrency, apiKey);
    future<decimal> f8 = start rate(inputCurrencyList[7], comparisonCurrency, apiKey);
    future<decimal> f9 = start rate(inputCurrencyList[8], comparisonCurrency, apiKey);
    future<decimal> f10 = start rate(inputCurrencyList[9], comparisonCurrency, apiKey);

    map<decimal> vals = wait {EUR: f1, USD: f2, CHF: f3, KYD: f4, GIP: f5, GBP: f6, JOD: f7, OMR: f8, BHD: f9, KWD: f10};

    io:println("Most valuable currency is " + findMaxValuedCurrency(vals));
}

# Finds the maximum valued currency
#
# + values - Currency conversion rate map
# + return - Return maximum valued currency key
function findMaxValuedCurrency(map<decimal> values) returns string {
    string maxKey = EUR;

    foreach string key in values.keys() {
        if (values.get(key) > values.get(maxKey)) {
            maxKey = key;
        }
    }
    return maxKey;
}


