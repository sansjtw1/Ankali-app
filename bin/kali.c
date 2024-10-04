// Copyright (c) 2024 Ankli SansJtw
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//
// Email: sansjtw@163.com, sansjtw1@gmail.com
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/stat.h>

#define RED "\033[0;31m"
#define GREEN "\033[0;32m"
#define YELLOW "\033[0;33m"
#define BLUE "\033[0;34m"
#define NC "\033[0m" // No Color

int check_and_create_dir(const char *dir_path) {
    struct stat st = {0};
    if (stat(dir_path, &st) == -1) {
        printf(YELLOW "tmp directory does not exist, creating tmp directory...\n" NC);
        if (mkdir(dir_path, 0700) == -1) {
            perror(RED "Failed to create tmp directory" NC);
            return 1;
        }
    }
    return 0;
}

int run_command(const char *command) {
    int ret = system(command);
    if (ret != 0) {
        printf(RED "Command failed: %s\n" NC, command);
    }
    return ret;
}

int file_exists(const char *filename) {
    return access(filename, F_OK) != -1;
}

int titles() {
    printf (RED" __________________________________________ \n");
    printf (GREEN"|    _            _  __    _    _     ___  |\n");
    printf (GREEN"|   / \\   _ __   | |/ /   / \\  | |   |_ _| |\n");
    printf (GREEN"|  / _ \\ | '_ \\  | ' /   / _ \\ | |    | |  |\n");
    printf (GREEN"| / ___ \\| | | | | . \\  / ___ \\| |___ | |  |\n");
    printf (GREEN"|/_/   \\_\\_| |_| |_|\\_\\/_/   \\_\\_____|___| |\n");
    printf (BLUE"|++++++++++++++++++An kail+++++++++++++++++|\n");
    printf ("|                                          |\n");
    printf (YELLOW"| https://github.com/sansjtw1/Ankali-app   |\n");
    printf (YELLOW"| https://gitee.com/sansjtw/Ankali-app     |\n");
    printf ("|                                          |\n");
    printf (RED" ------------------------------------------ \n");
    printf (YELLOW"\nAnkali Documentation: https://ankali-docs.netlify.app/");
    printf (YELLOW"\nAnkali 中文文档: https://ankali-docs.netlify.app/cn/");
    printf (YELLOW"\nEmail:\nsansjtw@163.com\nsansjtw1@gmail.com\n");
    return 0;
}

int main() {
    const char *base_dir = "/data/user/0/com.kalinr";
    const char *tmp_dir = "/data/user/0/com.kalinr/tmp";
    const char *proot_bin = "/data/user/0/com.kalinr/bin/proot";
    const char *tar_xz_file = "/data/user/0/com.kalinr/kali-arm64.tar.xz";
    const char *kali_dir = "/data/user/0/com.kalinr/kali-arm64";

    if (check_and_create_dir(tmp_dir)) return 1;

    setenv("PROOT_TMP_DIR", tmp_dir, 1);

    if (chdir(base_dir) != 0) {
        perror(RED "Cannot enter directory" NC);
        return 1;
    }

    if (!file_exists(proot_bin)) {
        printf(RED "proot file does not exist!\n" NC);
        return 1;
    }

    printf(GREEN "Starting kali Linux...\n" NC);

    char command[1024];

    // 解压 .xz 和 .tar 文件，使用单一进度条，并隐藏 tar 的详细日志
    if (file_exists(tar_xz_file)) {
        titles();
        printf(GREEN "Found %s, Begin compression and extraction....\n" NC, tar_xz_file);
        // 使用 pv 管道解压和提取 tar 内容，并隐藏 tar 的输出
        snprintf(command, sizeof(command), "pv %s | unxz | tar --no-same-owner -xvf - > /dev/null 2>&1 && rm %s", tar_xz_file,tar_xz_file);
        if (run_command(command)) return 1;
    } else if (!file_exists(kali_dir)) {
        printf(RED "No .tar.xz file or kali-arm64 directory found!\n" NC);
        return 1;
    }

    // 设置权限
    snprintf(command, sizeof(command), "chmod 777 -R %s/.kali-config", kali_dir);
    if (run_command(command)) return 1;

    // 进入循环处理 Ctrl+C 或 exit
    while (1) {
        // 运行 proot 命令
        snprintf(command, sizeof(command), 
                 "%s --link2symlink -0 -r %s -b /dev -b /proc -b %s/home:/dev/shm -w /root /usr/bin/env -i HOME=/root PATH=/usr/local/sbin:/usr/local/bin:/bin:/usr/bin:/sbin:/usr/sbin TERM=$TERM /.kali-config/kali-run", 
                 proot_bin, kali_dir, kali_dir);

        int ret = run_command(command);
        if (ret != 0) {
            printf(RED "Proot kali linux command failed or exited. Starting xonsh...\n" NC);
            // 启动 xonsh shell
            if (run_command("xonsh") != 0) {
                printf(RED "Failed to start xonsh shell. Exiting...\n" NC);
                break;
            }
        }

        // 提问用户是否重新启动 proot
        char choice;
        printf(YELLOW "Do you want to restart kali linux? (y/n): " NC);
        scanf(" %c", &choice);
        if (choice != 'y' && choice != 'Y') {
            // 用户选择不重启，进入 xonsh
            printf(GREEN "Entering xonsh shell...\n" NC);
            run_command("xonsh");
            break;
        }
    }

    return 0;
}
