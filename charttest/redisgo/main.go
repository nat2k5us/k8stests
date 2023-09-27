package main

import (
	"context"
	"fmt"
	"net/http"
	"os"

	"github.com/go-redis/redis/v8"
)

var WELCOME_MESSAGE = "Welcome to Redis with Go on Docker Desktop\n"
var ctx = context.Background()
func hello(w http.ResponseWriter, req *http.Request) {

	fmt.Fprintf(w, "hello world\n")
}

func checkRedis(w http.ResponseWriter, req *http.Request) {
	opts := redis.Options{
		Addr:     "redis-master.default.svc.cluster.local:6379",
		Password: os.Getenv("REDIS_PASSWORD"),
		DB:       0,
	}
	redisClient := redis.NewClient(&opts)
	err := redisClient.Set(ctx, "key", WELCOME_MESSAGE, 0).Err()
	if err != nil {
		fmt.Fprint(w, "panicked "+err.Error())
		panic(err)
	}

	val, err := redisClient.Get(ctx, "key").Result()
	if err != nil {
		fmt.Fprint(w, "panicked "+err.Error())
		panic(err)
	}
	fmt.Fprint(w, "Value from redis: "+val)
}

func main() {
	
	http.HandleFunc("/hello", hello)
	http.HandleFunc("/redis", checkRedis)
	http.ListenAndServe(":8090", nil)
}