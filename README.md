# EndeavourOS setup for greetd and ReGreet
<img width="1277" height="804" alt="regreet-eos-arc-dark" src="https://github.com/user-attachments/assets/b36feb91-7495-4a88-a545-c892e51ba961" />

## Manual setup
```
# install needed packages
sudo pacman -S greetd greetd-regreet cage
# copy configs into system
sudo wget -q https://raw.githubusercontent.com/killajoe/eos-greetd-regreet/refs/heads/main/config.toml -O /etc/greetd/config.toml
sudo wget -q https://raw.githubusercontent.com/killajoe/eos-greetd-regreet/refs/heads/main/regreet.toml -O /etc/greetd/regreet.toml
# fix user groups for greeter user
sudo usermod -aG video,render greeter
# Ensure the greeter user can read the config
sudo chown -R greeter:greeter /etc/greetd/
# Enable the greetd.service to launch greeter each boot
sudo systemctl -f enable greetd.service
```
