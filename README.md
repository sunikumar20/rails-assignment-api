# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version : 2.7.1p83

* rails db:create
* rails db:migrate
* rails db:seed

# API details
* 1. /api/v1/inbounds/sms
```
     headers: {username: "", password: ""}
     body: {
        "sms": {
          "to": "4924195509198",
          "from": "4924195509198"
        } 
      }
 ```
 * 2. /api/v1/outbounds/sms
```
     headers: {username: "", password: ""}
     body: {
        "sms": {
          "to": "4924195509198",
          "from": "4924195509198"
        } 
      }
 ```
 
