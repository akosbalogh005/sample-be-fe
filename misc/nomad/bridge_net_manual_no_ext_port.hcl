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
      dns {
        servers = ["172.18.0.1"]
      }      
    }

    service {
      name     = "backend-outern-service"
      provider = "consul"
      port     = "9090"
      address = "10.11.0.240"

      meta {
      	description = "backend test service (outern)"
      	name = "backend-test"
      }
      check {
      	type = "http"
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
        #ports = ["9090"]
        load  = "backend-test.tar"
        network_mode = "sdrf_default2"
        dns_servers = ["172.18.0.1"]
        ipv4_address = "172.18.0.10"
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
        port     = "9090"
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
      dns {
        servers = ["172.18.0.1"]
      }        
    }

    service {
      name     = "frontend-outern-service"
      provider = "consul"
      port     = "8080"
      address = "10.11.0.241"

      meta {
      	description = "frontend test service (outern)"
      	name = "frontend-test-outern"
      }
      check {
      	type = "http"
        path = "/health"
      	interval = "30s"
      	timeout = "2s"
      }      
    }


    task "frontend-test-task" {
      driver = "docker"
      env {
        BACKEND_URL_EXTERNAL = "http://10.11.0.240:9090"
        BACKEND_URL_INTERNAL = "http://172.18.0.10:9090"        
        PORT = "8080"        
      }

      meta {
        wg_ipv4_address = "10.11.0.241"
      }

      config {               
        image = "frontend-test:latest"
        #ports = ["8080"]
        load  = "frontend-test.tar"
        network_mode = "sdrf_default2"
        dns_servers = ["172.18.0.1"]
        ipv4_address = "172.18.0.11"      
  
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
      service {
        name     = "frontend-inner-service"
        provider = "consul"
        port     = "8080"
        address_mode = "driver"
        meta {
          description = "frontend test service (inner)"
          name = "frontend-test-inner"
        }
        check {
          type = "http"
          port = "8080"
          address_mode="driver"
          path = "/health"
          interval = "30s"
          timeout = "2s"
        }      
    }        
    }
  }
}