FROM ballerina/ballerina:2201.12.10

WORKDIR /app

# Copy project files
COPY Ballerina.toml .
COPY src/ src/

# Expose service port
EXPOSE 8080

# Run the service directly
CMD ["bal", "run", "src/service/service.bal"]
