#!/bin/bash

# fetch shell config file from arguments
configFile=$1
[ -z "$configFile" ] && configFile=~/.zshrc

# Install kubernetes if not already installed
package_name=kubectl
t=`which $package_name`
[ -z "$t" ] && brew install kubectl

# check if curl is installed already
package_name=curl
t=`which $package_name`
[ -z "$t" ] && brew install curl

# krew install
(
  set -x; cd "$(mktemp -d)" &&
  OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
  ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
  KREW="krew-${OS}_${ARCH}" &&
  curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/download/v0.4.3/${KREW}.tar.gz" &&
  tar zxvf "${KREW}.tar.gz" &&
  ./"${KREW}" install krew
)
# USE below url instead of `https://github.com/kubernetes-sigs/krew/releases/download/v0.4.3/${KREW}.tar.gz` if you want latest changes
# https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz

# Appending krew path to zshrc file replace this ~/.zshrc with your system main file
# like ~/.bashrc or ~/.profile
echo 'export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"' >> $configFile

# reload configFile for Krew installation
source $configFile

# Install oidc-login plugin for kubernetes to validate your system
kubectl krew install oidc-login

# Now load kubernetes config file defined specifically for your setup
curl <configUrl> -o ~/.kube/config --create-dirs

# kubernetes more plugins ns and ctx
kubectl krew install ctx ns

# load aliases to default shell configuration
mv ./aliases ~/.kubeAliases
echo "source ~/.kubeAliases" >> $configFile

# kubetail installation
brew tap johanhaleby/kubetail && brew install kubetail