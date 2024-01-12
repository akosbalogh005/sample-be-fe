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
      #mode = "bridge"
      port "api" {
        to     = 9090
        static = 19090
      }
      dns {
        servers = ["172.17.0.1"]
      }      
    }

    service {
      name     = "backend-outern-service"
      provider = "consul"
      port     = "api"
      address = "10.11.0.240"

      meta {
      	description = "backend test service (outern)"
      	name = "backend-test"
      }
      check {
      	type = "http"
      	port = "9090"
        path = "/health"
      	interval = "30s"
      	timeout = "2s"
      }      
    }

    task "backend-test-task" {
      driver = "docker"
      env {
        PORT = "9090"
      }

      meta {
        wg_ipv4_address = "10.11.0.240"
      }

      config {
        image = "backend-test:latest"
        ports = ["api"]
        load  = "backend-test.tar"
        network_mode = "sdrf_default"
        dns_servers = ["172.17.0.1"]
        ipv4_address = "172.17.0.10"

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
        name     = "backend-inner-service"
        provider = "consul"
        port     = "api"
        address_mode = "driver"
        meta {
          description = "backend test service (inner)"
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

  group "frontend-test-group" {
    count = 1

    network {
      #mode = "my-bridge-net"
      port "web" {
        to     = 8080
        static = 18080
      }
      dns {
        servers = ["172.17.0.1"]
      }        
    }

    service {
      name     = "frontend-outern-service"
      provider = "consul"
      port     = "web"
      address = "10.11.0.241"

      meta {
      	description = "frontend test service (outern)"
      	name = "frontend-test"
      }
      check {
      	type = "http"
      	port = "8080"
        path = "/health"
      	interval = "30s"
      	timeout = "2s"
      }      
    }


    task "frontend-test-task" {
      driver = "docker"
      env {
        BACKEND_URL_EXTERNAL = "http://10.11.0.240:9090"
        BACKEND_URL_INTERNAL = "http://172.17.0.10:9090"        
        PORT = "8080"        
      }

      meta {
        wg_ipv4_address = "10.11.0.241"
      }

      config {
        image = "frontend-test:latest"
        ports = ["web"]
        load  = "frontend-test.tar"
        network_mode = "sdrf_default"
        dns_servers = ["172.17.0.1"]
        ipv4_address = "172.17.0.11"      
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