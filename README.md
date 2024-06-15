# nixos-in-10-minutes

A simple repo which makes it easy to bring up a NixOS instance in 10 minutes. This is based on
nixos-anywhere.

Prerequisites:
- `docker` and `docker-compose` running on the local machine
- a remote linux VM in which the root account can be accessed via ssh

How this works:
- bring up the docker container which provides a flake enabled nix environment
- create a new ssh key inside the container and put the pubkey on the remote VM in the root account
- check the disk configuration
- run nixos-anywhere

See this post for more details.

DO THIS

https://github.com/seanrmurphy/nixos-in-10-minutes.git
cd nixos-in-10-minutes/docker
docker compose run --rm nixos-anywhere

mkdir -p /root/.config/nix
echo experimental-features = nix-command flakes > /root/.config/nix/nix.conf

# the following is required on an aarch64 machine building x86_64 binaries

echo filter-syscalls = false >> /root/.config/nix/nix.conf
cat /root/.config/nix/nix.conf
nix shell nixpkgs#jq
jq

ssh-keygen
cat /root/.ssh/id_ed25519.pub

ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIASmQy+YhNo6spFGwNrUjtBHgQBIsCj2GjBQ8wM1KPKc
test ssh 192.168.1.17

lsblk

/dev/sda

In the above, the device is called vda; it is often sda depending on where your VM lives — just make sure to have consistency between the name of the block device as seen from the VM and as specified in the nixos-anywhere/disk-config.nix file (on the line device = lib.mkDefault “/dev/sda”).Note that you may need to run a shell with an editor when making changes inside the container — use

nix shell nixpkgs#vim

exit

pwd
cd
cd /root

git clone https://github.com/seanrmurphy/nixos-in-10-minutes.git

cd nixos-in-10-minutes/nixos-anywhere/
nix run github:nix-community/nixos-anywhere -- --flake .#nixos-anywhere-vm root@192.168.1.17

ssh 192.168.1.17
