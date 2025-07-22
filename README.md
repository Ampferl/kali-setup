# Kali Setup
This is my setup to install a clean Kali VM the way I need it.

## Installation
I use private repositories containing a custom toolkit, as well as a collection of my notes, scripts, binaries and payloads.
To clone them, I use the following command to copy the SSH keys for my GitHub:
```shell
echo "echo \"$(cat ~/.ssh/id_ed25519|base64 -w 0)\"|base64 -d > ~/.ssh/id_ed25519\necho \"$(cat ~/.ssh/id_ed25519.pub|base64 -w 0)\"|base64 -d > ~/.ssh/id_ed25519.pub"|copy
``` 
Then I have to paste the commands in my clipboard in the kali machine.

Just run this to setup the system:
```shell
git clone https://github.com/Ampferl/kali-setup.git /tmp/kali-setup && cd /tmp/kali-setup && bash ./install.sh
```

## Credits
This kali setup is based on the [xct/kali-clean](https://github.com/xct/kali-clean) github repository.

