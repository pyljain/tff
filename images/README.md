# Container images for the experimentation environment

### Building container images

To build a container image for the TFF remote executer execute the following command from the `executor_image` folder:

```
PROJECT_ID=<your-project-id>
IMAGE_NAME=gcr.io/$PROJECT_ID/remote-executor

docker build -t $IMAGE_NAME .
docker push $IMAGE_NAME
```

To build a container image for the JupyterLab server execute the following command from the `jupyterlab_image` folder:

```
PROJECT_ID=<your-project-id>
IMAGE_NAME=gcr.io/$PROJECT_ID/jupyterlab

docker build -t $IMAGE_NAME .
docker push $IMAGE_NAME
```

