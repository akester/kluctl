variable "version" {
  type    = string
  default = "2.27.0"
}

source "docker" "alpine" {
  commit = true
  image  = "alpine:latest"
}

build {
  sources = ["source.docker.alpine"]

  # Upgrade the software
  provisioner "shell" {
    inline = [
      "apk update",
      "apk upgrade",
    ]
  }

  # Install wget to download kluctl
  provisioner "shell" {
    inline = [
      "apk add --no-cache wget",
    ]
  }

# Download and install kluctl
  provisioner "shell" {
    inline           = [
      "wget -nv -O /tmp/kluctl.tar.gz https://github.com/kluctl/kluctl/releases/download/v${var.version}/kluctl_v${var.version}_linux_amd64.tar.gz",
      "cd /tmp && tar -xzvf kluctl.tar.gz",
      "mv /tmp/kluctl /usr/bin/kluctl",
      "chmod 0755 /usr/bin/kluctl",
    ]
  }

  # Remove APK cache for space
  provisioner "shell" {
    inline = [
      "rm -rf /var/cache/apk/*",
    ]
  }

  post-processor "docker-tag" {
    repository = "akester/kluctl"
    tags = [
      "${var.version}",
      "latest"
    ]
  }
}

packer {
  required_plugins {
    docker = {
      version = ">= 0.0.7"
      source  = "github.com/hashicorp/docker"
    }
  }
}
