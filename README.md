# EndeavourOS setup for greetd and ReGreet

```
# install needed packages
sudo pacman -S greetd greetd-regreet cage
# copy configs into system
wget -q "$GREETD_CONF_URL" -O /etc/greetd/config.toml
wget -q "$REGREET_CONF_URL" -O /etc/greetd/regreet.toml
# fix user groups for greeter user
usermod -aG video,render greeter
# Ensure the greeter user can read the config
chown -R greeter:greeter /etc/greetd/
# Enable the greetd.service to launch greeter each boot
systemctl enable greetd.service
```