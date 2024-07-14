echo "Build tracke app image"
docker build -t tracker:v1 .
echo "Run tracker from docker image"
docker run tracker:v1