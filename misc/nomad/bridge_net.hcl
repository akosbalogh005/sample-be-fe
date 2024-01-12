job "test-backend-frontend-docker-bridge" {
  datacenters = ["acme"]
  type        = "service"
  constraint {
          attribute = "${meta.node_type}"
          operator = "regexp"
          value =  "aio"
  }

  group "backend-test-group" {
    count = 1

    network {
      mode = "test-bridge-net"
      port "api" {
        to     = 9090
        static = 9090
      }
      dns {
        servers = ["172.17.0.1", "8.8.8.8", "8.8.4.4"]
      }      
    }

    service {
      name     = "backend-test-service"
      provider = "consul"
      port     = "api"
      meta {
      	description = "backend test service"
      	name = "backend-test"
      }
      check {
      	type = "http"
      	port = "api"
        path = "/health"
      	interval = "30s"
      	timeout = "2s"
      }      
      connect {
        sidecar_service {}
      }       

    }


    task "backend-test-task" {
      driver = "docker"
      env {
        PORT = "9090"
      }

      config {
        image = "backend-test:latest"
        ports = ["api"]
        load  = "backend-test.tar"
        network_mode = "test-bridge-net"
      }

      artifact {
                source = "https://repository.rcs.internal/artifacts/images/tmp/backend-test.tar"
                options {
                  archive = "false"
                }
                destination = "local/"
      }

      resources {
        cores  = 1
        memory = 256
      }
    }
  }

  group "frontend-test-group" {
    count = 1

    network {
      mode = "btest-bridge-netridge"
      port "web" {
        to     = 8080
        static = 8080
      }
    }

    service {
      name     = "frontend-test-service"
      provider = "consul"
      port     = "web"
      meta {
      	description = "frontend test service"
      	name = "frontend-test"
      }
      check {
      	type = "http"
      	port = "web"
        path = "/health"
      	interval = "30s"
      	timeout = "2s"
      	timeout = "2s"
      }     
      connect {
        sidecar_service {}
      }       
    }


    task "frontend-test-task" {
      driver = "docker"
      env {
        BACKEND_URL = "http://backend-test-service.service.consul:9090"
        PORT = "8080"        
      }

      config {
        image = "frontend-test:latest"
        ports = ["web"]
        load  = "frontend-test.tar"
        dns_servers = ["172.17.0.1"]
        network_mode = "test-bridge-net"
      }

      artifact {
                source = "https://repository.rcs.internal/artifacts/images/tmp/frontend-test.tar"
                options {
                  archive = "false"
                }
                destination = "local/"
      }

      resources {
        cores  = 1
        memory = 256
      }
    }
  }
}