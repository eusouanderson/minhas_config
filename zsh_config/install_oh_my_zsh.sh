#!/bin/bash
set -e

CONFIG_DIR="$(pwd)" # diretório atual (onde está o repo)
ZSH_DIR="$HOME/.oh-my-zsh"
CUSTOM_SRC="$CONFIG_DIR/zsh_config/custom"
CUSTOM_DEST="$ZSH_DIR/custom"

echo "🚀 Iniciando instalação das configs ZSH..."

# 1. Instala oh-my-zsh se não existir
if [ ! -d "$ZSH_DIR" ]; then
  echo "📦 Instalando oh-my-zsh..."
  RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "✔ oh-my-zsh já está instalado."
fi

# 2. Instala Powerlevel10k se não existir
if [ ! -d "${ZSH_DIR}/custom/themes/powerlevel10k" ]; then
  echo "📦 Instalando Powerlevel10k..."
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_DIR}/custom/themes/powerlevel10k"
else
  echo "✔ Powerlevel10k já está instalado."
fi

# 3. Cria symlinks para .zshrc e .p10k.zsh
echo "🔗 Criando symlinks..."
ln -sf "$CONFIG_DIR/zsh_config/.zshrc" "$HOME/.zshrc"
ln -sf "$CONFIG_DIR/zsh_config/.p10k.zsh" "$HOME/.p10k.zsh"

# 4. Copia custom configs se existirem
if [ -d "$CUSTOM_SRC" ]; then
  echo "📂 Copiando custom configs para oh-my-zsh..."
  cp -r "$CUSTOM_SRC"/* "$CUSTOM_DEST"
else
  echo "ℹ Nenhuma pasta custom encontrada em $CUSTOM_SRC"
fi

echo "✅ Instalação concluída!"
echo "👉 Reinicie o terminal ou rode 'exec zsh' para aplicar."

