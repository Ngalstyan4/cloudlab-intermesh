#!/bin/sh

set -x

# Grab our libs
. "`dirname $0`/setup-lib.sh"

if [ -f $OURDIR/intermesh-done ]; then
    exit 0
fi

logtstart "intermesh"

cd ~
# install istio
curl -L https://istio.io/downloadIstio | sh -
echo 'PATH="$PATH:$HOME/istio-1.16.0/bin"' >> .bashrc

istioctl install --set profile=demo -y
kubectl label namespace default istio-injection=enabled

INTERMESH_KEY="./deploy_keys/intermesh_id_ed25519"
DEATHSTARBENCH_KEY="./deploy_keys/deathstarbench_id_ed25519"

git clone git@github.com:Ngalstyan4/DeathStarBench4intermesh.git --config core.sshCommand="ssh -i $DEATHSTARBENCH_KEY"
mkdir intermesh_universe
cd intermesh_universe

git clone git@github.com:lloydbrownjr/intermesh.git --config core.sshCommand="ssh  -i $INTERMESH_KEY"