# 1. use sudo
# 2. docker installed
apt-get update && apt-get install -y apt-transport-https
curl -fsSL https://mirrors.aliyun.com/kubernetes/apt/doc/apt-key.gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://mirrors.aliyun.com/kubernetes/apt/ kubernetes-xenial main"
apt-get update

# latest version, modifiable
apt-cache madison kubelet kubectl kubeadm | grep 1.18.5-00
apt install -y kubelet=1.18.3-00 kubectl=1.18.3-00 kubeadm=1.18.3-00


tee /etc/default/kubelet <<-'EOF'
KUBELET_EXTRA_ARGS="--fail-swap-on=false"
EOF

systemctl daemon-reload && systemctl restart kubelet

kubeadm init \
  --kubernetes-version=v1.18.3 \
  --image-repository registry.aliyuncs.com/google_containers \
  --pod-network-cidr=10.24.0.0/16 \
  --ignore-preflight-errors=Swap
  
# you can execute below using current account, such as "medit"
mkdir -p $HOME/.kube && sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config && sudo chown $(id -u):$(id -g) $HOME/.kube/config

kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

kubectl taint node --all node-role.kubernetes.io/master-
