module.exports = [{
    "bar": "${file(\"bing/bong.txt\")}",
    "foo": "bar",
    "foo-bar": "baz"
}

{
    "key": {
        "": {
            "policy": "read"
        },
        "foo/": {
            "policy": "write"
        },
        "foo/bar/": {
            "policy": "read"
        },
        "foo/bar/baz": {
            "policy": "deny"
        }
    }
}

{
    "bar": "${file(\"bing/bong.txt\")}",
    "foo": "bar"
}

{
    "variable": {
        "amis": {
            "default": {
                "east": "foo"
            }
        },
        "foo": {
            "default": "bar",
            "description": "bar"
        }
    }
}

{
    "resource": {
        "foo": {}
    }
}

{
    "Key": 7,
    "foo": "bar"
}

{
    "a": 1.02
}

{
    "foo": "    bar foo\n    o\n\n  baz"
}

{
    "a": 1e-10,
    "b": 10000000000,
    "c": 10000000000,
    "d": 1.2e-10,
    "e": 12000000000,
    "f": 12000000000
}

{
    "foo": {
        "foo": "bar",
        "key": 7
    }
}

{
    "bar": {
        "foo": {
            "ingress": [
                {
                    "from_port": 22
                },
                {
                    "from_port": 80
                },
                {
                    "from_port": 51
                }
            ],
            "name": "terraform_example"
        }
    }
}

{
    "foo": {
        "bar": {
            "key": 12
        },
        "baz": {
            "key": 7
        }
    }
}

{
    "bar": {
        "foo": {
            "biz": {
                "key": 9,
                "key2": 3
            },
            "qux": {
                "key": 8
            }
        }
    },
    "baz": {
        "foo": {
            "biz": {
                "key": 9,
                "key5": "somestring"
            }
        }
    },
    "foo": {
        "bar": {
            "baz": {
                "key": 4
            },
            "biz": {
                "key": 11
            },
            "qux": {
                "key": 5
            }
        }
    }
}

{
    "foo": {
        "baz": {
            "foo": "bar",
            "key": 7
        }
    }
}

{
    "config_vars": {
        "FOO": "bar"
    },
    "name": "terraform-test-app"
}

{
    "foo": {
        "baz": {
            "foo": "bar",
            "key": 7
        },
        "key": 7
    }
}

{
    "variable": {
        "images": {
            "default": {
                "us-east-1": "image-1234",
                "us-west-2": "image-4567"
            },
            "type": "map"
        },
        "key": {
            "type": "string"
        },
        "zones": {
            "default": [
                "us-eas:t-1a",
                "us-east-1b"
            ]
        }
    }
}

{
    "data": {
        "template_file": {
            "example": {
                "template": "${hello} ${world}!",
                "vars": {
                    "foo": true,
                    "hello": "goodnight",
                    "world": "moon"
                }
            }
        }
    },
    "output": {
        "rendered": {
            "value": "${data.template_file.example.rendered}"
        }
    }
}

{
    "resource": {
        "aws_instance": {
            "web": {
                "ami": "${var.ami}",
                "connection": {
                    "user": "root"
                },
                "count": 2,
                "source_dest_check": false
            }
        }
    },
    "variable": {
        "ami": {
            "description": "the AMI to use"
        }
    }
}

{
    "resource": {
        "aws_instance": {
            "web": {
                "ami": "${var.ami}",
                "connection": {
                    "user": "root"
                },
                "count": 2,
                "source_dest_check": false
            }
        }
    },
    "variable": {
        "ami": {
            "description": "the AMI to use"
        }
    }
}

{
    "resource": {
        "aws_instance": {
            "web": {
                "count": "${var.count}",
                "tags": {
                    "Name": "${format(\"web-%03d\", count.index + 1)}"
                }
            }
        }
    },
    "variable": {
        "count": {
            "default": 2
        }
    }
}

{
    "data": {
        "aws_availability_zones": {
            "available": {}
        }
    },
    "resource": {
        "aws_subnet": {
            "primary": {
                "availability_zone": "${data.aws_availability_zones.available.names[0]}"
            },
            "secondary": {
                "availability_zone": "${data.aws_availability_zones.available.names[1]}"
            }
        }
    }
}

{
    "data": {
        "aws_caller_identity": {
            "current": {}
        }
    },
    "output": {
        "account_id": {
            "value": "${data.aws_caller_identity.current.account_id}"
        }
    }
}

{
    "resource": {
        "digitalocean_droplet": {
            "web": {
                "image": "ubuntu-14-04-x64",
                "name": "web-1",
                "region": "nyc2",
                "size": "512mb"
            }
        }
    }
}

{
    "resource": {
        "digitalocean_domain": {
            "default": {
                "ip_address": "${digitalocean_droplet.foo.ipv4_address}",
                "name": "www.example.com"
            }
        },
        "digitalocean_record": {
            "foobar": {
                "domain": "${digitalocean_domain.default.name}",
                "name": "foobar",
                "type": "A",
                "value": "192.168.0.11"
            }
        }
    }
}

{
    "resource": {
        "google_compute_autoscaler": {
            "foobar": {
                "autoscaling_policy": {
                    "cooldown_period": 60,
                    "cpu_utilization": {
                        "target": 0.5
                    },
                    "max_replicas": 5,
                    "min_replicas": 1
                },
                "name": "foobar",
                "target": "${google_compute_instance_group_manager.foobar.self_link}",
                "zone": "us-central1-f"
            }
        },
        "google_compute_instance_group_manager": {
            "foobar": {
                "base_instance_name": "foobar",
                "instance_template": "${google_compute_instance_template.foobar.self_link}",
                "name": "foobar",
                "target_pools": [
                    "${google_compute_target_pool.foobar.self_link}"
                ],
                "zone": "us-central1-f"
            }
        },
        "google_compute_instance_template": {
            "foobar": {
                "can_ip_forward": false,
                "disk": {
                    "source_image": "debian-cloud/debian-8"
                },
                "machine_type": "n1-standard-1",
                "metadata": {
                    "foo": "bar"
                },
                "name": "foobar",
                "network_interface": {
                    "network": "default"
                },
                "service_account": {
                    "scopes": [
                        "userinfo-email",
                        "compute-ro",
                        "storage-ro"
                    ]
                },
                "tags": [
                    "foo",
                    "bar"
                ]
            }
        },
        "google_compute_target_pool": {
            "foobar": {
                "name": "foobar"
            }
        }
    }
}

{
    "foo": [
        "bar"
    ],
    "value": {
        "baz": {
            "foo": "barbaz"
        }
    }
}

{
    "data": {
        "aws_cloudformation_stack": {
            "network": {
                "name": "my-network-stack"
            }
        }
    },
    "resource": {
        "aws_instance": {
            "web": {
                "ami": "ami-abb07bcb",
                "instance_type": "t1.micro",
                "subnet_id": "${data.aws_cloudformation_stack.network.outputs[\"SubnetId\"]}",
                "tags": {
                    "Name": "HelloWorld"
                }
            }
        }
    }
}

{
    "foo": "bar",
    "somelist": [
        "one",
        "two"
    ],
    "somemap": {
        "bax": "qux",
        "foo": "bar"
    },
    "xyz": "abc"
}

{
    "data": {
        "aws_ami": {
            "ubuntu": {
                "filter": [
                    {
                        "name": "name",
                        "values": [
                            "ubuntu/images/ebs/ubuntu-trusty-14.04-amd64-server-*"
                        ]
                    },
                    {
                        "name": "virtualization-type",
                        "values": [
                            "paravirtual"
                        ]
                    },
                    {
                        "name": "virtuasdfsdflization-type",
                        "values": [
                            "paravirtual",
                            "SDFSDF"
                        ]
                    }
                ],
                "most_recent": true,
                "owners": [
                    "099720109477"
                ]
            }
        }
    },
    "provider": {
        "aws": {
            "region": "us-east-1"
        }
    },
    "resource": {
        "aws_instance": {
            "web": {
                "ami": "${data.aws_ami.ubuntu.id}",
                "instance_type": "t1.micro",
                "tags": {
                    "Name": "HelloWorld"
                }
            }
        }
    }
}

{
    "data": {
        "aws_billing_service_account": {
            "main": {}
        }
    },
    "SPACE": {
        "aws_s3_bucket": {
            "billing_logs": {
                "acl": "private",
                "bucket": "my-billing-tf-test-bucket",
                "policy": "{\n  \"Id\": \"Policy\",\n  \"Version\": \"2012-10-17\",\n  \"Statement\": [\n    {\n      \"Action\": [\n        \"s3:GetBucketAcl\", \"s3:GetBucketPolicy\"\n      ],\n      \"Effect\": \"Allow\",\n      \"Resource\": \"arn:aws:s3:::my-billing-tf-test-bucket\",\n      \"Principal\": {\n        \"AWS\": [\n          \"${data.aws_billing_service_account.main.id}\"\n        ]\n      }\n    },\n    {\n      \"Action\": [\n        \"s3:PutObject\"\n      ],\n      \"Effect\": \"Allow\",\n      \"Resource\": \"arn:aws:s3:::my-billing-tf-test-bucket/AWSLogs/*\",\n      \"Principal\": {\n        \"AWS\": [\n          \"${data.aws_billing_service_account.main.id}\"\n        ]\n      }\n    }\n  ]\n}"
            }
        }
    }
}

{
    "foo": {
      "bar": {
          "baz": 123,
          "mon": [
              {
                  "test": {
                      "lar": "one"
                  }
              },
              {
                  "test": {
                      "lar": "two"
                  }
              }
          ],
          "tex": [
              "one",
              "two"
          ]
      }
  }
}

{
    "resource": {
        "aws_instance": {
            "web": {
                "provisioner": {
                    "chef": {
                        "attributes_json": "        {\n            \"key\": \"value\",\n            \"app\": {\n                \"cluster1\": {\n                    \"nodes\": [\n                        \"webserver1\",\n                        \"webserver2\"\n                    ]\n                }\n            }\n        }",
                        "environment": "_default",
                        "node_name": "webserver1",
                        "recreate_client": true,
                        "run_list": [
                            "cookbook::recipe"
                        ],
                        "secret_key": "${file(\"../encrypted_data_bag_secret\")}",
                        "server_url": "https://chef.company.com/organizations/org1",
                        "user_key": "${file(\"../bork.pem\")}",
                        "user_name": "bork",
                        "version": "12.4.1"
                    }
                }
            }
        }
    }
}

{
  "group": {
       "test": {
           "task": [
               {
                   "a": {
                       "name": "A"
                   }
               },
               {
                   "b": {
                       "name": "B"
                   }
               },
               {
                   "c": {
                       "name": "C"
                   }
               }
           ]
       }
   }
}

{
  int: 123,
  foo: "bar"
}

{
  emptyString: "",
  numberZero: 0
}

{
  hashTag: "#asdf"
  foo: "bar\"asd"
}

{
  multiLineArray: ["#one", "#two", "#three", "#four"]
}
]
