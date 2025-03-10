FROM node:20-slim

WORKDIR /directus

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    && rm -rf /var/lib/apt/lists/*

COPY . .
RUN npm ci --omit=optional && npm run build

# Copy custom schema
COPY custom/schema.json /directus/custom/

EXPOSE 8055
CMD ["sh", "-c", "npx directus bootstrap && npx directus schema apply --yes /directus/custom/schema.json && npx directus start"]