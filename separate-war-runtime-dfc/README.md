# rest-quick-launcher
1. Build the image
```
docker build . -t rest-quick-launcher:separate-all
```
2. Prepare the configuration files in <REST_CONFIG_DIR>
```
.
└── rest-api-runtime.properties
```
3. Prepare the configuration files in <DFC_CONFIG_DIR>
```
.
└── dfc.properties
```
4. Prepare the WAR file in <WAR_DIR>
```
.
└── dctm-rest.war
```

4. Run the container 
```
docker run -it -p 8888:8080 --rm -v <REST_CONFIG_DIR>:/tmp/rest/config -v <DFC_CONFIG_DIR>:/tmp/dfc/config -v <WAR_DIR>:/tmp/war rest-quick-launcher:separate-all
```
