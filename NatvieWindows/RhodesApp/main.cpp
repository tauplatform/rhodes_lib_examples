#include <iostream>
#include <rhodeslib.h>
#include <Windows.h>

#include <mutex>
#include <condition_variable>

#include <curl/curl.h>
#include <WinInet.h>

std::mutex waitGuard;
std::condition_variable waitVar;


size_t writefunc(const char* in, size_t size, size_t num, std::string* out)
{
    const std::size_t totalBytes(size * num);
    out->append(in, totalBytes);
    return totalBytes;
}

int main(int argc, unsigned char* argv[])
{
    char path[MAX_PATH] = { 0 };
    GetCurrentDirectoryA(MAX_PATH, path);
    std::string current_path(path);
    std::string m_strRootPath = current_path;
    m_strRootPath += "/rho/";

    rholib_init(m_strRootPath, m_strRootPath, m_strRootPath, m_strRootPath, "", "", false);

    std::unique_lock<std::mutex> lock(waitGuard);

    class InitTest : public rho::ruby::IRunnable
    {
    public:
        std::string result;
        InitTest() {}

        void run()
        {
            result = executeRubyMethodWithJSON("Model1", "fillModelByPredefinedSet", nullptr);
        }
    } InitTask;

    class Test1 : public rho::ruby::IRunnable
    {
    public:
        std::string result;
        Test1() {}

        void run()
        {
            result = executeRubyMethodWithJSON("Model1", "receiveAllItemAsArrayOfHashesWithParams",
                "[{\"key1_array\":[\"param_array1_item1_string_value\",\"param_array1_item2_string_value\"],\"key2_integer\":1234567,\"key3_bool\":true},0.123450]");
            waitVar.notify_one();
        }
    } Test1Task;

    executeInRubyThread(&InitTask);
    executeInRubyThread(&Test1Task);
    waitVar.wait(lock);

    CURL *curl;
    CURLcode res;
    std::string response;
    std::string url = getRubyServerURL();
    std::string request = url + "/app/Model1/get_first_item_field_by_name?fieldName=attr1";

    curl = curl_easy_init();
    if (curl) {
        
        curl_easy_setopt(curl, CURLOPT_URL, request.c_str());
        curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, writefunc);
        curl_easy_setopt(curl, CURLOPT_WRITEDATA, &response);
        res = curl_easy_perform(curl);
        if (res != CURLE_OK)
            fprintf(stderr, "curl_easy_perform() failed: %s\n",
                curl_easy_strerror(res));


        curl_easy_cleanup(curl);
    }

    std::cout << "test1 : " << InitTask.result << std::endl;
    std::cout << "test2 : " << Test1Task.result << std::endl;
    std::cout << "test3 : " << response << std::endl;

    return 0;
}