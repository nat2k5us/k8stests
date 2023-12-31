package main

import (
	"fmt"
	"io/ioutil"
	"net/http"
	"sync"
	"testing"
	"time"
)

var urls = []string{
	"https://golang.org",
	"https://godoc.org",
	"http://gopl.io",
	"http://google.com",
}

func httpGetBody(url string) func() ([]byte, error) {
	return func() ([]byte, error) {
		resp, err := http.Get(url)
		if err != nil {
			return nil, err
		}
		fmt.Println(url)
		defer resp.Body.Close()
		return ioutil.ReadAll(resp.Body)
	}
}

func incomingURLs() <-chan string {
	ch := make(chan string)
	go func() {
		for _, url := range urls {
			ch <- url
		}
		close(ch)
	}()
	return ch
}

func TestSequential(t *testing.T) {
	cache := NewCache()
	for url := range incomingURLs() {
		func(url string) {
			start := time.Now()
			value, err := cache.Get(url, httpGetBody(url))
			if err != nil {
				t.Error(err)
			}
			fmt.Printf("%s %s %d bytes\n", url, time.Since(start), len(value))
		}(url)
	}
}

func TestConcurrent(t *testing.T) {
	cache := NewCache()
	var n sync.WaitGroup
	for url := range incomingURLs() {
		n.Add(1)
		go func(url string) {
			defer func() {
				if r := recover(); r != nil {
					n.Done()
				}
			}()
			start := time.Now()
			value, err := cache.Get(url, httpGetBody(url))
			if err != nil {
				t.Error(err)
			}
			fmt.Printf("%-25s %-15s %d bytes\n", url, time.Since(start), len(value))
			n.Done()
		}(url)
	}
	n.Wait()
}
