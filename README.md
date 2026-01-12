# Application Deployment Pipeline 🚀

This project demonstrates an **end-to-end workflow** including application deployment, Dockerization, CI/CD using Jenkins, Docker Hub image management, AWS EC2 deployment, and monitoring.

---

## 📌 Application Details

* **Repository Used:**
  [https://github.com/sriram-R-krishnan/devops-build](https://github.com/sriram-R-krishnan/devops-build)

* **Protocol:** HTTP

* **Port:** `80`

The application is cloned from the above repository and deployed as a Dockerized service running on port **80**.

---

## 🐳 Docker Implementation

### Dockerfile

* A `Dockerfile` is created to containerize the application.
* The application runs inside a container exposed on **port 80**.

### Docker Compose

* A `docker-compose.yml` file is created to:

  * Run the application container
  * Simplify deployment and container management

---

## 🖥️ Bash Scripting

Two shell scripts are implemented:

### `build.sh`

* Builds the Docker image
* Tags the image appropriately for **dev** or **prod**

```bash
./build.sh
```

### `deploy.sh`

* Deploys the Docker image on the server using Docker Compose

```bash
./deploy.sh
```

---

## 🌱 Version Control (Git)

* Code is pushed to the **`dev` branch**
* Uses:

  * `.gitignore`
  * `.dockerignore`
* **Only CLI-based Git commands** are used

### Branch Strategy

* `dev` → Development
* `master` → Production

---

## 🐳 Docker Hub Setup

Two Docker Hub repositories are created:

| Environment | Repository Type | Visibility |
| ----------- | --------------- | ---------- |
| dev         | Docker Hub Repo | Public     |
| prod        | Docker Hub Repo | Private    |

### Image Flow

* Push to **dev branch** → Image pushed to **dev Docker Hub repo**
* Merge **dev → master** → Image pushed to **prod Docker Hub repo**

---

## 🔁 Jenkins CI/CD Pipeline

### Jenkins Responsibilities

* Build Docker images
* Push images to Docker Hub
* Deploy the application automatically

### Triggers

* Auto-trigger on push to:

  * `dev`
  * `master`

### Pipeline Logic

* **Dev Branch**

  * Build Docker image
  * Push to **dev Docker Hub repo**
* **Master Branch**

  * Build Docker image
  * Push to **prod Docker Hub repo**
  * Deploy to AWS EC2

---

## ☁️ AWS Deployment

### EC2 Configuration

* Instance Type: **t2.micro**
* OS: Amazon Linux
* Application deployed using Docker

### Security Group Rules

* **Inbound Rules**

  * HTTP (80): Open to all
  * SSH (22): Allowed **only from your IP**
  * Custom TCP (8080) : Jenkins
  * Custom TCP (2812) : Monit

---

## 📊 Monitoring

* Open-source monitoring tool monit is used
* Health checks are configured
* Notifications are sent **only when the application goes down**

---

## 🔗 Access Points
- **App URL**: `http://<EC2-Public-IP>`
- **Jenkins UI**: `http://<EC2-Public-IP>:8080`
- **Monit UI**: `http://<EC2-Public-IP>:2812` (login: `admin/monit`)

---

