# AnKali APP

Ankali App is a tool that creates an isolated "chroot" environment using PRoot on Android devices without requiring root access. It allows you to run a Kali Linux environment on a non-Linux system.

![phone](picture/phone.png)

## Software Information

Ankali does not depend on other applications like Termux because it is an Android terminal emulator application itself.

- Package Name: `com.kalinr`
- Minimum SDK: 14
- Target SDK: 28

## Download AnKali APK

[Google drive](https://drive.google.com/drive/folders/1REO9a_jtFE65XNc5nu0sY4mTp_pVH5Qh?usp=drive_link)

[GitHub Download](https://github.com/sansjtw1/Ankali-app/releases)

[123pan](https://www.123pan.com/s/QSZRVv-rGH43)

[baidupan](https://pan.baidu.com/s/1m6pYDJavd45Cler6B9DkbA ) 提取码:1234
## About the Application Source Code

Interested in the app source code? The program actually runs scripts within TermOne Plus, and our repository only stores the script files and configuration logic files.

- **TermOne Plus Official Website**: [https://termoneplus.com/](https://termoneplus.com/)
- **TermOne Plus Open Source Repository (GitLab)**: [https://gitlab.com/termapps/termoneplus/](https://gitlab.com/termapps/termoneplus/)

>"TermOne Plus" is an Android application that turns your Android device into a computer terminal. It is useful for accessing the command line shell (built into every Android phone) or using a custom one (installed separately).

## Important Notes

1. **Memory Requirement**: This application will extract the Kali image file during initial use, which will occupy approximately 2GB of phone storage after extraction. Please ensure your device has enough memory, or even more.

2. **Privacy**: The app does not collect any personal information, but third-party packages used by the program might. For more details, you can check the "Privacy Policy" in the repository.

3. **Usage Requirements**: Best suited for Android version 7.0 and above, ideally Android 11. If your Android version is too low or too high or unsupported by your device, it may result in issues including but not limited to `app crashes`, `failed extraction`, `unusable packages`, `system commands not working`. Please ensure your device supports this app.

4. **No Root Required**: The software uses PRoot to simulate running the Kali environment and does not require root access.
>PRoot is a user-space implementation of chroot, mount --bind, and binfmt_misc. This means that users don't need any privileges or setup to do things like using an arbitrary directory as the new root filesystem, making files accessible somewhere else in the filesystem hierarchy, or executing programs built for another CPU architecture transparently through QEMU user-mode. Also, developers can use PRoot as a generic Linux process instrumentation engine thanks to its extension mechanism, see CARE for an example. Technically PRoot relies on ptrace, an unprivileged system-call available in every Linux kernel.

5. **Feedback**: For any issues or feedback, you can report them on GitHub.

## References and Credits

- **App Icon Source**: [Wikimedia Commons File:Kali-dragon-icon.svg](https://commons.m.wikimedia.org/wiki/File:Kali-dragon-icon.svg)
- **Android Terminal Emulator Based On**: [TermOne Plus](https://termoneplus.com/)
- **Referenced Some Files from Tome**: [Tome](https://github.com/2moe/tmoe)
- **Precompiled PRoot Program**: [build-proot-android](https://github.com/green-green-avk/build-proot-android)

## Ankali Debug Mode

![Debug Mode](picture/test.png)

Start the debug menu from outside the container using the command:
```
kali-test
```

### Features:

1. ***Backup kali-arm64***: Helps you repackage the image file `kali-arm64` into `kali-arm64.tar.xz`. After packaging, it is recommended to move it directly to another local folder; otherwise, the app will extract it again upon restart.

2. ***Download kali-arm64 from GitHub***: Useful for when the image file is corrupted or needs resetting. When using this feature, ensure a smooth network connection and sufficient memory; the program will automatically extract it for you.

3. ***Reset Configuration File***: Helps you reset the Ankali configuration (only the Ankali configuration files, not the Kali Linux system configuration files).

4. ***Start Kali Linux***: Helps you start the container.

5. ***Start Xonsh***: Allows you to use the terminal outside the container.

## Additional Feedback
Perhaps your question is on Wikipedia, you can go and check:
https://github.com/sansjtw1/Ankali-app/wiki

You can ask your questions directly on the GitHub issue page, or contact me via email:
- sansjtw@163.com
- sansjtw1@gmail.com