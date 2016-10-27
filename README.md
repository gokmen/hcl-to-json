# hcl-to-json

[![Build Status](https://travis-ci.org/gokmen/hcl-to-json.svg?branch=master)](https://travis-ci.org/gokmen/hcl-to-json)
[![NPM version](https://img.shields.io/npm/v/hcl-to-json.svg?style=flat-square)](https://www.npmjs.com/package/hcl-to-json)

[HCL](https://github.com/hashicorp/hcl) to JSON converter for JS applications.

HCL (HashiCorp Configuration Language) is a configuration language built by
HashiCorp. The goal of HCL is to build a structured configuration language
that is both human and machine friendly for use with command-line tools,
but specifically targeted towards DevOps tools, servers, etc.

HCL is also fully JSON compatible. That is, JSON can be used as completely
valid input to a system expecting HCL. This helps makes systems
interoperable with other systems.

# Getting started

You can install with `npm i hcl-to-json -g` then simply require and pass HCL
content to get JSON output. _If you have a bad HCL content it's suggested to
call in `try .. catch` block_

```coffee

hcltojson = require 'hcltojson'

hcltojson """

foo "bar" {
  baz = 123
  tex = ["one", "two"]
  mon "test" {
    lar = "bar"
  }
}

"""
```

will return following JSON object:

```json
{
  "foo": {
    "bar": {
      "baz": 123,
      "tex": [
        "one",
        "two"
      ],
      "mon": {
        "test": {
          "lar": "bar"
        }
      }
    }
  }
}

```

or you can use the `hcltojson` cli for any hcl formatted file or standart
input;

```
$ npm install hcl-to-json -g
$ echo "foo=3" | hcltojson
{
    "foo": 3
}

$ echo "foo bar { baz = 123 }" > test.tf
$ hcltojson test.tf
{
    "foo": {
        "bar": {
            "baz": 123
        }
    }
}
```

In browser you may include the `dist/bundle.js` which will export `hcltojson`
function into `window`. You can also try it in your browser from
https://runkit.com/npm/hcl-to-json

# Syntax

It currently supports the high-level features of the syntax and grammar of HCL.
Syntax details can be found [here](https://github.com/hashicorp/hcl#syntax)

# Status

It's **experimental** now and in early stages of development, but supports
lots of samples listed under
[test](https://github.com/gokmen/hcl-to-json/tree/master/test) folder.

# Development

You can use `DEBUG="hcltojson:*" npm test watch` while developing for live
compile and test results with debug output.

# License

MIT (c) 2016 Gokmen Goksel
