POST requests
=============

* on succes, returns 201:
  ```
  $ curl -i -H 'Authorization: Token token="..."' \
    -H 'Accept: application/json' -H 'Content-Type: application/json' \
    -X POST -d '{"author": {"name": "foo"}}' \
    http://localhost:3000/authors
  HTTP/1.1 201 Created
  Content-Type: application/json; charset=utf-8

  {"author":{"id":1,"name":"foo"}}
  ```

* /sounds requires multipart/form-data (RFC 2388) body:
  ```
  $ curl -i -H 'Authorization: Token token="..."' \
    -H 'Accept: application/json' -H 'Content-Type: multipart/form-data' \
    -F 'sound[file]=@sound_test_file' \
    -X POST http://localhost:3000/sounds
  HTTP/1.1 201 Created
  Content-Type: application/json; charset=utf-8

  {"sound":{"id":1,"sha256":"f2ca1bb6c7e907d06dafe4687e579fce76b37e4e93b7605022da52e6ccc26fd2","mime_type":"application/octet-stream"}}
  ```

bugs
----

* FIXME: POST sounds can return 500:
  ```
  $ curl -i -H 'Authorization: Token token="..."' \
    -H 'Accept: application/json' -H 'Content-Type: multipart/form-data' \
    -F 'sound=@sound_test_file' \
    -X POST http://localhost:3000/sounds
  HTTP/1.1 500 Internal Server Error

  {"status":"500","error":"Internal Server Error"}
  ```

errors
------

* empty JSON returns 400:
  ```
  $ curl -i -H 'Authorization: Token token="..."' \
    -H 'Accept: application/json' -H 'Content-Type: application/json' \
    -X POST -d '{}' http://localhost:3000/authors
  HTTP/1.1 400 Bad Request
  Content-Type: application/json; charset=utf-8

  {"status":"400","error":"Bad Request"}
  ```

* on unknown request, returns 400:
  ```
  $ curl -i -H 'Authorization: Token token="..."' \
    -H 'Accept: application/json' -H 'Content-Type: application/json' \
    -X POST -d '{"author_": {"name": "foo"}}' \
    http://localhost:3000/authors
  HTTP/1.1 400 Bad Request
  Content-Type: application/json; charset=utf-8

  {"status":"400","error":"Bad Request"}
  ```

* on invalid and/or missing params, returns 422:
  ```
  $ curl -i -H 'Authorization: Token token="..."' \
    -H 'Accept: application/json' -H 'Content-Type: application/json' \
    -X POST -d '{"author": {"foo": "bar"}}' \
    http://localhost:3000/authors
  HTTP/1.1 422 Unprocessable Entity
  Content-Type: application/json; charset=utf-8

  {"name":["can't be blank"]}
  ```

* duplicate will produce the same results as invalid params, 422:
  ```
  $ curl -i -H 'Authorization: Token token="..."' \
    -H 'Accept: application/json' -H 'Content-Type: application/json' \
    -X POST -d '{"author": {"name": "foo"}}' \
    http://localhost:3000/authors
  HTTP/1.1 422 Unprocessable Entity
  Content-Type: application/json; charset=utf-8

  {"name":["has already been taken"]}
  ```
