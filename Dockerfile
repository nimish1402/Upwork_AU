FROM n8nio/n8n:latest

# Set environment variables for production
ENV N8N_HOST=0.0.0.0
ENV N8N_PORT=5678
ENV N8N_PROTOCOL=https
ENV NODE_ENV=production
ENV N8N_DIAGNOSTICS_ENABLED=false

# Copy workflow files (optional - can also import via UI)
# COPY workflows /home/node/.n8n/workflows

# Expose n8n port
EXPOSE 5678

# Use the default entrypoint and command from the base image
# The n8nio/n8n image already has the proper CMD configured
