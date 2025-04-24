# Dockerfile.frontend

# -------------------------
# 1. Base image for build tools
# -------------------------
FROM node:20-alpine AS deps
WORKDIR /app

# Install dependencies only when package files change
COPY frontend/package*.json ./
RUN npm ci --production=false

# -------------------------
# 2. Build stage
# -------------------------
FROM node:20-alpine AS builder
WORKDIR /app

# Copy dependencies and source code
COPY --from=deps /app/node_modules ./node_modules
COPY frontend/ ./

# Disable telemetry for clean builds (optional)
# ENV NEXT_TELEMETRY_DISABLED=1

# Build the Next.js application with standalone output
RUN npm run build

# -------------------------
# 3. Production image
# -------------------------
FROM node:20-alpine AS runner
WORKDIR /app

# Create non-root user for security
RUN addgroup -S nextgroup && adduser -S nextuser -G nextgroup

# Copy only the standalone output and static files
COPY --from=builder --chown=nextuser:nextgroup /app/.next/standalone ./
COPY --from=builder --chown=nextuser:nextgroup /app/.next/static ./.next/static
COPY --from=builder --chown=nextuser:nextgroup /app/public ./public

USER nextuser

ENV NODE_ENV=production
ENV PORT=3000
EXPOSE 3000

# Start the Next.js server
CMD ["node", "server.js"]

