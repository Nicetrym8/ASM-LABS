# For macocь arm64 users docker is your savior

## Build docker image
```
docker build -t amd64linux .
```
## Run docker 
```
docker run --rm -it --platform linux/amd64 -v your_path_to_asmlab_folder:/root/ amd64linux bash
```

Enjoy :)
