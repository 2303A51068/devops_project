#!/bin/bash

# Deployment script for Restaurant Ordering System
# This script builds Docker images and pushes them to Docker Hub

set -e

# Configuration
DOCKER_USERNAME=${DOCKER_USERNAME:-"your-dockerhub-username"}
IMAGE_TAG=${IMAGE_TAG:-"latest"}

echo "🚀 Starting deployment process..."

# Build backend image
echo "📦 Building backend image..."
docker build -t $DOCKER_USERNAME/restaurant-backend:$IMAGE_TAG ./backend

# Build frontend production image
echo "📦 Building frontend image..."
docker build -f ./frontend/Dockerfile.prod -t $DOCKER_USERNAME/restaurant-frontend:$IMAGE_TAG ./frontend

# Push images to Docker Hub
echo "⬆️ Pushing backend image..."
docker push $DOCKER_USERNAME/restaurant-backend:$IMAGE_TAG

echo "⬆️ Pushing frontend image..."
docker push $DOCKER_USERNAME/restaurant-frontend:$IMAGE_TAG

echo "✅ Deployment images built and pushed successfully!"
echo ""
echo "Next steps:"
echo "1. Create a Docker Hub repository for your images"
echo "2. Deploy to your preferred cloud platform (Railway, Render, AWS, etc.)"
echo "3. Set environment variables:"
echo "   - ALLOW_ORIGIN: your frontend URL"
echo "   - DATABASE_URL: your production database URL"
echo ""
echo "For Railway deployment:"
echo "1. Connect your GitHub repository"
echo "2. Railway will automatically detect docker-compose.yml"
echo "3. Set environment variables in Railway dashboard"