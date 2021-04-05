# dotfiles

## Post install

```
# Install dependencies
sudo eopkg upgrade
sudo eopkg install git curl alacritty bat ripgrep postgresql postgresql-contrib dbeaver insomnia byobu 
sudo eopkg install -c system.devel

# Setup git
git config --global user.name "Tore Pettersen"
git config --global user.email "toreskog@live.com"

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
