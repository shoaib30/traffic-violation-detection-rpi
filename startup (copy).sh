#/bin/bash

echo "Traffic Violation Detection"


for var in "$@"
do
    case $var in
        "-r")
            echo "Clearing previous screen session"
            screen -X -S ipm quit
            screen -X -S cm quit
            screen -X -S ccm quit
            ;;
        "-c")
            echo "Clearing old logs"
            cd ~/traffic-violation-detection-ipm
            rm screenlog.0
            cd ~/traffic-violation-detection-ccm
            rm screenlog.0
            cd ~/traffic-violation-detector-cm
            rm screenlog.0
            ;;
    esac
done


echo "Initializing Image Processing Module..."

cd ~/traffic-violation-detection-ipm
screen -dmSL ipm flask/bin/python app.py 

echo "Initializing Central Controller Module..."
cd ~/traffic-violation-detection-ccm
screen -dmSL ccm npm start

echo "Initializing Camera Module..."
cd ~/traffic-violation-detector-cm
screen -dmSL cm flask/bin/python app.py 

echo "Traffic violation detection system started"