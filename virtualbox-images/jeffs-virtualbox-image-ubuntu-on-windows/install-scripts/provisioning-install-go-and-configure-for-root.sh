#!/bin/sh -e
# provisioning-install-go-and-configure-for-root.sh

FileName='go1.26.2.linux-amd64.tar.gz'

echo " "
echo "************************************************************************"
echo "************ provisioning-install-go-and-configure-for-root.sh (START) *"
echo "Running as $(whoami) in $(pwd)"
echo " "

echo "Download $FileName (wget quiet mode)"
cd /tmp
wget -q https://go.dev/dl/$FileName
echo " "

echo "Remove current version of go in /usr/local/go"
rm -rf /usr/local/go
echo " "

echo "Untar $FileName and move to /usr/local"
tar -C /usr/local -xzf $FileName
echo " "

echo "Clean up tarball..."
rm /tmp/$FileName
echo " "

echo "Add go environment variables to /root/.bashrc..."
cat >> /root/.bashrc << 'EOF'

# Go environment
export GOBIN=/root/go/bin
export PATH=/usr/local/go/bin:$PATH
export PATH=$GOBIN:$PATH
EOF
echo " "

echo "Check go version and your go env"
/usr/local/go/bin/go version
/usr/local/go/bin/go env
echo " "

echo "************** provisioning-install-go-and-configure-for-root.sh (END) *"
echo "************************************************************************"
echo " "
