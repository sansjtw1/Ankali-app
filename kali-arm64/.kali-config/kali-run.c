#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <errno.h>
#include <sys/stat.h>
#include <unistd.h>

// 设置颜色
#define RED "\033[0;31m"
#define GREEN "\033[0;32m"
#define YELLOW "\033[1;33m"
#define NC "\033[0m" // 无颜色

// 设置符号
#define ERROR "[-]"
#define SUCCESS "[+]"
#define INFO "[*]"

// 日志目录和文件
#define LOG_DIR "/.kali-config/log"
#define CONFIG_FILE "/.kali-config/Ankali.conf"
#define LANGUAGE_CONF "/.kali-config/language.conf"

// 获取当前日期字符串
void get_current_date(char *buffer, size_t size) {
    time_t t = time(NULL);
    struct tm *tm_info = localtime(&t);
    strftime(buffer, size, "%Y-%m-%d", tm_info);
}

// 记录日志信息
void log_message(const char *message) {
    char log_file_path[512];
    char current_date[11];
    get_current_date(current_date, sizeof(current_date));
    snprintf(log_file_path, sizeof(log_file_path), "%s/%s.log", LOG_DIR, current_date);

    FILE *log_file = fopen(log_file_path, "a");
    if (log_file == NULL) {
        perror("Error opening log file");
        return;
    }

    fprintf(log_file, "%s\n", message);
    fclose(log_file);
}

// 读取配置项
char* read_config_value(const char *file_path, const char *key) {
    static char value[256];
    FILE *file = fopen(file_path, "r");
    if (file == NULL) {
        perror("Error opening config file");
        return NULL;
    }

    char line[512];
    while (fgets(line, sizeof(line), file) != NULL) {
        if (strncmp(line, key, strlen(key)) == 0) {
            char *eq = strchr(line, '=');
            if (eq) {
                strncpy(value, eq + 1, sizeof(value));
                value[strcspn(value, "\n")] = '\0'; // 移除换行符
                fclose(file);
                return value;
            }
        }
    }

    fclose(file);
    return NULL;
}

// 更新配置项
int update_config_value(const char *file_path, const char *key, const char *new_value) {
    FILE *file = fopen(file_path, "r+");
    if (file == NULL) {
        perror("Error opening config file");
        return -1;
    }

    char line[512];
    long pos;
    while (fgets(line, sizeof(line), file) != NULL) {
        if (strncmp(line, key, strlen(key)) == 0) {
            pos = ftell(file);
            fseek(file, pos - strlen(line), SEEK_SET);
            fprintf(file, "%s=%s\n", key, new_value);
            fclose(file);
            return 0;
        }
    }

    fprintf(file, "%s=%s\n", key, new_value); // 若key不存在，添加新key
    fclose(file);
    return 0;
}

// 显示条约信息
void show_treaty() {
    printf("使用前请详细阅读，如果你使用此软件则默认同意以下条约(点击链接跳转):\n");
    printf("Please read it carefully before using it. If you use this software, you agree to the following treaties by default(Click the link to jump):\n");
    printf("- 免责声明: https://gitee.com/sansjtw/Ankali-app/blob/master/免责声明.md\n");
    printf("- 隐私条约: https://gitee.com/sansjtw/Ankali-app/blob/master/隐私条约.md\n");
    printf("- Disclaimer: https://github.com/sansjtw1/Ankali-app/blob/master/Disclaimer.md\n");
    printf("- Privacy Policy: https://github.com/sansjtw1/Ankali-app/blob/master/Privacy%%20Policy.md\n\n");

    printf("我已阅读，回车继续\n");
    printf("I've read it. Go back and continue.\n");
    getchar(); // 等待用户按回车
}

// 初始化语言选择
void initialize_language() {
    char choice;
    while (1) {
        log_message(INFO " INITIALIZATION is false or unknown. Asking user for language selection.");

        printf(YELLOW INFO " Please select language:" NC "\n");
        printf("y) English\n");
        printf("n) 简体中文\n");
        printf("Choose (y/n): ");
        choice = getchar();
        getchar(); // 清理输入缓冲区

        if (choice == 'y') {
            log_message(SUCCESS " User selected English.");
            printf(GREEN SUCCESS " User selected English." NC "\n");
            update_config_value(LANGUAGE_CONF, "LANG", "en_US.UTF-8");
            update_config_value(LANGUAGE_CONF, "LANGUAGE", "en_US:en");
            log_message(INFO " Language configuration written to " LANGUAGE_CONF ".");

            update_config_value(CONFIG_FILE, "INITIALIZATION", "true");
            update_config_value(CONFIG_FILE, "LANGUAGE", "EN");
            log_message(SUCCESS " INITIALIZATION set to true, LANGUAGE set to EN.");

            // 执行英文脚本
            system("/.kali-config/kali_conf");
            break;
        } else if (choice == 'n') {
            log_message(SUCCESS " User selected Chinese.");
            printf(GREEN SUCCESS " User selected Chinese." NC "\n");
            update_config_value(LANGUAGE_CONF, "LANG", "zh_CN.UTF-8");
            update_config_value(LANGUAGE_CONF, "LANGUAGE", "zh_CN:zh:en_US:en");
            log_message(INFO " Language configuration written to " LANGUAGE_CONF ".");

            update_config_value(CONFIG_FILE, "INITIALIZATION", "true");
            update_config_value(CONFIG_FILE, "LANGUAGE", "CN");
            log_message(SUCCESS " INITIALIZATION set to true, LANGUAGE set to CN.");

            // 执行中文脚本
            system("/.kali-config/kali_conf_cn");
            break;
        } else {
            log_message(ERROR " Invalid selection. Please try again.");
            printf(RED ERROR " Invalid selection. Please try again." NC "\n");
        }
    }
}

int main() {
    // 确保日志目录存在
    if (mkdir(LOG_DIR, 0755) != 0 && errno != EEXIST) {
        perror("Error creating log directory");
        return 1;
    }

    // 检查配置文件是否存在
    if (access(CONFIG_FILE, F_OK) != 0) {
        log_message(ERROR " Configuration file does not exist.");
        printf(RED ERROR " Configuration file does not exist." NC "\n");
        return 1;
    }

    // 读取 INITIALIZATION 配置
    char *initialization = read_config_value(CONFIG_FILE, "INITIALIZATION");
    if (initialization == NULL) {
        log_message(ERROR " Could not read INITIALIZATION from config file.");
        return 1;
    }

    log_message(INFO " Initial value of INITIALIZATION: ");
    log_message(initialization);

    if (strcmp(initialization, "false") == 0 || strlen(initialization) == 0) {
        show_treaty();
        initialize_language();
    } else if (strcmp(initialization, "true") == 0) {
        char *language = read_config_value(CONFIG_FILE, "LANGUAGE");
        if (language == NULL) {
            log_message(ERROR " LANGUAGE is unknown or missing. Resetting INITIALIZATION to false.");
            update_config_value(CONFIG_FILE, "INITIALIZATION", "false");
            return 1;
        }

        log_message(INFO " INITIALIZATION is true, LANGUAGE: ");
        log_message(language);

        if (strcmp(language, "EN") == 0) {
            log_message(INFO " Executing English script: /.kali-config/kali_conf");
            system("/.kali-config/kali_conf");
        } else if (strcmp(language, "CN") == 0) {
            log_message(INFO " Executing Chinese script: /.kali-config/kali_conf_cn");
            system("/.kali-config/kali_conf_cn");
        } else {
            log_message(ERROR " LANGUAGE is unknown or missing. Resetting INITIALIZATION to false.");
            update_config_value(CONFIG_FILE, "INITIALIZATION", "false");
        }
    } else {
        log_message(ERROR " INITIALIZATION configuration is invalid. Resetting to false.");
        update_config_value(CONFIG_FILE, "INITIALIZATION", "false");
    }

    return 0;
}


// ©Sansjtw Ankali
// Give yourself a gift for being 16 years old.🎁٩(^ᴗ^)۶