import ballerina/test;
import ballerina/io;

@test:Config {
}
function testCurrencyRate() {
    decimal rateResult = rate(USD, LKR, apiKey);
    io:println("USD to LKR rate:", rateResult);
}