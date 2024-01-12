job "test-backend-frontend-docker-bridge1" {
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
      mode = "bridge"
    port "api" {
        to     =9090
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
        network_mode = "bridge"
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

      service {
        name     = "backend-inner"
        provider = "consul"
        port     = "api"
        address_mode = "driver"
        meta {
          description = "backend test service"
          name = "backend-test"
        }
        check {
          type = "http"
          port = "9090"
          address_mode="driver"
          path = "/health"
          interval = "30s"
          timeout = "2s"
        }      
    }      
    }
  }

}