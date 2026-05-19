#!/bin/bash

# Setup local bin directory for binaries
mkdir -p bin
export PATH=$PWD/bin:$PATH

# Install helm if not available
if ! command -v helm &> /dev/null; then
  echo "Installing helm..."
  curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
  chmod 700 get_helm.sh
  HELM_INSTALL_DIR=$PWD/bin ./get_helm.sh --no-sudo
fi

# Install kubectl if not available
if ! command -v kubectl &> /dev/null; then
  echo "Installing kubectl..."
  curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
  chmod +x kubectl
  mv kubectl bin/
fi

# Export KUBECONFIG if it exists
if [ -f "../configs/config" ]; then
  export KUBECONFIG="$PWD/../configs/config"
  echo "Using KUBECONFIG=$KUBECONFIG"
fi

# Update vars.yaml with variables provided by Jenkins parameters
cat <<EOF > vars.yaml
k8s_namespace: "${NAMESPACE:-hadoop1}"
replicas: ${REPLICAS:-2}
EOF

echo "Variables configured:"
cat vars.yaml

# Run the Ansible playbook
ansible-playbook -i inventory playbook.yaml
