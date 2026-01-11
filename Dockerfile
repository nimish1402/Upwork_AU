FROM n8nio/n8n:latest

# Set working directory
WORKDIR /data

# Copy workflow files
COPY workflows /data/.n8n/workflows

# Expose n8n port
EXPOSE 5678

# Set environment variables for production
ENV N8N_HOST=0.0.0.0
ENV N8N_PORT=5678
ENV N8N_PROTOCOL=https
ENV NODE_ENV=production

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s \
    CMD wget --no-verbose --tries=1 --spider http://localhost:5678/healthz || exit 1

# Start n8n
CMD ["n8n"]
