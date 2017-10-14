module.exports = ["""
foo="bar"
bar="${file("bing/bong.txt")}"
foo-bar="baz"
"""

"""
key "" {
  policy = "read"
}

key "foo/" {
  policy = "write"
}

key "foo/bar/" {
  policy = "read"
}

key "foo/bar/baz" {
  policy = "deny"
}
"""

"""
foo = "bar"
bar = "${file("bing/bong.txt")}"
"""

"""
variable "foo" {
    default = "bar"
    description = "bar"
}

variable "amis" {
    default = {
        east = "foo"
    }
}
"""

"""
resource "foo" {   }
"""

"""
foo = "bar"
Key = 7
"""

"""
a = 1.02
"""

"""
foo = <<EOF
    bar foo
    o

  baz
EOF
"""

"""
a = 1e-10
b = 1e+10
c = 1e10
d = 1.2e-10
e = 1.2e+10
f = 1.2e10
"""

"""
foo {
  key = 7
}

foo {
  foo = "bar"
}
"""

"""
bar "foo" {

    name = "terraform_example"

    ingress {
        from_port = 22
    }

    ingress {
        from_port = 80
    }

    ingress {
        from_port = 51
    }

}
"""

"""
foo "baz" {
    key = 7
}

foo "bar" {
    key = 12
}
"""

"""
foo "bar" "baz" {
  key = 4
}

foo "bar" "qux" {
  key = 5
}

foo "bar" "biz" {
  key = 11
}

bar "foo" "qux" {
  key = 8
}

bar "foo" "biz" {
  key = 9
  key2 = 3
}

baz "foo" "biz" {
  key = 9
  key5 = "somestring"
}
"""

"""
// This is a test structure for the lexer
foo "baz" {
  key = 7
  foo = "bar"
}
"""

"""
name = "terraform-test-app"

config_vars {
    FOO = "bar"
}
"""

"""
// This is a test structure for the lexer
foo "baz" {
  key = 7
  foo = "bar"
}

foo {
  key = 7
}
"""

"""
variable "key" {
  type = "string"
}

variable "images" {
  type = "map"

  default = {
    us-east-1 = "image-1234"
    us-west-2 = "image-4567"
  }
}

variable "zones" {
  default = ["us-eas:t-1a", "us-east-1b"]
}
"""

"""
data "template_file" "example" {
  template = "${hello} ${world}!"
  vars {
    hello = "goodnight"
    world = "moon"
    foo = true
  }
}

output "rendered" {
  value = "${data.template_file.example.rendered}"
}
"""

"""
variable "ami" {
  description = "the AMI to use"
}

resource "aws_instance" "web" {
  ami               = "${var.ami}"
  count             = 2
  source_dest_check = false

  connection {
    user = "root"
  }
}
"""

"""
# An AMI
variable "ami" {
  description = "the AMI to use"
}

/* A multi
   line comment. */
resource "aws_instance" "web" {
  ami               = "${var.ami}"
  count             = 2
  source_dest_check = false

  connection {
    user = "root"
  }
}
"""

"""
variable "count" {
  default = 2
}

resource "aws_instance" "web" {
  // ...
  count = "${var.count}"

  // tag the instance with a counter starting at 1, ie. web-001
  tags {
    Name = "${format("web-%03d", count.index + 1)}"
  }
}
"""

"""
# Declare the data source
data "aws_availability_zones" "available" {}

# e.g. Create subnets in the first two available availability zones

resource "aws_subnet" "primary" {
  availability_zone = "${data.aws_availability_zones.available.names[0]}"

  # Other properties...
}

resource "aws_subnet" "secondary" {
  availability_zone = "${data.aws_availability_zones.available.names[1]}"

  # Other properties...
}
"""

"""

data "aws_caller_identity" "current" { }

output "account_id" {


  value = "${data.aws_caller_identity.current.account_id}"
}


"""

"""
# Create a new Web Droplet in the nyc2 region
resource "digitalocean_droplet" "web" {
    image = "ubuntu-14-04-x64"
    name = "web-1"
    region = "nyc2"
    size = "512mb"
}
"""

"""
# Create a new domain record
resource "digitalocean_domain" "default" {
    name = "www.example.com"
    ip_address = "${digitalocean_droplet.foo.ipv4_address}"
}

# Add a record to the domain
resource "digitalocean_record" "foobar" {
    domain = "${digitalocean_domain.default.name}"
    type = "A"
    name = "foobar"
    value = "192.168.0.11"
}

"""

"""
resource "google_compute_instance_template" "foobar" {
  name           = "foobar"
  machine_type   = "n1-standard-1"
  can_ip_forward = false

  tags = ["foo", "bar"]

  disk {
    source_image = "debian-cloud/debian-8"
  }

  network_interface {
    network = "default"
  }

  metadata {
    foo = "bar"
  }

  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }
}

resource "google_compute_target_pool" "foobar" {
  name = "foobar"
}

resource "google_compute_instance_group_manager" "foobar" {
  name = "foobar"
  zone = "us-central1-f"

  instance_template  = "${google_compute_instance_template.foobar.self_link}"
  target_pools       = ["${google_compute_target_pool.foobar.self_link}"]
  base_instance_name = "foobar"
}

resource "google_compute_autoscaler" "foobar" {
  name   = "foobar"
  zone   = "us-central1-f"
  target = "${google_compute_instance_group_manager.foobar.self_link}"

  autoscaling_policy = {
    max_replicas    = 5
    min_replicas    = 1
    cooldown_period = 60

    cpu_utilization {
      target = 0.5
    }
  }
}
"""

"""
foo = ["bar"]
value "baz" {
  foo = "barbaz"
}
"""

"""
data "aws_cloudformation_stack" "network" {
    name = "my-network-stack"
}

resource "aws_instance" "web" {
    ami = "ami-abb07bcb"
    instance_type = "t1.micro"
    subnet_id = "${data.aws_cloudformation_stack.network.outputs["SubnetId"]}"
    tags {
        Name = "HelloWorld"
    }
}

"""

"""

foo = "bar"
xyz = "abc"
somelist = [
  "one",
  "two",
]
somemap = {
  foo = "bar"
  bax = "qux"
}
"""

"""
# Create a new instance of the latest Ubuntu 14.04 on an
# t1.micro node with an AWS Tag naming it "HelloWorld"
provider "aws" {
    region = "us-east-1"
}

data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name = "name"
    values = ["ubuntu/images/ebs/ubuntu-trusty-14.04-amd64-server-*"]
  }
  filter {
    name = "virtualization-type"
    values = ["paravirtual"]
  }
  filter {
    name = "virtuasdfsdflization-type"
    values = ["paravirtual", "SDFSDF"]
  }
  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
    ami = "${data.aws_ami.ubuntu.id}"
    instance_type = "t1.micro"
    tags {
        Name = "HelloWorld"
    }
}
"""

"""
data "aws_billing_service_account" "main" { }

SPACE "aws_s3_bucket" "billing_logs" {
    bucket = "my-billing-tf-test-bucket"
    acl = "private"
    policy = <<POLICY
{
  "Id": "Policy",
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:GetBucketAcl", "s3:GetBucketPolicy"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::my-billing-tf-test-bucket",
      "Principal": {
        "AWS": [
          "${data.aws_billing_service_account.main.id}"
        ]
      }
    },
    {
      "Action": [
        "s3:PutObject"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::my-billing-tf-test-bucket/AWSLogs/*",
      "Principal": {
        "AWS": [
          "${data.aws_billing_service_account.main.id}"
        ]
      }
    }
  ]
}
POLICY
}
"""

"""
foo "bar" {
  baz = 123
  tex = ["one", "two"]
  mon {
    "test" {
      lar = "one"
    }
  }
  mon "test" {
    lar = "two"
  }
}
"""

"""
resource "aws_instance" "web" {
    provisioner "chef"  {
        attributes_json = <<EOF
        {
            "key": "value",
            "app": {
                "cluster1": {
                    "nodes": [
                        "webserver1",
                        "webserver2"
                    ]
                }
            }
        }
EOF
        environment = "_default"
        run_list = ["cookbook::recipe"]
        node_name = "webserver1"
        secret_key = "${file("../encrypted_data_bag_secret")}"
        server_url = "https://chef.company.com/organizations/org1"
        recreate_client = true
        user_name = "bork"
        user_key = "${file("../bork.pem")}"
        version = "12.4.1"
    }
}
"""

"""
group "test" {
  task "a" {
    name = "A"
  }

  task "b" {
    name = "B"
  }

  task "c" {
    name = "C"
  }
}
"""

"""
int = 123
# Padded comment
#
foo = "bar"
"""

"""
emptyString = ""
numberZero = 0
"""

"""
# comment here
hello = "#hello" # hello comment
# some more comment 'foo bar'
foo = "# some more #comment foo bar"
"""

"""
resource "foo" "bar" {
  baz = "${test "foo," "comma" in a sentence}"
  bak = "${test "bar:" "column" in a sentence}"
  worked = true
}
"""

"""
resource "aws_iam_role" "child_instance_roles" {
  count              = "${length(split(",", var.child["instance_policy_paths"]))}"
  name               = "${element(split(",", var.child["instance_policy_names"]), count.index)}"
  assume_role_policy = "${data.aws_iam_policy_document.ec2_assume_role.json}"
}
"""

"""
resource "aws_autoscaling_group" "example" {
  name = "example"
  foo = "bar"

  tags = [
    {
      key = "tag1"
      value = "value1"
      propagate_at_launch = true
    },
    {
      key = "tag2"
      value = "value2"
      propagate_at_launch = true
    },
  ]
}
"""

]
