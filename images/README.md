# Container images for the experimentation environment

### Building container images

To build a container image for the TFF remote executor execute the following command:

```
PROJECT_ID=<your-project-id>
IMAGE_NAME=gcr.io/$PROJECT_ID/remote-executor

docker build --build-arg VERSION=0.18.0 -t $IMAGE_NAME executor_image
docker push $IMAGE_NAME
```

To build a container image for the JupyterLab server execute the following command:

```
IMAGE_NAME=gcr.io/$PROJECT_ID/jupyterlab

docker build --build-arg VERSION=0.18.0 -t $IMAGE_NAME jupyterlab_image
docker push $IMAGE_NAME
```

