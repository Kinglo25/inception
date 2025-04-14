---

# Inception

_Inception_ is a School 42 project designed to teach the fundamentals of containerization, orchestration, and environment management using modern development tools such as Docker and Docker Compose. This project demonstrates how to deploy a multi-container environment that simulates a production-like ecosystem with built-in best practices such as immutability, reproducibility, and scalability.

---

## Table of Contents

- [Introduction](#introduction)
- [Project Description](#project-description)
- [Features](#features)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Configuration](#configuration)
- [Usage](#usage)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [Author](#author)
- [License](#license)

---

## Introduction

In the Inception project, you will learn to build a fully containerized environment. You will understand how different containers can work together, simulate a real-world application stack, and learn how to manage state and resources effectively. This project is an opportunity to practice:
- Creating Docker images
- Working with Docker Compose for multi-container orchestration
- Managing environment variables and configuration files
- Implementing best practices in deployment workflows

---

## Project Description

The project is centered around building a containerized environment that consists of multiple interconnected services. Each service has its dedicated Dockerfile and configuration, ensuring separation of concerns and modularity. The key goal is to demonstrate how containers can be built, deployed, and managed without the use of persistent caches, ensuring that builds are always done from scratch when necessary.

For example, using the following build command bypasses the cache:

```bash
docker-compose build --no-cache
```

This ensures that every time you build the images, you are working with the latest changes and dependencies.

### Services Included
- **Web Application:** The front-end service responsible for the user interface.
- **API Server:** A back-end service that handles API calls and business logic.
- **Database:** A data persistence layer using a relational or NoSQL database.
- **Proxy/Load Balancer:** A service managing network traffic and load balancing between containers.
  
Each service is containerized and orchestrated via Docker Compose.

---

## Features

- **Containerization:** All application components are built as Docker images.
- **Orchestration:** Use of Docker Compose to define and run multi-container applications.
- **Stateless Build Process:** The build process avoids cached layers for a fresh deployment using `--no-cache`.
- **Scalability:** Easy to scale individual services when needed.
- **Modularity:** Clear separation of services for maintainability and testing.
- **Environment Management:** Use of environment variables and configuration files to manage service settings.

---

## Prerequisites

Before setting up the project, ensure that you have the following installed on your development machine:

- [Docker](https://docs.docker.com/get-docker/) (version 20.10+ recommended)
- [Docker Compose](https://docs.docker.com/compose/install/) (version 1.29+ recommended)
- A modern terminal or command line interface
- Basic knowledge of Docker and container management

---

## Installation

1. **Clone the Repository**

   ```bash
   git clone https://github.com/Kingl25/inception.git
   cd inception
   ```

2. **Set Up Environment Variables**

   Copy the sample environment file to create your own configuration:

   ```bash
   cp .env.example .env
   ```

   Adjust the variables inside `.env` as needed (e.g., port numbers, database credentials).

3. **Build the Containers**

   Build the Docker containers without using the cache:

   ```bash
   docker-compose build --no-cache
   ```

4. **Start the Application**

   Launch the application using Docker Compose:

   ```bash
   docker-compose up -d
   ```

   The `-d` flag runs the containers in detached mode.

---

## Configuration

The project’s configuration is managed through environment variables defined in the `.env` file. Each service in the `docker-compose.yml` file reads these variables. Here are some common variables you might set:

- `APP_PORT` – The port on which the web application listens.
- `DB_HOST` – The hostname for the database container.
- `API_KEY` – A sample API key used for authentication (if applicable).

Feel free to modify or extend these settings based on your project needs.

---

## Usage

After starting the services, you can access the application via the web browser using the address defined by `APP_PORT`. You can monitor logs and container statuses with the following commands:

- **View Logs:**

  ```bash
  docker-compose logs -f
  ```

- **Stop Services:**

  ```bash
  docker-compose down
  ```

- **Rebuild & Restart Services:**

  ```bash
  docker-compose up -d --build
  ```

Remember, the `--no-cache` flag is important when you want to ensure no old images interfere with your current build:
  
```bash
docker-compose build --no-cache
```

---

## Troubleshooting

- **Build Errors:**  
  Ensure all dependencies are correctly set and that your Docker daemon is running. Use `docker-compose build --no-cache` to avoid conflicts from cached layers.

- **Container Not Starting:**  
  Review the logs using `docker-compose logs` to identify errors related to misconfiguration or missing environment variables.

- **Port Conflicts:**  
  Double-check that the ports defined in your `.env` file are not in use by another application on your machine.

If you encounter other issues, please refer to the Docker and Docker Compose documentation, as well as the School 42 project guidelines.

---

## Contributing

Contributions and improvements are welcome! If you have suggestions or enhancements, please follow these steps:

1. Fork the repository.
2. Create a new branch (`git checkout -b feature/my-new-feature`).
3. Commit your changes with clear commit messages.
4. Submit a pull request with a detailed description of your changes.

Please adhere to the coding standards and guidelines as prescribed by School 42.

---

## Author

- **Your Name**  
  [GitHub: Kingl25](https://github.com/Kingl25)

This project was developed as part of the curriculum at School 42.

---

## License

Distributed under the MIT License. See `LICENSE` for more information.

---

This README provides a detailed overview of the Inception project, guiding both users and developers through understanding, installing, and contributing to the project. Adjust as necessary to tailor it to your project's specifics and any additional instructions from your curriculum.
