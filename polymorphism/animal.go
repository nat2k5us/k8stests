package main

import (
	"fmt"
)

type Animal interface {
	NumberOfLegs() int
	Name() string
}

type Dog struct {
	numberOfLegs int
	name         string
}

type Eagle struct {
	numberOfLegs int
	name         string
}

type Horse struct {
	numberOfLegs int
	name         string
}

func (c Dog) NumberOfLegs() int {
	return 4
}
func (c Dog) Name() string {
	return "Dog"
}

func (b Eagle) NumberOfLegs() int {
	return 2
}
func (c Eagle) Name() string {
	return "Eagle"
}

func (a Horse) NumberOfLegs() int {
	return 4
}
func (c Horse) Name() string {
	return "Horse"
}

func displayInfo(a []Animal) {
	for _, pass := range a {
		fmt.Printf("No of legs in %s are %d \n", pass.Name(), pass.NumberOfLegs())
	}
}

func main() {
	animal1 := Dog{}
	animal2 := Eagle{}
	animal3 := Horse{}

	animals := []Animal{animal1, animal2, animal3}
	displayInfo(animals)
}
