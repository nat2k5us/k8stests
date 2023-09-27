build:
	go build .

dbuild:
	docker build -t nbontha/redisgo  .  

drun: 
	docker run -p 8090:8090 nbontha/redisgo  

dpush:
	docker push --all-tags nbontha/redisgo