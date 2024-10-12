#!/bin/bash

# Diretório onde o código será clonado
APP_DIR="/home/luiz/project"

# URL do repositório GIT (use SSH ou token pessoal)
GIT_REPO="git@github.com:usuario/repositorio.git" # ou use o token

# Parar o processo Flask que está rodando (caso exista)
echo "Parando o processo Flask existente..."
pkill -f main.py

# Navegar para o diretório do app
cd "$APP_DIR" || exit

# Verificar se o diretório já está versionado
if [ -d "$APP_DIR/.git" ]; then
    echo "Atualizando o repositório existente..."
    git pull
else
    echo "Clonando o repositório..."
    git clone "$GIT_REPO" "$APP_DIR"
fi

# Criar e ativar o ambiente virtual se não existir
if [ ! -d "devops" ]; then
    python3 -m venv devops
fi
source devops/bin/activate

# Instalar as dependências
pip install flask flask-cors

# Iniciar a aplicação
echo "Iniciando aplicação..."
nohup python3 main.py --host=0.0.0.0 &
