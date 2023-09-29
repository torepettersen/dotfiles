# dotfiles

## Post install

```
# Install dependencies Solus
sudo eopkg upgrade -y
sudo eopkg install -y git curl fish neovim bat ripgrep fd dbeaver insomnia
sudo eopkg install -c system.devel

# Install dependencies Arch
yay -S fish neovim bat ripgrep fd dbeaver rtx-bin insomina-bin
chsh -S /bin/fish

# Erlang dependencies
yay -S ncurses glu mesa wxwidgets-gtk3 libpng libssh libxslt fop
KERL_BUILD_DOCS=yes rtx install erlang

# Setup git
git config --global user.name "Tore Pettersen"
git config --global user.email "toreskog@live.com"

# Setup docker
sudo systemctl enable docker.service
sudo systemctl start docker.service
sudo groupadd docker
sudo usermod -aG docker $USER

# Start postgres
sudo systemctl enable postgresql
sudo systemctl start postgresql

# Clone dotfiles
git init
git remote add origin git@github.com:torepettersen/dotfiles.git
git pull origin master
```

## Set Postgres password
	
1. Run the psql command from the postgres user account:
  ```
  sudo -u postgres psql postgres
  ```
2. Set the password:
  ```
  \password postgres
  ```
3. Enter a password
4. Close psql:
  ```
  \q
  ```

## Issues 

### Solus won't install
Solus might have problem on reinstall. Partitions might have to be deleted. Worst case use dd.

### Dbeaver looks wierd
Dbeaver dosen't look that nice with default Solus theme. Can be fixed by changing Solus theme.
