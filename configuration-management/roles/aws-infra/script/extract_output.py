import json
import sys
import os


def main():
    # Check args
    if len(sys.argv) != 2:
        sys.exit(1)

    SSH_KEY_PATH=f"./demo-infra"
    output_file=f"{os.path.dirname(__file__)}/../../../secrets/hosts.ini"

    # Simulate reading JSON data (you can load it from a file or command output)
    public_ip = sys.argv[1]

    with open(output_file, "w") as f:
        f.write(f""" 
[minikube]
minikube-host ansible_host={public_ip} ansible_user=ubuntu ansible_ssh_private_key_file={SSH_KEY_PATH}
""".strip())

if __name__ == "__main__":
    main()