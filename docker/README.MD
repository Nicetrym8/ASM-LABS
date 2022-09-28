# For macocь arm64 users docker is your savior

## Build docker image
```
docker build -t amd64linux .
```
## Run docker 
```
docker run --rm -it --platform linux/amd64 --name x86linux -v path_to_asm_labs:/root/ amd64linux bash
```

Enjoy :)
