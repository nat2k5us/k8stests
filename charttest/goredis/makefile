build:
	go build .
run: build
	go run .
dbuild:
	docker build -t nbontha/goredis -t nbontha/goredis:v1.0.1  .  
dpush:
	docker push --all-tags nbontha/goredis   
drun: 
	docker run -p 8090:8090 nbontha/goredis  
hfa:
	cd helm; helmfile --environment eng apply; cd ..
hfs:
	cd helm; helmfile --environment eng sync; cd ..
hfd:
	cd helm; helmfile destroy; cd ..