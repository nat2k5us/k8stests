package main

import (
	"context"
	"fmt"
	"net/http"
	"os"

	"cloud.google.com/go/pubsub"
	"github.com/go-redis/redis/v8"
)

var ctx = context.Background()
var WELCOME_MESSAGE = "Hello world 12/08/2021\n"

func hello(w http.ResponseWriter, req *http.Request) {

	fmt.Fprintf(w, "hello\n")
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


func checkPubSub(w http.ResponseWriter, req *http.Request) {
	os.Setenv("PUBSUB_EMULATOR_HOST", "pub-sub-emulator.default.svc.cluster.local:8085")
	ctx := context.Background()
	client, err := pubsub.NewClient(ctx, "my-project")
	if err != nil {
		panic(err)
	}
	topic, err := client.CreateTopic(ctx, "my-topic")
	if err != nil {
		panic(err)
	}
	fmt.Fprint(w, "Topic: "+topic.String())
	err = topic.Delete(ctx)
	if err != nil {
		panic(err)
	}
}

func headers(w http.ResponseWriter, req *http.Request) {

	for name, headers := range req.Header {
		for _, h := range headers {
			fmt.Fprintf(w, "%v: %v\n", name, h)
		}
	}
}

func main() {
	
	http.HandleFunc("/hello", hello)
	http.HandleFunc("/redis", checkRedis)
	http.HandleFunc("/pubsub", checkPubSub)
	
	http.HandleFunc("/headers", headers)

	http.ListenAndServe(":8090", nil)
	// Output: key value
	// key2 does not exist
}
