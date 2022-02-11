from os import *
import os
import yaml

from kubernetes import client, config


def main():
    # Configs can be set in Configuration class directly or using helper
    # utility. If no argument provided, the config will be loaded from
    # default location.
    config.load_incluster_config()

    os.system('mkdir -p /home/user1/myfolder/subfolder')
    os.system('chown -R 5000:5000 /home/user1/myfolder/subfolder')
    os.system('touch /home/user1/myfolder/subfolder/fileFromPythonCode.txt')


    with open(path.join(path.dirname(__file__), "/home/user1/myfolder/nginx-deployment.yaml")) as f:
        dep = yaml.safe_load(f)
        k8s_apps_v1 = client.AppsV1Api()
        resp = k8s_apps_v1.create_namespaced_deployment(
            body=dep, namespace="default")
        print("Deployment created. status='%s'" % resp.metadata.name)


if __name__ == '__main__':
    main()
