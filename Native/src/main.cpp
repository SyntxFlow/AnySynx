#include <iostream>
#include <string>
#include <curl/curl.h>

extern "C" {

    // buffer hasil response
    static std::string response_data;

    // callback libcurl
    size_t write_callback(void* contents, size_t size, size_t nmemb, void* userp) {
        size_t total = size * nmemb;
        response_data.append((char*)contents, total);
        return total;
    }

    // fungsi yang dipanggil Dart
    const char* fetch_api(const char* url) {
        CURL* curl = curl_easy_init();
        if (!curl) return "error: curl init";

        response_data.clear();

        curl_easy_setopt(curl, CURLOPT_URL, url);
        curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, write_callback);

        CURLcode res = curl_easy_perform(curl);

        curl_easy_cleanup(curl);

        if (res != CURLE_OK) {
            return "error: request failed";
        }

        return response_data.c_str();
    }
}