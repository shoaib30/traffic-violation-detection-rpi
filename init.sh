echo "Setting up traffic violation detector"

cd ~/

echo "Cloning repo"
git clone https://github.com/shoaib30/traffic-violation-detection-rpi
git clone https://github.com/shoaib30/traffic-violation-detector-acm
git clone https://github.com/shoaib30/traffic-violation-detector-cm
git clone https://github.com/shoaib30/traffic-violation-detection-ipm
git clone https://github.com/shoaib30/traffic-violation-detection-ccm

echo "Copying startup script to home directory"
cd traffic-violation-detection-rpi
cp startup.sh ~/
cp shutdown.sh ~/
cd ~/
chmod +x startup.sh
chmod +x shutdown.sh

for var in "$@"
do
    case $var in
        "-n")
            echo "Installing Node.js"
            curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
            sudo apt-get install -y nodejs
            cd traffic-violation-detection-ccm
            npm install 
            ;;
    esac
done

echo "Installing picamera"
sudo apt-get update > /dev/null
sudo apt-get install python-picamera

echo "Installing screen"
sudo apt-get install screen


