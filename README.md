
## Steps for usage

1. Build image
`docker build -t ct/tinyproxy .`

2. Run container
`docker run -d -p 6666:6666 --rm --name tinyproxy ct/tinyproxy`

3. Set GCP firewall rule to allow traffic.

4. Attach firewall rule to the instance which is running the container.
