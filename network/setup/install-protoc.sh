#! /bin/bash


# Needed only if you want to play with protocol buffers

sudo apt-get install unzip

curl -OL https://github.com/google/protobuf/releases/download/v3.6.1/protoc-3.6.1-linux-x86_64.zip

# Unzip
unzip protoc-3.6.1-linux-x86_64.zip -d protoc3

# Move protoc to /usr/local/bin/
sudo mv protoc3/bin/* /usr/local/bin/

# Move protoc3/include to /usr/local/include/
sudo mv protoc3/include/* /usr/local/include/

# Optional: change owner
sudo chown $USER /usr/local/bin/protoc
sudo chown -R $USER /usr/local/include/google

rm -rf protoc3
rm -rf *.zip

# get the go generator
# go install github.com/golang/protobuf/protoc-gen-go
# sudo mv $GOPATH/bin/protoc-gen-go  /usr/local/bin
# sudo chmod +x /usr/local/bin/protoc-gen-go