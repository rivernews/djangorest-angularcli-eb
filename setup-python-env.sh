if [ -f "requirements.txt" ]; then
    echo "requirements.txt detected"
    if [ -d ".venv" ]; then
        . .venv/bin/activate && pip install -r requirements.txt
        echo "finished and installed required Python packages. Please check and try to run your code."
        echo "use deactivate to turn off virtual environment."
    else
        echo "will create virtual environment and install required Python package for you ..."
        python3 -m venv .venv && . .venv/bin/activate && pip install -r requirements.txt
        if [ -d ".venv" ]; then
            echo "finished and installed required Python packages. Please check and try to run your code."
            echo "use deactivate to turn off virtual environment."
        else
            echo "failed creating virtual environment!"
        fi
    fi
else 
    echo "please provide requirements.txt"
fi