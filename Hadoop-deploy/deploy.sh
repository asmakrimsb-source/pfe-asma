#!/bin/bash

# Update vars.yaml with variables provided by Jenkins parameters
cat <<EOF > vars.yaml
namespace: "${NAMESPACE:-hadoop1}"
replicas: ${REPLICAS:-2}
EOF

echo "Variables configured:"
cat vars.yaml

# Run the Ansible playbook
ansible-playbook -i inventory playbook.yaml
