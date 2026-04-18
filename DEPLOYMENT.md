# Deployment Guide for Restaurant Ordering System

This guide follows the deployment demo from the YouTube video.

## Prerequisites

- Docker and Docker Compose installed
- Docker Hub account
- Cloud platform account (Railway, Render, AWS, etc.)

## Local Testing

1. Update environment variables:

   ```bash
   # Backend .env
   ALLOW_ORIGIN=http://localhost:8080
   DATABASE_URL=mysql://root:root@mysql:3306/qfood

   # Frontend .env
   VUE_APP_API_BASE_URL=http://localhost:8081
   ```

2. Run the application:
   ```bash
   docker-compose up --build
   ```

## Production Deployment

### Step 1: Build and Push Docker Images

1. Set your Docker Hub username:

   ```bash
   export DOCKER_USERNAME=your-dockerhub-username
   ```

2. Run the deployment script:

   ```bash
   ./deploy.sh
   ```

   Or manually:

   ```bash
   # Build images
   docker build -t $DOCKER_USERNAME/restaurant-backend:latest ./backend
   docker build -f ./frontend/Dockerfile.prod -t $DOCKER_USERNAME/restaurant-frontend:latest ./frontend

   # Push images
   docker push $DOCKER_USERNAME/restaurant-backend:latest
   docker push $DOCKER_USERNAME/restaurant-frontend:latest
   ```

### Step 2: Deploy to Cloud Platform

#### Option A: Railway (Recommended)

1. Go to [Railway.app](https://railway.app) and sign up
2. Connect your GitHub repository
3. Railway will automatically detect `docker-compose.yml`
4. Set environment variables in Railway dashboard:
   - `ALLOW_ORIGIN`: Your Railway frontend URL
   - `DATABASE_URL`: Railway will provide a PostgreSQL database

#### Option B: Render

1. Go to [Render.com](https://render.com) and sign up
2. Create a new "Web Service" for backend
3. Connect your GitHub repo and select Docker
4. Set environment variables
5. Repeat for frontend service

#### Option C: AWS ECS

1. Create ECR repositories for frontend and backend
2. Push images to ECR
3. Create ECS cluster and services
4. Configure load balancer and domain

### Step 3: Database Setup

For production, use a managed database service:

- Railway PostgreSQL (automatic)
- AWS RDS
- Google Cloud SQL
- PlanetScale

Update the `DATABASE_URL` in your deployment environment.

### Step 4: Environment Variables

Production environment variables:

**Backend:**

```
ALLOW_ORIGIN=https://your-frontend-domain.com
DATABASE_URL=postgresql://user:password@host:5432/database
PORT=8081
```

**Frontend:**

```
VUE_APP_API_BASE_URL=https://your-backend-domain.com
```

### Step 5: Domain and SSL

- Configure custom domain in your cloud platform
- SSL certificates are usually automatic

## Testing Deployment

1. Access your frontend URL
2. Test user registration and login
3. Test menu browsing and ordering
4. Verify database operations

## Troubleshooting

- Check container logs in your cloud platform
- Verify environment variables are set correctly
- Ensure database is accessible from the backend
- Check CORS settings match your domain

## Cost Optimization

- Use Railway Hobby plan for development (~$5/month)
- Scale down when not in use
- Monitor usage and adjust resources as needed
