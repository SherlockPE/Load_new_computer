#!/bin/bash

# Colores
BLACK='\033[0;30m'
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[0;37m'
BOLD='\033[1m'
UNDERLINE='\033[4m'
NC='\033[0m' # Sin color

# Función para preguntar al usuario
preguntar() {
    while true; do
        read -p "$1 [Y/N]: " yn
        case $yn in
            [Yy]* ) return 0;;
            [Nn]* ) return 1;;
            * ) echo -e "${RED}Por favor responda Y o N.${NC}";;
        esac
    done
}

# Cargar variables del archivo .env
if [ -f .env ]; then
    export $(cat .env | xargs)
else
    echo -e "${RED}No se encontró el archivo .env.${NC}"
    echo -e "${RED}Por favor cree un archivo .env con las variables USER_NAME y USER_EMAIL.${NC}"
    exit 1
fi

sudo apt update
sudo apt upgrade -y

# Instalar Git
if preguntar "¿Desea instalar Git?"; then
    echo -e "${GREEN}Instalando Git...${NC}"
    sudo apt install -y git
    echo -e "${GREEN}Git instalado.${NC}"
    echo -e "${GREEN}Configurando Git...${NC}"
    git config --global user.name "$USER_NAME"
    git config --global user.email "$USER_EMAIL"
else
    echo -e "${YELLOW}Git no será instalado.${NC}"
fi

# Instalar Brave Browser
if preguntar "¿Desea instalar Brave Browser?"; then
    echo -e "${ORANGE}Instalando Brave Browser...${NC}"
    sudo apt update
    sudo apt install -y apt-transport-https curl
    curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
    sudo apt update
    sudo apt install -y brave-browser
    echo -e "${ORANGE}Brave Browser instalado.${NC}"
else
    echo -e "${YELLOW}Brave Browser no será instalado.${NC}"
fi

# Instalar Zsh
if preguntar "¿Desea instalar Zsh?"; then
    echo -e "${CYAN}Instalando Zsh...${NC}"
    sudo apt update
    sudo apt install -y zsh
    echo -e "${CYAN}Zsh instalado.${NC}"
else
    echo -e "${YELLOW}Zsh no será instalado.${NC}"
fi

# Configurar Zsh como terminal por defecto
if preguntar "¿Hola Fabi del futuro, quieres configurar Zsh como la terminal por defecto?"; then
    echo -e "${CYAN}Configurando Zsh como la terminal por defecto...${NC}"
    chsh -s $(which zsh)
    echo -e "${CYAN}Zsh configurado como la terminal por defecto.${NC}"
else
    echo -e "${YELLOW}Zsh no será configurado como la terminal por defecto.${NC}"
fi

# Instalar Visual Studio Code
if preguntar "¿Desea instalar Visual Studio Code?"; then
    echo -e "${BLUE}Instalando Visual Studio Code...${NC}"
    sudo apt update
    sudo apt install -y software-properties-common apt-transport-https wget
    wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
    sudo apt update
    sudo apt install -y code
    echo -e "${BLUE}Visual Studio Code instalado.${NC}"
else
    echo -e "${YELLOW}Visual Studio Code no será instalado.${NC}"
fi

# Instalar Slack
if preguntar "¿Desea instalar Slack?"; then
    echo -e "${PURPLE}Instalando Slack...${NC}"
    sudo apt update
    sudo snap install slack --classic
    echo -e "${PURPLE}Slack instalado.${NC}"
else
    echo -e "${YELLOW}Slack no será instalado.${NC}"
fi

# Copiando la carpeta wallpapers dentro de ~/Pictures
echo -e "${CYAN}Copiando la carpeta wallpapers dentro de ~/Pictures${NC}"
cp -r Wallpapers ~/Pictures


# Instalar Telegram
if preguntar "¿Desea instalar Telegram?"; then
    echo -e "${BLUE}Instalando Telegram...${NC}"
    sudo apt update
    sudo snap install telegram-desktop
    echo -e "${BLUE}Telegram instalado.${NC}"
else
    echo -e "${YELLOW}Telegram no será instalado.${NC}"
fi

# Generar llaves SSH
if preguntar "¿Desea generar llaves SSH?"; then
    echo -e "${GREEN}Generando llaves SSH...${NC}"
    ssh-keygen
    echo -e "${GREEN}Llaves SSH generadas.${NC}"
    echo "Tu clave pública es:"
    echo "{YELLOW}"
    cat ~/.ssh/id_rsa.pub
    echo "{NC}"
else
    echo -e "${YELLOW}Llaves SSH no serán generadas.${NC}"
fi

echo -e "${MAGENTA}Script completado.${NC}"