# Persistent mode
nvidia-smi -pm ENABLED -i 0

# Check available memory choices
nvidia-smi -q -i 0 -d SUPPORTED_CLOCKS

# Set clockrate to one of them
sudo nvidia-smi -ac 715,1328 -i 0

