#!/bin/bash

export AUTO_POWER_DIR=`cd $(dirname "$0"); pwd`


echo "Updating Automated Power Modeling submodules..."
git submodule update --init --recursive

# Verify Python is installed as python3
if [ -n "$(command -v python3)" ]; then
  PYTHON_CMD="python3"
# Verify Python 3 is installed as python
elif [ -n "$(command -v python3)" ] && python -V 2>&1 | grep -q "Python 3"; then
  PYTHON_CMD="python"
else
  echo "Python 3 is not installed. Install Python to use CPUPowerSeer."
  exit 1
fi

# Verify venv is installed
if ! "${PYTHON_CMD}" -c "import venv" 2>/dev/null; then
  echo "'venv' module is not installed. Please install venv using pip to run CPUPowerSeer."
  exit 1
fi

# CPUPowerSeer
echo "Installing CPUPowerSeer in a virtual environment"
if [ -d "${AUTO_POWER_DIR}/my_venv" ]; then
  echo "Default virtual environment directory already exists. Removing ${AUTO_POWER_DIR}/my_venv"
  rm -rf "${AUTO_POWER_DIR}"/my_venv
fi
python -m venv my_venv
source my_venv/bin/activate
pip install "${AUTO_POWER_DIR}"/CPUPowerSeer/
echo -e "\n\nCPUPowerSeer successfully installed in virtual environment 'my_venv'. Activate it running:"
echo -e "\tsource my_venv/bin/activate\e[0m"
echo "Then you can run CPUPowerSeer using 'powerseer' command"
