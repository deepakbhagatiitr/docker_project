services:
  postgresdb:
    image: "postgres:latest"
    container_name: postgresdb
    environment:
      POSTGRES_USER: ${POSTGRES_USER}
      POSTGRES_PASSWORD: ${POSTGRES_PASSWORD}
      POSTGRES_DB: ${POSTGRES_DB}
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U ${POSTGRES_USER}"]
      timeout: 20s
      retries: 10
    networks:
      - app-network

  pythonapp:
    build: ./
    container_name: pythonapp
    depends_on:
      db:
        condition: service_healthy
    ports:
      - "5000:5000"
    networks:
      - app-network

networks:
  app-network:
    driver: bridge
