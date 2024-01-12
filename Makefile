build:
	go mod tidy
	go build -ldflags "-s -w -X main.VERSION=$(VERSION)" -o bin/backend ./backend
	go build -ldflags "-s -w -X main.VERSION=$(VERSION)" -o bin/frontend ./frontend

test:
	echo "No Tests"

docker:
	docker build -t sample-be:latest -f Dockerfile.backend .
	docker build -t sample-fe:latest -f Dockerfile.frontend .
