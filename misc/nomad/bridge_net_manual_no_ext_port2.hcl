job "test-backend-frontend-docker-bridge2" {
  datacenters = ["acme"]
  type        = "service"
  constraint {
          attribute = "${meta.node_type}"
          operator = "regexp"
          value =  "aio"
  }

  group "backend-test-group2" {
    count = 1

    network {
      #mode = "bridge"
      dns {
        servers = ["172.18.0.1"]
      }      
    }

    service {
      name     = "backend-outern-service2"
      provider = "consul"
      port     = "9090"
      address = "10.11.0.242"

      meta {
      	description = "backend test service (outern)2"
      	name = "backend-test2"
      }
      check {
      	type = "http"
        path = "/health"
      	interval = "30s"
      	timeout = "2s"
      }      
    }

    task "backend-test-task2" {
      driver = "docker"
      env {
        PORT = "9090"
      }

      meta {
        wg_ipv4_address = "10.11.0.242"
      }

      config {
        image = "backend-test:latest"
        #ports = ["9090"]
        load  = "backend-test.tar"
        network_mode = "sdrf_default2"
        dns_servers = ["172.18.0.1"]
        ipv4_address = "172.18.0.12"
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
        name     = "backend-inner-service2"
        provider = "consul"
        port     = "9090"
        address_mode = "driver"
        meta {
          description = "backend test service (inner)2"
          name = "backend-test2"
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

  group "frontend-test-group2" {
    count = 1

    network {
      #mode = "my-bridge-net"
      dns {
        servers = ["172.18.0.1"]
      }        
    }

    service {
      name     = "frontend-outern-service2"
      provider = "consul"
      port     = "8080"
      address = "10.11.0.243"

      meta {
      	description = "frontend test service (outern)2"
      	name = "frontend-test-outern2"
      }
      check {
      	type = "http"
        path = "/health"
      	interval = "30s"
      	timeout = "2s"
      }      
    }


    task "frontend-test-task2" {
      driver = "docker"
      env {
        BACKEND_URL_EXTERNAL = "http://10.11.0.242:9090"
        BACKEND_URL_INTERNAL = "http://172.18.0.12:9090"        
        PORT = "8080"        
      }

      meta {
        wg_ipv4_address = "10.11.0.243"
      }

      config {               
        image = "frontend-test:latest"
        #ports = ["8080"]
        load  = "frontend-test.tar"
        network_mode = "sdrf_default2"
        dns_servers = ["172.18.0.1"]
        ipv4_address = "172.18.0.13"      
  
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
          description = "frontend test service (inner)2"
          name = "frontend-test-inner2"
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