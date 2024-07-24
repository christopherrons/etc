# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/christopher/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes


# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )
ZSH_THEME="af-magic"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias ohmyzsh="mate ~/.oh-my-zsh"
#source ~/versioned/configs/my-zshrc
alias pbcopy="xclip -selection clipboard"
alias pbpaste="xclip -selection clipboard -o"
alias ssh_pi="ssh pi@192.168.1.146" 


# Java
jdk_switch() {
    export JAVA_HOME=/usr/lib/jvm/jdk-"$1"
    export PATH=$PATH:$JAVA_HOME/bin
    java --version  
}
jdk_switch 17

update_common() {
  # Define the version to replace
  new_version="$1"
  start_dir=$(pwd)
  
  cd /home/christopher/dev/herron-project/herron-common-api
  ./gradlew publish -PreleaseVersion=$new_version 
  cd /home/christopher/dev/herron-project/
  
  # Function to replace the version in a file
  replace_version_in_file() {
      local file="$1"
      sed -i "s/library(\"common.api\", \"com.herron.exchange:common-api:[0-9.]*\")/library(\"common.api\", \"com.herron.exchange:common-api:$new_version\")/" "$file"
      sed -i "s/library(\"common\", \"com.herron.exchange:common:[0-9.]*\")/library(\"common\", \"com.herron.exchange:common:$new_version\")/" "$file"
  }

  # Recursively search for settings.gradle.kts files and replace the version
  find . -type f -name "settings.gradle.kts" | while read -r file; do
      replace_version_in_file "$file"
      echo "Version replaced with $new_version in $file"
  done

  cd "$start_dir"
}

update_integrations() {
  # Define the version to replace
  new_version="$1"
  start_dir=$(pwd)
  
  cd /home/christopher/dev/herron-project/herron-integration-api
  ./gradlew publish -PreleaseVersion=$new_version 
  cd /home/christopher/dev/herron-project/
  
  # Function to replace the version in a file
  replace_version_in_file() {
      local file="$1"
      sed -i "s/library(\"integration.api\", \"com.herron.exchange:integration-api:[0-9.]*\")/library(\"integration.api\", \"com.herron.exchange:integration-api:$new_version\")/" "$file"
      sed -i "s/library(\"integrations\", \"com.herron.exchange:integrations:[0-9.]*\")/library(\"integrations\", \"com.herron.exchange:integrations:$new_version\")/" "$file"
  }

  # Recursively search for settings.gradle.kts files and replace the version
  find . -type f -name "settings.gradle.kts" | while read -r file; do
      replace_version_in_file "$file"
      echo "Version replaced with $new_version in $file"
  done

  cd "$start_dir"
}

update_quantlib() {
  # Define the version to replace
  new_version="$1"
  start_dir=$(pwd)
  
  cd /home/christopher/dev/herron-project/herron-quantlib-api
  ./gradlew publish -PreleaseVersion=$new_version 
  cd /home/christopher/dev/herron-project/
  
  # Function to replace the version in a file
  replace_version_in_file() {
      local file="$1"
      sed -i "s/library(\"quantlib.api\", \"com.herron.exchange:quantlib-api:[0-9.]*\")/library(\"quantlib.api\", \"com.herron.exchange:quantlib-api:$new_version\")/" "$file"
      sed -i "s/library(\"quantlib\", \"com.herron.exchange:quantlib:[0-9.]*\")/library(\"quantlib\", \"com.herron.exchange:quantlib:$new_version\")/" "$file"
  }

  # Recursively search for settings.gradle.kts files and replace the version
  find . -type f -name "settings.gradle.kts" | while read -r file; do
      replace_version_in_file "$file"
      echo "Version replaced with $new_version in $file"
  done

  cd "$start_dir"
}

# Node
NODE_HOME="/usr/lib/nodejs/node-16"
PATH=$PATH:$NODE_HOME/bin

restart_kafka() {
    startDir=$(pwd)
    rm -rf /tmp/kraft-combined-logs
    cd "/home/christopher/Downloads/kafka_2.13-3.3.1"
    KAFKA_CLUSTER_ID="$(bin/kafka-storage.sh random-uuid)"
    bin/kafka-storage.sh format -t $KAFKA_CLUSTER_ID -c config/kraft/server.properties
    bin/kafka-server-start.sh config/kraft/server.properties
    cd "$startDir"
}

update_snapshot() {
startDir=$(pwd)
cd /home/christopher/dev/herron-project

# Iterate through subdirectories
for project_dir in */; do
    if [ -e "$project_dir/gradlew" ]; then
        # Change to the project directory
        cd "$project_dir"
        
        # Run the publishToMavenLocal task
        ./gradlew publishToMavenLocal
        
        # Return to the parent directory
        cd ..
    fi
done
cd "$startDir"
}

git_push_all() {
startDir=$(pwd)
cd /home/christopher/dev/herron-project

# Iterate through subdirectories
for project_dir in */; do
    if [ -e "$project_dir/gradlew" ]; then
        # Change to the project directory
        cd "$project_dir"
        
        # Run the publishToMavenLocal task
        gp
        
        # Return to the parent directory
        cd ..
    fi
done
cd "$startDir"
}

