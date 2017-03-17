# rest-quick-launcher
1. Build the image
```
docker build . -t rest-quick-launcher
```
2. Prepare the files
```
.
├── dctm-rest.war
├── dfc.properties
└── rest-api-runtime.properties
```

3. Run the container 
```
docker run -it -p 8888:8080 --rm -v `pwd`:/tmp rest-quick-launcher
```
