#!/usr/bin/env node

var handleInput, readInput, usage;

readInput = function(filename, callback) {
  var fs, readFile, readStdin;
  fs = require('fs');
  readFile = function() {
    return fs.readFile(filename, 'utf8', function(err, text) {
      if (err) {
        console.error("Couldn't read file " + filename);
        console.error(err.message);
      }
      return callback(err, text);
    });
  };
  readStdin = function() {
    var stdin, text;
    text = '';
    stdin = process.stdin;
    stdin.resume();
    stdin.on('data', function(chunk) {
      return text += chunk;
    });
    return stdin.on('end', function() {
      return callback(null, text);
    });
  };
  if (filename) {
    return readFile();
  } else {
    return readStdin();
  }
};

usage = function() {
  console.warn('Usages:');
  console.warn('hcltojson example.tf');
  return console.warn('cat example.tf | hcltojson');
};

handleInput = function(err, hclinput) {
  var data, hcltojson;
  if (err) {
    return usage();
  }
  hcltojson = require('../lib');
  data = hcltojson(hclinput);
  return console.log(JSON.stringify(data, ' ', 4));
};

(function() {
  var filename;
  filename = process.argv[2];
  return readInput(filename, handleInput);
})();
