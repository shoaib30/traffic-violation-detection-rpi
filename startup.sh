#/bin/bash

echo "Traffic Violation Detection"


for var in "$@"
do
    case $var in
        "-r")
            echo "Clearing previous screen session"
	    screen -X -S images quit
            screen -X -S acm quit
            screen -X -S ipm quit
            screen -X -S cm quit
            screen -X -S ccm quit
	    screen -X -S fi quit
            ;;
        "-c")
            echo "Clearing old logs"
            cd ~/traffic-violation-detector-acm
            rm screenlog.*
            cd ~/traffic-violation-detection-ipm
            rm screenlog.*
            cd ~/traffic-violation-detection-ccm
            rm screenlog.*
            cd ~/traffic-violation-detector-cm
            rm screenlog.*
	    cd ~/traffic-violation-detection-fi
	    rm screenlog.*
            ;;
        "-p")
            echo "Clearing old Images"
            cd ~/traffic-violation-detector-cm
            rm images/*
            #mkdir images
    esac
done


echo "Initializing Image Processing Module..."
cd ~/traffic-violation-detection-ipm
screen -dmSL ipm python app.py 

echo "Initializing Central Controller Module..."
cd ~/traffic-violation-detection-ccm
screen -dmSL ccm npm start

echo "Initializing Camera Module..."
cd ~/traffic-violation-detector-cm
screen -dmSL cm python app.py 
cd images
screen -dmSL images python -m SimpleHTTPServer

echo "Initializing Arduino Communication Module..."
cd ~/traffic-violation-detector-acm
sudo chmod 666 /dev/ttyACM0
screen -dmSL acm python main.py

echo "Initializing Failed Images Module..."
cd ~/traffic-violation-detection-fi
screen -dmSL fi nodejs index.js

echo "Traffic violation detection system started"
