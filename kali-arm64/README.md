# AnKali APP

## /kali-arm64 Directory

This directory simulates the path `/data/user/0/com.kalinr/kali-arm64`, and within the container, it corresponds to the path `/`. This directory mainly emulates the image file named kali-arm64. This file is obtained by uncompressing the compressed file `kali-arm64.tar.xz`, but due to Git's limitations, we cannot upload the complete image file, including the compressed file.

kali-arm64.tar.xz: On the /kali-arm64 directory, I have forged a `kali-arm64.tar.xz` image compressed file. Normally, the kali-arm64.tar.xz file should be placed under the `/data/user/0/com.kalinr/` directory, and after restarting AnKali, the file will automatically be uncompressed for you. The `kali-arm64.tar.xz` file should be placed at the full version link for AnKali:
https://github.com/sansjtw1/Ankali-app/releases/download/kali-arm64/kali-arm64.tar.xz

.kali-config: Simulates the path `/data/user/0/com.kalinr/kali-arm64/.kali-config`, and within the container, it corresponds to the path `/.kali-config`. `/.kali-config` mainly contains the logical scripts for AnKali, including the source code for the function menu, etc.

root: Simulates the path `/data/user/0/com.kalinr/kali-arm64/.kali-config`, and within the container, it corresponds to the path `/root`. This directory contains the `zsh` configuration files.