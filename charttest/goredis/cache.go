package main

import "sync"

type Cache struct {
	cache map[string]*entry
	sync.Mutex
}

type entry struct {
	res   result
	ready chan struct{}
}

type result struct {
	value []byte
	err   error
}

type Func func() ([]byte, error)

func NewCache() *Cache {
	return &Cache{cache: make(map[string]*entry)}
}

func (c *Cache) Get(key string, f Func) ([]byte, error) {
	c.Lock()
	e := c.cache[key]
	if e == nil {
		e = &entry{ready: make(chan struct{})}
		c.cache[key] = e
		c.Unlock()

		e.res.value, e.res.err = f()
		close(e.ready)
	} else {
		c.Unlock()
		<-e.ready
	}
	return e.res.value, e.res.err

}

// func (c *Cache) Get(key string, f Func) ([]byte, error) {
// 	c.Lock()
// 	// defer c.Unlock()
// 	res, ok := c.cache[key]
// 	c.Unlock()
// 	if !ok {
// 		res = &result{}
// 		res.value, res.err = f()
// 		c.Lock()
// 		c.cache[key] = res
// 		c.Unlock()
// 	}
// 	return res.value, res.err
// }
