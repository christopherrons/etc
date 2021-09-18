# Update
sudo apt-get update
sudo apt install git

# Install Z shell, Oh My z Shell + plugins
sudo apt-get install zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
sudo git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions 
sudo git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting 
# Add to zshrc file
#plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
#ZSH_THEME="af-magic"

# Install Java, Maven and Python
sudo apt-get install openjdk-11-jdk
sudo apt-get install maven

# Install Intellij and Pycharm
sudo snap install intellij-idea-community --classic
sudo snap install intellij-idea-ultimate --classic
sudo snap install pycharm-community --classic

# Install Guake
sudo apt-get install guake

# Install Spotify
sudo snap install spotify
