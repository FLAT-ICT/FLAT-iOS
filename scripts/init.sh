git secrets --install
if [ $? -ne 0 ]; then
    echo 'git secretsをインストールして下さい'
fi
git secrets --add '[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}'
git secrets --list