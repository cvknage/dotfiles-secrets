# `sops-nix`

Configuration for [`sops-nix`](https://github.com/Mic92/sops-nix)

## Manage Secrets

### Generate `age` key pair
``` sh
mkdir -p $XDG_CONFIG_HOME/sops/age
age-keygen -o $XDG_CONFIG_HOME/sops/age/keys.txt
```

### Display `age` public key
``` sh
age-keygen -y $XDG_CONFIG_HOME/sops/age/keys.txt
```

### Edit `sops` secrets
``` sh
sops ./secrets/secrets.yaml
```

### Update keys after adding new host to `.sops.yaml`
``` sh
sops updatekeys ./secrets/secrets.yaml
```

