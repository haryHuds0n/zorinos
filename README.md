
# Zorin OS Setup Script

Bash script to automate setup zorin OS with minimum requirent for develop can work with.

The following software will be setup

- Vscode
- Google Chrome
- Postman
- Zulip
- Telegram
- Teams

![Image](https://i.imgur.com/Aa4E14u.png)

## Reference
 - [Bash](https://linux.die.net/man/1/bash)
 - [Vscode Installation](https://code.visualstudio.com/docs/setup/linux)
 - [Google Chrome](https://support.google.com/chrome/a/answer/9025903?hl=en)
 - [Postman](https://www.postman.com/downloads/)
 - [Zulip Linux Installation](https://zulip.com/help/desktop-app-install-guide)
 - [Telegram](https://desktop.telegram.org/)


## How to run

**Note**
- Bash script will automate setup all above software for current user only. If you have multiple user, you have to run it multiple time, each time with different.user.

1. Clone the repo
    ```bash
    git clone https://github.com/haryHuds0n/zorinos.git
    ```

2. Mark script executable
    ```bash
    chmod +x setup.sh
    ```

3. Run the script to start
    ```bash
    ./setup.sh
    ```