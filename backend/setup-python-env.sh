ve=".venv"
deactivate
if [ -f "requirements.txt" ]; then
    echo "INFO: requirements.txt detected"
    if [ -d $ve ]; then
        echo "INFO: Virtual environment detected. Activating and installing packages..." && . $ve/bin/activate && pip install -r requirements.txt && echo "SUCCESS: Finished and installed required Python packages. Use deactivate to turn off virtual environment." && return
        echo "ERROR: The setup is interrupted. See error message above." && return
    else
        echo "INFO: No virtual environment yet. Will create one for you and install required Python package..."
        python3 -m venv $ve && . $ve/bin/activate && pip install -r requirements.txt && echo "SUCCESS: Finished and installed required Python packages. Use deactivate to turn off virtual environment." && return
        echo "ERROR: The setup is interrupted. See error message above." && return
    fi
else 
    echo "ERROR: Please provide requirements.txt"
fi