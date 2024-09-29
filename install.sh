#!/bin/bash

echo "Downloading Rollkit source code..."
git clone https://github.com/rollkit/rollkit.git
if ! which go > /dev/null; then
    echo "Go is not installed. Attempting to install Go..."
    curl -sL "https://rollkit.dev/install-go.sh" | sh -s "go1.22.2"
    # Source the updated profile to include Go in the current session
    source ~/.profile
fi

cd rollkit || { echo "Failed to find the downloaded repository."; exit 1; }
git fetch && git checkout $1

echo "Building and installing Rollkit..."
make install

# Add Go bin directory to PATH if not already present
if [[ ":$PATH:" != *":$HOME/go/bin:"* ]]; then
    echo 'export PATH=$PATH:$HOME/go/bin' >> ~/.bashrc
    echo 'export PATH=$PATH:$HOME/go/bin' >> ~/.profile
    # Update PATH for the current session
    export PATH=$PATH:$HOME/go/bin
fi

cd ..
echo "Installation completed successfully."
echo "Please run 'source ~/.bashrc' or start a new terminal session to use Rollkit."
