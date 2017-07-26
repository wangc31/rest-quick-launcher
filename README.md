# rest-quick-launcher
1. Build the image
```
docker build . -t rest-quick-launcher
```
2. Prepare the configuration files in <CONFIG_DIR>
```
.
├── dfc.properties
└── rest-api-runtime.properties
```
3. Prepare the WAR file in <WAR_DIR>
```
.
└── dctm-rest.war
```

4. Run the container 
```
docker run -it -p 8888:8080 --rm -v <CONFIG_DIR>:/tmp/config -v <WAR_DIR>:/tmp/war rest-quick-launcher
```
