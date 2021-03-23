import ballerina/io;
import ballerina/http;

http:Client currencyConvertEndpoint = check new("https://free.currconv.com/api/v7/convert");

# Description
#
# + 'from - Currency to be converted from
# + to - Parameter Description
# + apiKey - API Key
# + return - Return Value Description  
function rate(Currency 'from, Currency to, string apiKey) returns decimal {
    string fromCurrency = 'from;
    string toCurrency = to;
    string responseKey = fromCurrency + "_" + toCurrency;

    io:println("Requesting rates from "+ fromCurrency + " to " + toCurrency);

    http:Response|http:ClientError response = currencyConvertEndpoint->get(getParamUrlString(fromCurrency, toCurrency, apiKey));

    if response is http:Response {
        json|http:ClientError jsonPayload = response.getJsonPayload();
        if (jsonPayload is map<json>) {
            do {
                json rateJson = jsonPayload[responseKey];
                decimal val = check decimal:fromString(rateJson.toString());
                io:println(fromCurrency + ":" + val.toString());
                return val;
            } on fail error e {
                io:println("Error occured while reading response", e);
            }
        }
    }
    return -1;
}


# Retruns a invocable url accepted by currency convert api in format of 
# https://free.currconv.com/api/v7/convert?q=`toCurrency`_`fromCurrency`&compact=ultra&apiKey=<KEY>
# 
# + toCurrency - Currecy to be converted to
# + fromCurrency - Currency to be converted from
# + return - Return query param populated url
function getParamUrlString(string fromCurrency, string toCurrency, string apiKey) returns string {
    return "?q=" + fromCurrency + "_" + toCurrency + "&compact=ultra&apiKey=" + apiKey;
}
