#!/bin/bash

# URL das regras udev e do script usb-dirty-pages-udev
udev_rules_url="https://raw.githubusercontent.com/rgnldo/usb-dirty-pages-udev/main/etc/udev/rules.d/60-usb-dirty-pages-udev.rules"
usb_script_url="https://raw.githubusercontent.com/rgnldo/usb-dirty-pages-udev/main/usr/bin/usb-dirty-pages-udev"

# Local onde as regras udev e o script serão salvos
udev_rules_file="/etc/udev/rules.d/60-usb-dirty-pages-udev.rules"
usb_script_file="/usr/local/bin/usb-dirty-pages-udev"

# Baixar as regras udev
curl -o "$udev_rules_file" "$udev_rules_url"

# Verificar se o download das regras udev foi bem-sucedido
if [ $? -eq 0 ]; then
    echo "Regras udev baixadas com sucesso."
else
    echo "Erro ao baixar as regras udev. Verifique a conexão com a Internet ou tente novamente mais tarde."
    exit 1
fi

# Baixar o script usb-dirty-pages-udev
curl -o "$usb_script_file" "$usb_script_url"

# Verificar se o download do script foi bem-sucedido
if [ $? -eq 0 ]; then
    echo "Script usb-dirty-pages-udev baixado com sucesso."
else
    echo "Erro ao baixar o script usb-dirty-pages-udev. Verifique a conexão com a Internet ou tente novamente mais tarde."
    exit 1
fi

# Dar permissão de execução ao script usb-dirty-pages-udev
chmod +x "$usb_script_file"

# Aplicar as regras udev no sistema
udevadm control --reload-rules

# Verificar se a aplicação das regras udev foi bem-sucedida
if [ $? -eq 0 ]; then
    echo "Regras udev aplicadas com sucesso."
else
    echo "Erro ao aplicar as regras udev. Verifique as permissões ou tente novamente com privilégios de superusuário."
    exit 1
fi

echo "Configuração concluída com sucesso."
