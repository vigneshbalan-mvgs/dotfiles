#!/bin/bash

delay() {
	sleep 2
	exec "$@" &
}

delay kitty btop --utf-force
