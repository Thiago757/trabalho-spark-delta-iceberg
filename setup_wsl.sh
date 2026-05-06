#!/usr/bin/env bash
# Script de setup do ambiente Python para Engenharia de Dados (SATC)
# Execute UMA VEZ no shell WSL: bash setup_wsl.sh

set -e

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PYTHON_VERSION="3.12.3"

echo "=============================================="
echo " Setup: Python para Engenharia de Dados"
echo " SATC — 5ª Fase — Engenharia de Software"
echo "=============================================="
echo ""

# ── 1. Dependências de build do sistema ──────────────────────────────────────
echo "[1/6] Instalando dependências de build..."
sudo apt-get update -qq
sudo apt-get install -y -qq \
    git curl wget build-essential \
    libssl-dev zlib1g-dev libbz2-dev \
    libreadline-dev libsqlite3-dev llvm \
    libncursesw5-dev xz-utils tk-dev \
    libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev \
    openjdk-17-jdk-headless
echo "   OK"

# ── 2. Pyenv ─────────────────────────────────────────────────────────────────
echo "[2/6] Instalando pyenv..."
if [ ! -d "$HOME/.pyenv" ]; then
    curl -fsSL https://pyenv.run | bash
else
    echo "   pyenv já instalado, atualizando..."
    cd "$HOME/.pyenv" && git pull -q && cd -
fi

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Adiciona ao .bashrc (idempotente)
if ! grep -q 'pyenv init' "$HOME/.bashrc"; then
    cat >> "$HOME/.bashrc" << 'EOF'

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
EOF
    echo "   pyenv adicionado ao .bashrc"
fi

# Instala Python se necessário
if ! pyenv versions | grep -q "$PYTHON_VERSION"; then
    echo "   Instalando Python $PYTHON_VERSION (pode demorar alguns minutos)..."
    pyenv install "$PYTHON_VERSION"
fi
pyenv global "$PYTHON_VERSION"
echo "   OK — Python $(python --version)"

# ── 3. pipx ──────────────────────────────────────────────────────────────────
echo "[3/6] Instalando pipx..."
pip install --user pipx -q
python -m pipx ensurepath

if ! grep -q 'pipx' "$HOME/.bashrc" 2>/dev/null; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
fi
export PATH="$HOME/.local/bin:$PATH"
echo "   OK — $(pipx --version)"

# ── 4. uv ────────────────────────────────────────────────────────────────────
echo "[4/6] Instalando uv via pipx..."
pipx install uv 2>/dev/null || pipx upgrade uv
echo "   OK — $(uv --version)"

# ── 5. ignr ──────────────────────────────────────────────────────────────────
echo "[5/6] Instalando ignr via pipx..."
pipx install ignr 2>/dev/null || pipx upgrade ignr
echo "   OK"

# ── 6. Dependências do projeto ───────────────────────────────────────────────
echo "[6/6] Instalando dependências do projeto com uv sync..."
cd "$PROJECT_DIR"
pyenv local "$PYTHON_VERSION"
uv sync --all-groups
echo "   OK"

echo ""
echo "=============================================="
echo " Setup concluído!"
echo "=============================================="
echo ""
echo " IMPORTANTE: Feche e reabra o terminal WSL"
echo " para carregar o pyenv e pipx no PATH."
echo ""
echo " Depois, teste com:"
echo "   cd \"$PROJECT_DIR\""
echo "   uv run task test"
echo "   uv run task lint"
echo "   uv run python trabalho_spark_iceberg/main.py"
echo "=============================================="
