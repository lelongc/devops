#!/bin/bash
# Kubernetes Cluster Management Script
# Quản lý Kubernetes deployments và services

ACTION="$1"
NAMESPACE="${2:-default}"
APP_NAME="$3"

usage() {
    echo "Usage: $0 {deploy|scale|rollback|status|logs} [namespace] [app_name]"
    exit 1
}

# Deploy application
k8s_deploy() {
    MANIFEST="$1"
    NAMESPACE="$2"
    
    echo "Deploying to Kubernetes namespace: $NAMESPACE"
    
    kubectl apply -f "$MANIFEST" -n "$NAMESPACE"
    
    if [ $? -eq 0 ]; then
        echo "✓ Deployment successful"
        
        # Wait for rollout
        kubectl rollout status deployment/"$APP_NAME" -n "$NAMESPACE"
    else
        echo "✗ Deployment failed"
        exit 1
    fi
}

# Scale deployment
k8s_scale() {
    APP_NAME="$1"
    REPLICAS="$2"
    NAMESPACE="$3"
    
    echo "Scaling $APP_NAME to $REPLICAS replicas..."
    
    kubectl scale deployment "$APP_NAME" --replicas="$REPLICAS" -n "$NAMESPACE"
    
    if [ $? -eq 0 ]; then
        echo "✓ Scaling completed"
    else
        echo "✗ Scaling failed"
        exit 1
    fi
}

# Rollback deployment
k8s_rollback() {
    APP_NAME="$1"
    NAMESPACE="$2"
    
    echo "Rolling back $APP_NAME..."
    
    kubectl rollout undo deployment/"$APP_NAME" -n "$NAMESPACE"
    
    if [ $? -eq 0 ]; then
        echo "✓ Rollback completed"
        kubectl rollout status deployment/"$APP_NAME" -n "$NAMESPACE"
    else
        echo "✗ Rollback failed"
        exit 1
    fi
}

# Get cluster status
k8s_status() {
    NAMESPACE="$1"
    
    echo "Kubernetes Cluster Status"
    echo "========================="
    
    echo -e "\nNodes:"
    kubectl get nodes
    
    echo -e "\nPods in namespace $NAMESPACE:"
    kubectl get pods -n "$NAMESPACE"
    
    echo -e "\nDeployments:"
    kubectl get deployments -n "$NAMESPACE"
    
    echo -e "\nServices:"
    kubectl get services -n "$NAMESPACE"
}

# Get pod logs
k8s_logs() {
    APP_NAME="$1"
    NAMESPACE="$2"
    
    POD=$(kubectl get pods -n "$NAMESPACE" -l "app=$APP_NAME" -o jsonpath='{.items[0].metadata.name}')
    
    if [ -n "$POD" ]; then
        echo "Logs for $POD:"
        kubectl logs "$POD" -n "$NAMESPACE" --tail=100
    else
        echo "No pods found for app: $APP_NAME"
    fi
}

# Health check
k8s_health_check() {
    NAMESPACE="$1"
    
    echo "Running health checks..."
    
    # Check for unhealthy pods
    UNHEALTHY=$(kubectl get pods -n "$NAMESPACE" --field-selector=status.phase!=Running --no-headers 2>/dev/null | wc -l)
    
    if [ "$UNHEALTHY" -gt 0 ]; then
        echo "⚠ $UNHEALTHY unhealthy pods found"
        kubectl get pods -n "$NAMESPACE" --field-selector=status.phase!=Running
    else
        echo "✓ All pods are healthy"
    fi
}

# Auto-scaling setup
k8s_setup_autoscaling() {
    APP_NAME="$1"
    MIN_REPLICAS="${2:-2}"
    MAX_REPLICAS="${3:-10}"
    CPU_PERCENT="${4:-80}"
    NAMESPACE="$5"
    
    echo "Setting up autoscaling for $APP_NAME..."
    
    kubectl autoscale deployment "$APP_NAME" \
        --min="$MIN_REPLICAS" \
        --max="$MAX_REPLICAS" \
        --cpu-percent="$CPU_PERCENT" \
        -n "$NAMESPACE"
    
    echo "✓ Autoscaling configured"
}

# Main
case "$ACTION" in
    deploy)
        k8s_deploy "deployment.yaml" "$NAMESPACE"
        ;;
    scale)
        k8s_scale "$APP_NAME" 5 "$NAMESPACE"
        ;;
    rollback)
        k8s_rollback "$APP_NAME" "$NAMESPACE"
        ;;
    status)
        k8s_status "$NAMESPACE"
        ;;
    logs)
        k8s_logs "$APP_NAME" "$NAMESPACE"
        ;;
    health)
        k8s_health_check "$NAMESPACE"
        ;;
    autoscale)
        k8s_setup_autoscaling "$APP_NAME" 2 10 80 "$NAMESPACE"
        ;;
    *)
        usage
        ;;
esac
