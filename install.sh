echo "Installing Purrooser..."

echo "Preparing..."
chmod +x configure
chmod +x Thoqfile

echo "Configuring..."
./configure
./Thoqfile

echo "Installing..."
sudo rm -rf /usr/local/bin/purrooser
chmod +x purrooser
sudo mv purrooser /usr/local/bin/

echo "Cleaning up..."
cd ~

echo "Done!"
echo "You can now use Purrooser by typing 'purrooser' in your terminal!"