echo "Cloning Required Plugins"

git clone -q --depth 1 https://github.com/wbthomason/packer.nvim\
  ~/.local/share/nvim/site/pack/packer/start/packer.nvim

nvim -c 'PackerSync'
