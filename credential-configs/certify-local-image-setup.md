I apologize if the previous response included formatting beyond standard Markdown. I will ensure the following version uses **Markdown only**, suitable for direct sharing in a text file or platform that supports Markdown rendering.

Here is the enhanced and reorganized setup guide in pure Markdown:

# Setup Guide: Custom Plugin with Local `inji-certify` 🚀

This guide outlines how to build a custom plugin, generate a local Docker image for `inji-certify`, and integrate them using the `docker-compose.yaml` file.

-----

## 1\. Modifying and Building the Plugin

These steps prepare your custom plugin JAR file.

### 1.1. Clone the Repository

Get the source code for the plugins.

```bash
git clone https://github.com/mosip/digital-credential-plugins
```

### 1.2. Develop Your Plugin

Create a new project or modify an existing project within the cloned repository.

> **Note:** It is recommended to use plugins that implement the **`DataProviderPlugin`** interface as there is no cache dependency for this particular plugin mode.

**References:**

  - **Mock Plugin Example:** `https://github.com/mosip/digital-credential-plugins/blob/master/mock-certify-plugin/src/main/java/io.mosip.certify.mock.integration/service/MockCSVDataProviderPlugin.java`
  - **Postgres Plugin Structure:** `https://github.com/mosip/digital-credential-plugins/tree/master/postgres-dataprovider-plugin`

### 1.3. Build the Plugin

Navigate to the root of the `digital-credential-plugins` repository and run the build command. This generates the snapshot JAR in your local Maven repository.

```bash
mvn clean install -Dgpg.skip=true
```

-----

## 2\. Building the Local `inji-certify` Docker Image

This creates a fresh Docker image of the Certify service using your latest local code.

### 2.1. Build `inji-certify`

  - Navigate to the **`inji-certify` root folder**.
  - Run the Maven command to build the application:

<!-- end list -->

```bash
mvn clean install -Dgpg.skip=true
```

### 2.2. Generate Docker Image

  - Navigate to the **`certify-service`** directory.
  - Run the Docker build command. Replace `<CONTAINER_NAME>` and `<TAG_NAME>` with your desired values.

<!-- end list -->

```bash
docker build -t <CONTAINER_NAME>:<TAG_NAME> .
```

**Example:** `inji-certify:local` where `inji-certify` is the container name and `local` is the tag.

-----

## 3\. Integrating with `docker-compose.yaml`

Modify the `certify` service definition in your `docker-compose.yaml` file (e.g., in the `docker-compose-injistack` directory) to use the local build and inject your plugin.

### 3.1. Update `certify` Service Configuration

Under the `certify` service definition:

1.  **Replace `image` with `build`:** Change the `image` attribute value to the tag you built (e.g., `mosipdev/inji-certify:release-0.12.x`) and **add the `build` attribute** below it:

    ```yaml
        # BEFORE: image: mosipdev/inji-certify:release-0.12.x
        # AFTER:
        image: <CONTAINER_NAME>:<TAG_NAME> # Example: inji-certify:local
        build:
            context: ../../certify-service
            dockerfile: Dockerfile
    ```

2.  **Uncomment Plugin Volume:** Under the `volumes` section, **uncomment** the line to map your local plugin directory into the container:

    ```yaml
        volumes:
            # ... other volumes
            - ./loader_path/certify/:/home/mosip/additional_jars/
    ```

### 3.2. Place the Plugin JAR

You must place the plugin JAR file built in **Step 1.3** into the mapped local directory.

1.  **Locate the Plugin Path:** The path is relative to your `docker-compose.yaml` file:

    ```
    docker-compose-injistack/
    ├── loader_path/
    │   └── certify/ <-- **Place your plugin JAR file here**
    └── docker-compose.yml
    ```

**Reference of Directory Structure:**

```
docker-compose-injistack/
├── data/
│   └── CERTIFY_PKCS12/
├── certs/
│   └── oidckeystore.p12
├── loader_path/
│   └── certify/ (plugin jar to be placed here)
├── config/
│   ├── certify-default.properties
│   # ... other config files
├── nginx.conf
├── certify_init.sql
└── docker-compose.yml
```

### 3.3. Finalize Setup

  - Ensure you follow any other necessary changes detailed in the `certify` docker-compose readme file.
  - The `config/` directory allows for property file adjustments as per your custom plugin's requirements.