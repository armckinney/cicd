package main

import "testing"

func TestGreet(t *testing.T) {
	expected := "Hello, World!"
	actual := Greet("World")
	if actual != expected {
		t.Errorf("expected %q, got %q", expected, actual)
	}
}
