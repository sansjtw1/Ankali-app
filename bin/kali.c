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

int main() {
    const char *base_dir = "/data/user/0/com.kalinr";
    const char *tmp_dir = "/data/user/0/com.kalinr/tmp";
    const char *proot_bin = "/data/user/0/com.kalinr/bin/proot";
    const char *tar_xz_file = "/data/user/0/com.kalinr/kali-arm64.tar.xz";
    const char *tar_file = "/data/user/0/com.kalinr/kali-arm64.tar";
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

    // Decompress .xz file if exists
    if (file_exists(tar_xz_file)) {
        printf(GREEN "Found %s, decompressing...\n" NC, tar_xz_file);
        snprintf(command, sizeof(command), "unxz %s", tar_xz_file);
        if (run_command(command)) return 1;
    }

    // Decompress .tar file if exists
    if (file_exists(tar_file)) {
        printf(GREEN "Found %s, decompressing...\n" NC, tar_file);
        snprintf(command, sizeof(command), "tar --no-same-owner -xvf %s", tar_file);
        if (run_command(command)) return 1;
        // Delete .tar file
        snprintf(command, sizeof(command), "rm %s", tar_file);
        if (run_command(command)) return 1;
    } else if (!file_exists(kali_dir)) {
        printf(RED "No .tar file or kali-arm64 directory found!\n" NC);
        return 1;
    }

    // Set permission
    snprintf(command, sizeof(command), "chmod 777 -R %s/.kali-config", kali_dir);
    if (run_command(command)) return 1;

    // Add language configuration to .zshrc
    snprintf(command, sizeof(command), "grep -q \"source /.kali-config/language.conf\" %s/root/.zshrc || echo \"source /.kali-config/language.conf\" >> %s/root/.zshrc", kali_dir, kali_dir);
    if (run_command(command)) return 1;

    // Run proot command
    snprintf(command, sizeof(command), 
             "%s --link2symlink -0 -r %s -b /dev -b /proc -b %s/home:/dev/shm -w /root /usr/bin/env -i HOME=/root PATH=/usr/local/sbin:/usr/local/bin:/bin:/usr/bin:/sbin:/usr/sbin TERM=$TERM /.kali-config/kali-run", 
             proot_bin, kali_dir, kali_dir);
    return run_command(command);
}

